//
//  BingDeviceNextViewController.m
//  HaierWine
//
//  Created by isoftstone on 14-7-28.
//
//

#import "BingDeviceNextViewController.h"
//#import "CityViewController.h"
#import "UIAlertView+ITTAdditions.h"
#import "Reachability.h"
#import "WineManager.h"
#import "WineManager.h"
#import "DeviceNameViewController.h"
#import "UserInfoManager.h"
#import "PKRevealController.h"
#import "Reachability.h"
#import "LoginManager.h"


@interface BingDeviceNextViewController ()
{
    
    IBOutlet UIButton       *_cancelButton;
    IBOutlet UIButton       *_backButton;
    IBOutlet UIButton       *_failureButton;
    
    IBOutlet UILabel        *_failureLabel;
    
    IBOutlet UIView         *_navView;
    
    IBOutlet UIView         *_backgroundView;
    
    IBOutlet UIView         *_bangdingFailureView;
    
    IBOutlet UIScrollView   *_contentScrollView;
    IBOutlet UIView         *_contentView;
    IBOutlet UIImageView    *_tipsImageView;
    IBOutlet UILabel        *_tipsTitle;
    IBOutlet UILabel        *_tipsContent;
    IBOutlet UIView         *_linkWiFiView;
    IBOutlet UITextField    *_WiFiPassword;
    IBOutlet UIButton       *_cityButton;
    
    IBOutlet UIButton       *_wineBoxNameButton;

    IBOutlet UILabel        *_navLabel;
    
    IBOutlet UIImageView    *_guideImageView;
    
    IBOutlet UILabel        *_WiFiNameLabel;
    

    
    NSInteger               _tipsIndex;
    uSDKDevice              *_device;
    WineManager             *_wineManager;
    NSArray                 *_wineDeviceList;
    MyAlertView             *_alertView;
    bindingProgressView     *_progressView;
    BOOL                    _isFindDevice;
    BOOL                    _isBandingFailure;
    BOOL                    _goControlView;
}
@end

@implementation BingDeviceNextViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _contentScrollView.contentSize = CGSizeMake(320*5, _contentScrollView.frame.size.height);
    [_contentScrollView addSubview:_contentView];
    _tipsIndex = 1;
    _wineManager = [WineManager shareWineManager];
    _wineManager.delegate = self;
    _alertView = [MyAlertView loadFromXib];
    _alertView.delegate = self;
    [self.view addSubview:_alertView];
    _alertView.hidden = YES;
    _progressView = [bindingProgressView loadFromXib];
    _progressView.hidden = YES;
    _progressView.delegate = self;
    [self.view addSubview:_progressView];
    DATA_ENV.isOverBanding = NO;
    _isBandingFailure = NO;
    _goControlView = NO;
    self.navigationController.revealController.recognizesPanningOnFrontView = NO;
   // [[WineManager shareWineManager] subscribeDeviceListChanged];
   // [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(findWineDevice:) name:FIND_WINE_DEVICE object:nil];
  //  [[WineManager shareWineManager] startHaierUSDK];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
  //  [self connectNet];
}

- (BOOL)connectNet
{
    Reachability *r = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    if ([r currentReachabilityStatus] != ReachableViaWiFi) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"请将网络切换到WIFI进行设备绑定" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        alertView.tag = 0;
        [alertView show];
        return YES;
    }
    return NO;
}

#pragma mark - ButtonClick

- (IBAction)BackButton:(id)sender
{   //DATA_ENV.isBindingDevice = YES;
    NSInteger offset = _contentScrollView.contentOffset.x;
    if (offset == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    } else if (offset > 0 ) {
        [UIView animateWithDuration:0.5 animations:^{
            [_contentScrollView setContentOffset:CGPointMake(offset-320, 0)];
            if (_contentScrollView.contentOffset.x == 320) {
                _guideImageView.image = [UIImage imageNamed:@"bing_image2"];
                _navLabel.text = @"加入家庭WIFI网络";

            }
            
        } completion:^(BOOL finished) {
           // _guideImageView.image = [UIImage imageNamed:name];
            
        }];
        if (offset == 320) {
            if (_bangdingFailureView != nil) {
                [_bangdingFailureView removeFromSuperview];
            }
            _tipsIndex = 1;
            _navLabel.text = @"小贴士";
            [self changeTips:[UIImage imageNamed:@"tips_image1"] title:@"1.呼吸" content:@"给你的酒柜接上电源"];
            _guideImageView.image = [UIImage imageNamed:@"bing_image1"];
        }
    }
        
    
    
}

#pragma mark - tipsButton

- (IBAction)tipsButtonClick:(id)sender
{
//[self bindingDeviceWithName:nil deviceLocation:nil deviceMac:nil];
    _tipsIndex++;
    if (_tipsIndex==2) {
        [self changeTips:[UIImage imageNamed:@"tips_image2"] title:@"2.唤醒" content:@"长按酒柜中部升温键，直到WIFI标识出现闪烁的光环"];
    } else if (_tipsIndex == 3) {
        [self changeTips:[UIImage imageNamed:@"tips_image3"] title:@"3.等待" content:@"请主人用手机连上家里的WIFI环境,为了给主人省钱,酒柜拒绝非WIFI"];
    } else if (_tipsIndex == 4) {
        [self nextView:320 withImageName:@"bing_image2"];
        _navLabel.text = @"加入家庭WIFI网络";
        _WiFiNameLabel.text = [self getDeviceSSID];
        [[WineManager shareWineManager] getWineDeviceList];
    }
}

#pragma mark - DeviceNameDelegate

- (void)modifyDeviceName:(NSString *)deviceName
{
    //_wineBoxNameButton.titleLabel.text = deviceName;
    [_wineBoxNameButton setTitle:deviceName forState:UIControlStateNormal];
}

#pragma mark - bindingProgressViewDelegate

- (void)connectFialure
{
//    if (_goControlView) {
//        DATA_ENV.isOverBanding = YES;
//        DATA_ENV.isBindingDevice = YES;
//        _goControlView = NO;
//        return;
//    }
    
    if(!_isFindDevice){
        _bangdingFailureView.top = 64;
        _failureLabel.text = @"未连接成功, 继续努力";
        [_failureButton setTitle:@"重新添加设备" forState:UIControlStateNormal];
        if (is4InchScreen()) {
            _bangdingFailureView.height = _bangdingFailureView.height+88;
        }
        [_backgroundView addSubview:_bangdingFailureView];
        //_isBandingFailure = YES;
    }
}

#pragma mark -

- (IBAction)setWiFiButton:(id)sender
{
    NSString *message;
    NSString *wifiStr = [self getDeviceSSID];
    if (wifiStr.length < 1) {
        return;
    }

    [_WiFiPassword resignFirstResponder];
    if (_WiFiPassword.text.length == 0) {
        message = @"密码不能为空";
        [UIAlertView popupAlertByDelegate:nil title:nil message:message];
        return;
    } else if ((_WiFiPassword.text.length>0 && _WiFiPassword.text.length<5)||_WiFiPassword.text.length>32) {
        message = @"请输入5-32位字符";
        [UIAlertView popupAlertByDelegate:nil title:nil message:message];
        return;
    }

//    switch ([r currentReachabilityStatus]) {
//        case NotReachable:
//            // 没有网络连接
//            break;
//        case ReachableViaWWAN:
//            // 使用3G网络
//            break;
//        case ReachableViaWiFi:
//            // 使用WiFi网络
//            break;
//    }
//    if (_WiFiPassword.text.length==0) {
//        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"请输入WiFi密码" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
//        alertView.delegate = self;
//        [alertView show];
//        return;
//    }
    _progressView.hidden = NO;
    _progressView.count = 60;
  //  [_progressView.timer fire];
    [self.view bringSubviewToFront:_progressView];
    _isFindDevice = NO;
    [[WineManager shareWineManager] setConfigLinkSSID:_WiFiNameLabel.text password:_WiFiPassword.text];
    _tipsIndex = 10;
    DATA_ENV.deviceMac = nil;
 //[[WineManager shareWineManager] setConfigLinkSSID:@"TP-LINK_zhangshu_waibao" password:@"1234567890"];
}

- (IBAction)bandingDeviceButton:(id)sender
{
  //  [self nextView:960 withImageName:@"bing_image4"];
    [self bindingDeviceWithName:_wineBoxNameButton.titleLabel.text deviceLocation:_cityButton.titleLabel.text deviceMac:_device.mac];
}

- (IBAction)addDeviceAgain:(id)sender
{
    if(_isBandingFailure){
        if (is4InchScreen()) {
            _bangdingFailureView.height = _bangdingFailureView.height-88;
        }

        [_bangdingFailureView removeFromSuperview];
        _isBandingFailure = NO;
    } else {
        if (is4InchScreen()) {
            _bangdingFailureView.height = _bangdingFailureView.height-88;
        }

        [_bangdingFailureView removeFromSuperview];
        [_contentScrollView setContentOffset:CGPointMake(0, 0)];
        _tipsIndex = 1;
        _navLabel.text = @"小贴士";
        [self changeTips:[UIImage imageNamed:@"tips_image1"] title:@"1.呼吸" content:@"给你的酒柜接上电源"];
        _guideImageView.image = [UIImage imageNamed:@"bing_image1"];
    }
}

- (void)nextView:(CGFloat)left withImageName:(NSString *)name
{
    [UIView animateWithDuration:0.5 animations:^{
        [_contentScrollView setContentOffset:CGPointMake(left, 0)];
    } completion:^(BOOL finished) {
        _guideImageView.image = [UIImage imageNamed:name];

    }];
}

- (void)findWineDevice:(uSDKDevice*)device
{
//    _wineDeviceList = ListArray;
//    NSInteger count =  ListArray.count;
  //  uSDKDevice *device = [noti userInfo][@"newDevice"];
    if (/*_device.mac.length != 0||*/_tipsIndex!=10 || device.mac.length == 0) {
        return;
    }
    _isFindDevice = YES;
    DATA_ENV.deviceMac = device.mac;
    _device = device;
    dispatch_async(dispatch_get_main_queue(), ^{
        _progressView.hidden = YES;
        // [_progressView removeFromSuperview];
        [self nextView:640 withImageName:@"bing_image3"];
        _navLabel.text = @"酒柜DIY设置";
        _tipsIndex = 11;
    });
  //  [UIAlertView popupAlertByDelegate:self title:@"找到设备" message:_device.mac];
    //[_progressView removeFromSuperview];
    //去掉等待框


}

#pragma mark - BindingDevice

- (void)bindingDeviceWithName:(NSString *)deviceName deviceLocation:(NSString *)location deviceMac:(NSString *)deviceMac
{
    _progressView.hidden = NO;
    _progressView.count = 60;
    _progressView.progressLabel.text = @"通信中";
    //  [_progressView.timer fire];
    [self.view bringSubviewToFront:_progressView];
    NSDictionary *device =@{
                            @"devices": @[
                                    @{
                                        @"id": deviceMac,
                                        @"mac":deviceMac,
                                        @"name": deviceName,
                                        @"attrs": @{
                                                @"brand": @"brand",
                                                @"model": @"model"
                                                },
                                        @"type": @{
                                                @"type": @"8",
                                                @"subType" : @"subType",
                                                @"specialCode": @"specialCode",
                                                @"typeIdentifier": _device.typeIdentifier
                                                },
                                        @"version": @{
                                                @"eProtocolVer": _device.eProtocolVer,
                                                @"smartlink": @{
                                                        @"smartLinkSoftwareVersion": _device.smartLinkSoftwareVersion,
                                                        @"smartLinkHardwareVersion": _device.smartLinkHardwareVersion,
                                                        @"smartLinkDevfileVersion": _device.smartLinkDevfileVersion,
                                                        @"smartLinkPlatform":_device.smartLinkPlatform
                                                        }
                                                
                                                }
                                        }
                                    ]
                            };
    
    NSString * requestUrl = [NSString stringWithFormat:@"%@/users/%@/devices",COMMON_SERVER_ADDRESS,DATA_ENV.userid];
    NSString * jsonString = [NSJSONSerialization jsonStringFromDictionary:device];
    NSDictionary * parameters = @{@"body":jsonString};
   // NSLog(@"parameters---%@",device);
//    [BingDeviceRequest requestWithParameters:parameters withRequestUrl:requestUrl withIndicatorView:nil onRequestFinished:^(ITTBaseDataRequest *request) {
//        NSLog(@"*****%@",request.handleredResult);
//      //  if()
//        _navView.hidden = YES;
//        [self nextView:960 withImageName:@"bing_image4"];
//
//    }];
    [BingDeviceRequest requestWithParameters:parameters withRequestUrl:requestUrl withIndicatorView:nil withCancelSubject:nil onRequestStart:^(ITTBaseDataRequest *request) {
        
    } onRequestFinished:^(ITTBaseDataRequest *request) {
      //  NSLog(@"****%@",request.handleredResult);
 //       DATA_ENV.device.deviceName = deviceName;
        if([request.handleredResult[@"retCode"] isEqualToString:@"00000"]){
        DATA_ENV.deviceName = deviceName;
      //  NSLog(@"设备名称------%@",DATA_ENV.device.deviceName);
        //DATA_ENV.deviceMac = deviceMac;
        _progressView.hidden = YES;
      //  _navView.hidden = YES;
        DATA_ENV.isBindingDevice = YES;
        [self nextView:960 withImageName:@"bing_image4"];
        _backButton.hidden = YES;
        _cancelButton.hidden = YES;
      //  DATA_ENV.device = _device;
        [LoginManager getUserBindingDeviceCompletion:^(BOOL isSuccess, NSString *returnMsg) {
            [_wineManager SubscribeDeviceWithDeviceMac:_device.mac];

        }];
        [self performSelector:@selector(wineControl) withObject:nil afterDelay:5];
        } else
        {
            _progressView.hidden = YES;
            _isBandingFailure = YES;
            _bangdingFailureView.top = 64;
            _failureLabel.text = @"通信失败, 继续努力!";
            [_failureButton setTitle:@"重试" forState:UIControlStateNormal];
            if (is4InchScreen()) {
                _bangdingFailureView.height = _bangdingFailureView.height+88;
            }
            [_backgroundView addSubview:_bangdingFailureView];

        }
    } onRequestCanceled:^(ITTBaseDataRequest *request) {
        
    } onRequestFailed:^(ITTBaseDataRequest *request) {
//        _bangdingFailureView.top = 64;
//        [_backgroundView addSubview:_bangdingFailureView];
        _progressView.hidden = YES;
        _isBandingFailure = YES;
        _bangdingFailureView.top = 64;
        _failureLabel.text = @"通信失败, 继续努力!";
        [_failureButton setTitle:@"重试" forState:UIControlStateNormal];
        if (is4InchScreen()) {
            _bangdingFailureView.height = _bangdingFailureView.height+88;
        }
        [_backgroundView addSubview:_bangdingFailureView];


    }];

}

- (void)wineControl
{
    [self.navigationController popToRootViewControllerAnimated:YES];
//    DATA_ENV.isOverBanding = YES;
//    DATA_ENV.isBindingDevice = YES;
//    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - alertViewDelegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
//    if (alertView.tag == 0) {
//        [self.navigationController popViewControllerAnimated:YES];
//    }
//    [_contentScrollView setContentOffset:CGPointMake(0, 0)];
//    _tipsIndex = 1;_navLabel.text = @"小贴士";
//    _guideImageView.image = [UIImage imageNamed:@"bing_image1"];

}

#pragma mark - textFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.5 animations:^{
        _linkWiFiView.top = _linkWiFiView.top - 140;
    }];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.5 animations:^{
        _linkWiFiView.top = _linkWiFiView.top + 140;
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_WiFiPassword resignFirstResponder];
    return YES;
}

- (IBAction)tapView:(id)sender
{
   // [_WiFiPassword resignFirstResponder];
    
}


#pragma mark - changeTips

- (void)changeTips:(UIImage *)image title:(NSString*)title content:(NSString *)content
{
    _tipsImageView.image = image;
    _tipsTitle.text = title;
    _tipsContent.text = content;
}

#pragma mark - showPassword

- (IBAction)showPassword:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    btn.selected = !btn.selected;
    if (btn.selected) {
        _WiFiPassword.secureTextEntry = NO;
        btn.titleLabel.text = @"显示密码";
    } else {
        _WiFiPassword.secureTextEntry = YES;
     //   btn.titleLabel.text = @"隐藏密码";

    }
}

- (IBAction)deviceNameClick:(id)sender
{
    DeviceNameViewController *dvc = [[DeviceNameViewController alloc]init];
    dvc.delegate = self;
    dvc.isModefyName = NO;
    dvc.deviceName = _wineBoxNameButton.titleLabel.text;
    [self.navigationController pushViewController:dvc animated:YES];
}

- (IBAction)cityListButton:(id)sender
{
    // CityListViewController *ctv = [[CityListViewController alloc]init];
    UIButton *btn = (UIButton *)sender;
    CityViewController *ctv = [[CityViewController alloc]init];
    ctv.city = btn.titleLabel.text;
    ctv.delegate = self;
    [self.navigationController pushViewController:ctv animated:YES];
}

#pragma mark - CityListDelegate

- (void)selectedCity:(NSString *)cityName
{
    //
    NSArray *strArr = [cityName componentsSeparatedByString:@"#"];
    NSString *str = (NSString *)strArr.lastObject;
    
    NSString *city = (NSString *)strArr.firstObject;
    NSString *country = (NSString *)strArr.lastObject;
    if ([city isEqualToString:country]) {
        
        str = strArr.firstObject;
    }
    //
   // _cityButton.titleLabel.text = cityName;
    [_cityButton setTitle:str forState:UIControlStateNormal];

    NSDictionary * profileDict = @{@"address": cityName
                                   
                                   };
    NSDictionary * userProfile = @{@"userProfile": profileDict};
    [UserInfoManager modifyUserInfoByProfile:userProfile completion:^(BOOL isSuccess, NSString *returnMsg) {
        //  NSLog(@"####%@",returnMsg);小张
    }];

}

#pragma mark - getDeviceSSID

- (NSString*)getDeviceSSID {
    NSArray *interfaceArray = (__bridge id)CNCopySupportedInterfaces();
    NSDictionary* info = nil;
    for (NSString *interfaceName in interfaceArray) {
        info = (__bridge id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)interfaceName);
        if (info && [info count]) {
            break;
        }
    }
    NSDictionary *ssidDic = (NSDictionary *)info;
    NSString *ssid = [ssidDic objectForKey:@"SSID"];
    if (ssid == nil) ssid = @"非WIFI网络";
    return ssid;
}

#pragma mark - cancelButton

- (IBAction)cancelButtonClick:(id)sender
{
    [_WiFiPassword resignFirstResponder];
    switch ((NSInteger)_contentScrollView.contentOffset.x/320) {
        case 0:
            _alertView.titleMessage.text = @"你的酒柜在等你";
            _alertView.meassage.text = @"确定直接离开吗?";
            break;
        case 1:
        {
//            if (_isBandingFailure) {
//                _alertView.titleMessage.text = @"你的酒柜还在等你";
//                _alertView.meassage.text = @"确定直接离开吗?";
//            }
            _alertView.titleMessage.text = @"你的酒柜还在等你";
            _alertView.meassage.text = @"确定直接离开吗?";
            break;
        }
        case 2:
        {
            if (_isBandingFailure) {
                _alertView.titleMessage.text = @"你的酒柜仍在等你";
                _alertView.meassage.text = @"确定现在离开吗?";

            } else {
                _alertView.titleMessage.text = @"你的酒柜一直在等你";
                _alertView.meassage.text = @"确定直接离开吗?";

            }
            break;
        }
            
        default:
            break;
    }
    DATA_ENV.isOverBanding = YES;
    _alertView.hidden = NO;
}

- (IBAction)goControlWine:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
   // [_wineManager SubscribeDeviceWithDeviceMac:@"0007A88A4666"];
//    _progressView.hidden = NO;
//    _progressView.count = 5;
//    _goControlView = YES;
//    [self.view bringSubviewToFront:_progressView];
   // [UIAlertView popupAlertByDelegate:nil title:@"订阅" message:_device.mac];
}

#pragma mark - alertViewDelegate

- (void)myAlertViewClickedWithTag:(NSInteger)tag
{
    if (tag == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        return;
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    _wineManager.delegate = nil;
    _progressView.delegate = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
