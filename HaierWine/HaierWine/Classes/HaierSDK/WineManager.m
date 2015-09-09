//
//  WineManager.m
//  HaierWine
//
//  Created by leon on 14-7-24.
//
//

#import "WineManager.h"
#import "ITTObjectSingleton.h"
#import "PushMessage.h"
#import "AppDelegate.h"
#import "MenuViewController.h"
#import <uSDKFramework/uSDKNotificationCenter.h>
typedef void (^finishBinding) ();

@interface WineManager ()
{
    NSMutableArray  *_deviceList;
    NSMutableArray  *_uHomeDeviceList;
    NSArray         *_currentDeviceArray;
    NSString        *_temperature;
    NSString        *_setTemperature;
    NSString        *_isLinghtOn;
    NSString        *_alartMessage;
    NSInteger       _previousTem;
    
    finishBinding   _binding;
    uSDKDevice      *_device;
    
    BOOL            _isBinding;
    BOOL            _isFirstNoti;
    BOOL            _isOn;
    BOOL            _isAlerm;
    BOOL            _isStartSDK;
}
@end

@implementation WineManager

ITTOBJECT_SINGLETON_BOILERPLATE(WineManager, shareWineManager)

- (id)init
{
    self = [super init];
    if (self) {
        //  [self subscribeDeviceListChanged];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(SubscribeDeviceWithDeviceMac:)
                                                     name: UIApplicationWillEnterForegroundNotification       object:nil];
        if (!_deviceList && !_uHomeDeviceList) {
            _deviceList = [[NSMutableArray alloc]init];
            _uHomeDeviceList = [[NSMutableArray alloc]init];
        }
        _isFirstNoti = YES;
        _isAlerm = YES;
        _temperature = @"tem";
        _setTemperature = @"setTem";
        _isLinghtOn = @"0";
        _alartMessage = @"0";
        _isStartSDK = NO;
        
    }
    return self;
}

- (void)subscribeDeviceListChanged
{
    [[uSDKNotificationCenter defaultCenter] subscribeDeviceListChanged:self selector:@selector(deviceListChangedReciveInfo:) withDeviceType:WINE_CABINET];
}

- (void)timing:(NSTimer *)timer
{
    CustomMessageAlertView *alertView = [CustomMessageAlertView loadFromXib];
    alertView.delegate = self;
    alertView.textLabel.text = @"高温报警";
    [[AppDelegate getAppDelegate].window addSubview:alertView];

}
#pragma mark - startConnection

- (void)startConnection
{
    [self startConnection];
    [self performSelector:@selector(subcribe) withObject:nil afterDelay:1];
}

- (void)subcribe
{
    [self SubscribeDeviceWithDeviceMac:nil];
}

- (void)startHaierUSDK
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self subscribeDeviceListChanged];
        uSDKManager *manager = [uSDKManager getSingleInstance];
        uSDKErrorConst error = [manager startSDK];
        while (error != RET_USDK_OK) {
            error = [manager startSDK];
        }
        [manager initLog:USDK_LOG_NONE withWriteToFile:NO];
    });
}

//停止uSDK
- (uSDKErrorConst)stopHaierUSDK
{
    uSDKManager *manager = [uSDKManager getSingleInstance];
    uSDKErrorConst error = [manager stopSDK];
    return error;
}


///////////////////////////////////////////////////////////////////////////////////////////////////

//配置设备到指定wifi
- (void)setConfigLinkSSID:(NSString *)ssid password:(NSString *)pw
{
    //   [self performSelector:@selector(getDeviceListFromHaierUhome) withObject:nil afterDelay:10];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 耗时的操作
        if (ssid.length > 0 && pw.length > 0) {
            uSDKErrorConst error = [HaierSDK setDeviceConfigInfoSSID:ssid andPassword:pw];
            if (error == RET_USDK_OK) {
                //@"搜索uSDK运行成功";
                // [UIAlertView popupAlertByDelegate:nil title: nil message:@"搜索uSDK运行成功"];
            } else {
                //"开启错误了 error:
            }
        } else {
            //tip 缺少密码
        }
        
        
    });
}

//从云平台获取设备列表
- (void)getDeviceListFromHaierUhome
{
    if(DATA_ENV.deviceMac.length == 0){
        [self getWineDeviceList];
    }
}

- (void)deviceListChangedReciveInfo:(NSNotification *)noti
{
    
  //   NSLog(@"111111111111111111111111%@",noti);
    NSMutableArray *data = [[NSMutableArray alloc]init];
    NSDictionary* devLstDict = [uSDKDeviceManager getSingleInstance].deviceDict;
    for (NSString *key in devLstDict) {
        uSDKDevice *device = [devLstDict objectForKey:key];
        [data addObject:device];
    }
    [_deviceList removeAllObjects];
    [_deviceList addObjectsFromArray:[self foundSubcribeDevice:data]];
    [self getMyDeviceWithNewDeviceList:_deviceList];
    
}
//剔除无用重复设备，找到自己想要的设备
- (NSArray *)foundSubcribeDevice:(NSArray *)array
{
    NSMutableArray *data = [[NSMutableArray alloc]init];
    
    for (uSDKDevice *device in array) {
        if (device.status == STATUS_ONLINE && device.type == WINE_CABINET) {
            [data addObject:device];
            
        }
        //        if (DATA_ENV.deviceMac != nil) {
        //            if ([device.mac isEndWithString:DATA_ENV.deviceMac]&&device.status!= STATUS_ONLINE) {
        //               // [[NSNotificationCenter defaultCenter] postNotificationName:@"STATUS_OFFLINE" object:nil];
        //            }
        //        }
    }
    return data;
}


#pragma mark - getDeviceList

- (void)getWineDeviceList
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        _currentDeviceArray = [[uSDKDeviceManager getSingleInstance] getDeviceList:WINE_CABINET];
        //     NSLog(@")))))%@",_currentDeviceArray);
        dispatch_async(dispatch_get_main_queue(), ^{
            for(uSDKDevice *device in _currentDeviceArray){
                if (device.type == WINE_CABINET&&device.mac.length !=0 &&device.status !=3 ){
                    DATA_ENV.deviceMac = device.mac;
                    _device = device;
                    [_delegate findWineDevice:device];
                }
            }
        });
    });
    
}

- (void)getMyDeviceWithNewDeviceList:(NSArray *)deviceList
{
    //  NSMutableArray *
   // NSLog(@"设备列表--%@",deviceList);
    if (DATA_ENV.deviceMac.length == 0){
        for (uSDKDevice *newDevice in deviceList) {
            if (_currentDeviceArray.count == 0 && newDevice.mac.length != 0) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    _device = newDevice;
                    [_delegate findWineDevice:newDevice];
                    
                });
                
            } else {
                for (uSDKDevice *device in deviceList) {
                    if (![newDevice.mac isEqualToString:device.mac]||([newDevice.mac isEqualToString:device.mac]&&(newDevice.status==STATUS_ONLINE || newDevice.status==STATUS_READY))) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            _device = newDevice;
                            [_delegate findWineDevice:newDevice];
                        });
                    }
                }
            }
        }
    } else {
        for (uSDKDevice *device in deviceList) {
            if ([device.mac isEqualToString:DATA_ENV.deviceMac]){
                _device = device;
            }
        }
    }
}
/////////////////////////////////////////////////////////////////////////////////////////////////

//订阅设备
- (void)SubscribeDeviceWithDeviceMac:(NSString *)deviceMac
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 耗时的操作
        if (DATA_ENV.deviceMac) {
            [HaierSDK subscribeDevice:self
                             selector:@selector(finishSubscribeDevice:) withMacList:/*@[@"0007A88A4666"]*/@[DATA_ENV.deviceMac]];

           // NSLog(@"&&&&&&&%@",DATA_ENV.deviceMac);
        }
    });
}

- (void)cancelSubscribeDevice
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        if (DATA_ENV.deviceMac) {
            [[uSDKNotificationCenter defaultCenter] unSubscribeDevice:self withMacList:@[DATA_ENV.deviceMac]];
            DATA_ENV.deviceMac = nil;
        }
    });
}

- (void)finishSubscribeDevice:(NSNotification *)noti
{
  //  [self getWineDeviceList];

    DATA_ENV.isSubcribe = YES;
   // NSLog(@"11111&&&%@",noti);
    if (DATA_ENV.deviceMac.length==0) {
        return;
    }
    NSDictionary* attrDict = [[noti object] objectForKey:DATA_ENV.deviceMac];
    // NSDictionary* attrDict = [[noti object] objectForKey:@"0007A88A4B74"];
    // NSLog(@"222222%@",attrDict);
    //  [[NSNotificationCenter defaultCenter] postNotificationName:@"SHOWDETAILMESSAGE" object:nil userInfo:nil];
    //    if ([[noti name] isEqualToString:@"deviceStatusChangedNotify"]) {
    //
    //    }
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    //    for (NSString * key in attrDict) {
    //        NSLog(@"&&&&%@",key);
    //        uSDKDeviceAttribute * attrObject = [attrDict objectForKey:key];
    //        // NSLog(@"%@:%@",attrObject.attrName, attrObject.attrValue);
    //        [dic setValue:attrObject.attrValue forKey:attrObject.attrName];
    //
    //    }
    
    if([[noti name] isEqualToString:@"deviceStatusChangedNotify"]){
        for (NSString * key in attrDict) {
            uSDKDeviceAttribute * attrObject = [attrDict objectForKey:key];
            [dic setValue:attrObject.attrValue forKey:attrObject.attrName];
            //
        }
        
    } else if([[noti name]isEqualToString:@"deviceAlarmNotify"])
    {
    //    _isAlerm = YES;
        for(uSDKDeviceAlarm *alerm in attrDict)
        {
            NSString *alermContentMessage;
            
            NSInteger alermCode = [alerm.alarmMessage integerValue];
          //  NSLog(@"报警报警报警报警报警报警报警报警报警报警报警报警%@",alerm.alarmMessage);
            //     [[NSNotificationCenter defaultCenter] postNotificationName:@"SHOWDETAILMESSAGE" object:nil userInfo:nil];
            //            if (alermCode == 508100) {
            //                break;
            //            }
            switch (alermCode) {
                case 508100:
                    alermContentMessage = @"报警解除";
                    break;
                case 508101:
                    alermContentMessage = @"控温温度传感器故障报警";
                    break;
                case 508102:
                    alermContentMessage = @"散热器温度传感器故障报警";
                    break;
                case 508103:
                    alermContentMessage = @"半导体芯片故障报警";
                    break;
                case 508104:
                    alermContentMessage = @"低温报警";
                    break;
                case 508105:
                    alermContentMessage = @"高温报警";
                    break;
                    
                default:
                    break;
            }
           // if (_isAlerm) {
                if(DATA_ENV.pushMessageArray == nil){
                    NSArray *array = [[NSArray alloc]init];
                    DATA_ENV.pushMessageArray = array;
                }
      //            NSLog(@"消息数组消息数组消息数组消息数组-%@",DATA_ENV.pushMessageArray);
                NSMutableArray *pushArray = [[NSMutableArray alloc]initWithArray:DATA_ENV.pushMessageArray];
                PushMessage *pushMessage = [[PushMessage alloc]init];
                pushMessage.type = @"0";
                
                NSDateFormatter *formart = [[NSDateFormatter alloc]init];
                [formart setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                NSString *dateStr = [formart stringFromDate:[NSDate date]];
                pushMessage.messageTime = dateStr;
                pushMessage.messageContent = alermContentMessage;
            if (![_alartMessage isEqualToString:alermContentMessage]) {
                _alartMessage = alermContentMessage;
                [pushArray addObject:pushMessage];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"RECEIVEPUSHMESSAGE" object:nil userInfo:nil];
            }
                DATA_ENV.pushMessageArray = pushArray;
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (_isAlerm) {
                        CustomMessageAlertView *alertView = [CustomMessageAlertView loadFromXib];
                        if (alermCode == 508100) {
                            alertView.redImageView.hidden = YES;
                            alertView.grayImageView.hidden = NO;
                        } else {
                            alertView.redImageView.hidden = NO;
                            alertView.grayImageView.hidden = YES;
                        }
                        alertView.delegate = self;
                        alertView.textLabel.text = alermContentMessage;
                        [[AppDelegate getAppDelegate].window addSubview:alertView];
                        _isAlerm = NO;

                    }
                });
            }
            //    [self performSelector:@selector(alerm) withObject:nil afterDelay:600];
    //    }
        
    } else if ([[noti name]isEqualToString:@"deviceOnlineChangedNotify"])
    {
        NSString *onLine = [[noti object] objectForKey:DATA_ENV.deviceMac];
        if (onLine!= nil) {
            NSDictionary *dict = @{@"onLine": onLine};
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"ONLINE" object:nil userInfo:dict];
            });
        }
        // NSLog(@"上线下线--%@",[[noti object] objectForKey:_device.mac]);deviceBindMessageNotify
    } else if ([[noti name]isEqualToString:@"deviceBindMessageNotify"])
    {
        NSString *statue = [[noti object] objectForKey:_device.mac];
        if ([statue isEqualToString:@"0"]) {
            [self cancelSubscribeDevice];
            DATA_ENV.deviceName = nil;
        }
        
        //  NSString *str = [NSString stringWithFormat:@"%@",dic];
    }
    
    self.deviceAttr = [[WineDevice alloc]initWithDataDic:dic];
    [self getDeviceStatues:dic];
    
}

- (void)alerm
{
    _isAlerm = YES;
}

- (void)customMessageAlertViewClickedWithTag:(NSInteger)tag;
{
    _isAlerm = YES;

    if (tag == 0) {
        [self cancelAlarm];
        _alartMessage = @"0";
        //  return;
    } else {
        //  dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SHOWDETAILMESSAGE" object:nil];
        //  [[MenuViewController getMenuViewController] showDetailMessageController];
        //   });
    }
}
#pragma mark - deviceStatus

- (NSInteger)getDeviceStatues
{
    uSDKDeviceStatusConst devieStatus;
    [self getWineDeviceList];
    if (_currentDeviceArray.count == 0) {
        return 3;
    }
  //  NSLog(@"查询设备列表--%@",_currentDeviceArray);
    for (uSDKDevice *device in _currentDeviceArray) {
        
        if ([device.mac isEqualToString:DATA_ENV.deviceMac]) {
            
            devieStatus = device.status;
            return devieStatus;
        }
    }
    return 0;
}

- (NSString *)deviceStatus:(uSDKDevice *)device
{
    NSString *status;
    if (device.status == 0) {
        status = @"设备离线";
    } else if (device.status == 1) {
        status = @"设备在线";
    } else if (device.status == 2) {
        status = @"已经链接";
    } else if (device.status == 3) {
        status = @"设备不可用";
    }
    return status;
}

#pragma mark - getDeviceStatues

- (void)getDeviceStatues:(NSDictionary *)dic
{
    // NSLog(@"^^^^%@",dic);
    if (dic[@"608101"] != nil) {
        NSInteger temp = [dic[@"608101"] floatValue] - 7;
        //   if ([dic[@"208101"] isEqualToString:@"208101"])
        _temperature = [NSString stringWithFormat:@"%d",temp];
        //        } else if ([dic[@"208102"] isEqualToString:@"208102"]){
        //            _temperature = [NSString stringWithFormat:@"%d",temp];
        //
        //        }
    }
    if (dic[@"208106"] != nil) {
        NSInteger setTemp = [dic[@"208106"] floatValue] + 5;
        // NSLog(@"设定温度--%d--%d",_previousTem,setTemp);
        
        if (_previousTem != setTemp) {
            //   NSLog(@"设定温度$$$$%d",setTemp);
            _previousTem = setTemp;
            _setTemperature = [NSString stringWithFormat:@"%d",setTemp];
        }
    }
    // NSString *isLinghtOn = @"0";
    //NSLog(@"208104-%@****%@",dic[@"208104"],dic[@"208103"]);
    if ([dic[@"208104"] isEqualToString:@"208104"]) {
        _isLinghtOn = @"0";
    } else if([dic[@"208103"] isEqualToString:@"208103"]) {
        _isLinghtOn = @"1";
    }
    
    NSDictionary *dict = @{@"temperature"    : _temperature,
                           @"setTemperature" : _setTemperature,
                           @"light"          : _isLinghtOn};
    [[NSNotificationCenter defaultCenter] postNotificationName:WINE_BOX_STATUE_CHANGE object:nil userInfo:dict];
}

/////////////////////////////////////////////////////////////////////////////////////////////////

//控灯
- (void)controlLamp:(BOOL)isOn
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 耗时的操作
        uSDKDeviceAttribute *attribute;
        if (isOn) {
            attribute = [[uSDKDeviceAttribute alloc]initWithAttrName:@"208104" withAttrValue:@"208104"];
        } else {
            attribute = [[uSDKDeviceAttribute alloc]initWithAttrName:@"208103" withAttrValue:@"208103"];
        }
        NSMutableArray *array = [NSMutableArray arrayWithObject:attribute];
        [_device execDeviceOperation:array withCmdSN:1 withGroupCmdName:@""];
        // NSLog(@"%u",error);
        
        //    dispatch_async(dispatch_get_main_queue(), ^{
        //        // 更新界面
        //    });
    });
}

//控温
- (void)controlTemperature:(NSString *)temperature
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        uSDKDeviceAttribute *attribute;
        attribute = [[uSDKDeviceAttribute alloc]initWithAttrName:@"208106" withAttrValue:temperature];
        NSMutableArray *array = [NSMutableArray arrayWithObject:attribute];
        [_device execDeviceOperation:array withCmdSN:1 withGroupCmdName:@""];
        
    });
}
//解除报警
- (void)cancelAlarm
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        uSDKDeviceAttribute *attribute;
        attribute = [[uSDKDeviceAttribute alloc]initWithAttrName:@"2000ZX" withAttrValue:nil];
        NSMutableArray *array = [NSMutableArray arrayWithObject:attribute];
       [_device execDeviceOperation:array withCmdSN:1 withGroupCmdName:@""]; //[_device execDeviceOperation:array withCmdSN:1 withGroupCmdName:@""];
       // NSLog(@"报警解除%d",t);
        
    });
}

#pragma mark -
- (void)remoteLoginWithAccessToken:(NSString *)token
{
    //    NSLog(@"*****%@",DATA_ENV.deviceMac);
    //    NSLog(@"*****%@",DATA_ENV.device.typeIdentifier);
    //
    //    NSLog(@"*****%@",DATA_ENV.device.smartLinkSoftwareVersion);
    //
    //    NSLog(@"*****%@",DATA_ENV.device.smartLinkPlatform);
    
    uSDKDevice *WineDevice = [uSDKDevice newRemoteDeviceInstance:DATA_ENV.deviceMac withDeviceTypeIdentifier:DATA_ENV.device.typeIdentifier withOnline:1 withSmartLinkVersion:DATA_ENV.device.smartLinkSoftwareVersion withSmartLinkPlatform:DATA_ENV.device.smartLinkPlatform];
    WineDevice.eProtocolVer = DATA_ENV.device.eProtocolVer;
    WineDevice.netType = 0;
    WineDevice.type = 8;
    WineDevice.ip = @"0.0.0.0";//192.168.241.148
    //   NSLog(@"%@",WineDevice);
    NSArray *deviceArray = @[WineDevice];
    // NSLog(@"%@--%@",DATA_ENV.device.smartLinkSoftwareVersion,DATA_ENV.device.smartLinkPlatform);
    [self getPMSURLWithAccessToken:token withRemoteDeviceArray:deviceArray];
}

#pragma mark - getPMSURL

- (void)getPMSURLWithAccessToken:(NSString *)token withRemoteDeviceArray:(NSArray *)array
{
    NSDictionary *dict = @{@"id" : @"MB-SINGLEGRADEVIN-0001",
                           @"ip" : @"192.168.1.100"};
    NSString * jsonString = [NSJSONSerialization jsonStringFromDictionary:dict];
    //NSLog(@"jsonString:%@",jsonString);
    NSDictionary * parameters = @{@"body": jsonString};
    [GetPMSRequest requestWithParameters:parameters withRequestUrl:nil withIndicatorView:nil withCancelSubject:nil onRequestStart:nil onRequestFinished:^(ITTBaseDataRequest *request) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            uSDKErrorConst error = [[uSDKDeviceManager getSingleInstance] remoteUserLogin:token withRemoteDevices:array withAccessGatewayDomain:request.handleredResult[@"getWayDomain"] withAccessGatewayPort:[request.handleredResult[@"getWayPort"] integerValue]];
            if (error == RET_USDK_OK) {
                //  [self SubscribeDeviceWithDeviceMac:DATA_ENV.deviceMac];
                if (DATA_ENV.deviceMac) {
                    [HaierSDK subscribeDevice:self
                                     selector:@selector(finishSubscribeDevice:) withMacList:/*@[@"0007A88A4666"]*/@[DATA_ENV.deviceMac]];
                  //  NSLog(@"&&&&&&&%@",DATA_ENV.deviceMac);
                }
                
            }
        });
    } onRequestCanceled:nil onRequestFailed:^(ITTBaseDataRequest *request) {
        
    }];
}
#pragma mark - getDevieTime
- (NSString *)getDevieTime
{
    NSDate *senddate=[NSDate date];
    
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:@"YYYY-MM-dd"];
    
    NSString *locationString=[dateformatter stringFromDate:senddate];
    return locationString;
}

@end
