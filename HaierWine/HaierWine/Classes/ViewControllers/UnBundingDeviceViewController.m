//
//  UnBundingDeviceViewController.m
//  HaierWine
//
//  Created by isoftstone on 14-7-6.
//
//

#import "UnBundingDeviceViewController.h"
#import "UserInfoManager.h"
#import "WineManager.h"
#import "MenuViewController.h"
#import "FeedBackAndUpdateAlertView.h"
@interface UnBundingDeviceViewController ()
{
    
    IBOutlet UIImageView  *_arrowImage;
    IBOutlet UIImageView  *_deviceImageView;
    IBOutlet UIButton     *_deviceName;
    IBOutlet UILabel      *_deviceID;
    IBOutlet UILabel      *_deviceStatue;
    IBOutlet UIView       *_contentView;
    IBOutlet UIButton     *_bundingButton;
    FeedBackAndUpdateAlertView *_successALertView;
}

@end

@implementation UnBundingDeviceViewController

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
    // _contentScrollView.contentSize = CGSizeMake(320, 504);
    //  [_contentScrollView addSubview:_contentView];
    if (DATA_ENV.isBindingDevice) {
        _deviceID.text = DATA_ENV.deviceMac;
        _arrowImage.hidden = NO;
        [_deviceName setTitle:DATA_ENV.deviceName forState:UIControlStateNormal];
        [_bundingButton setTitle:@"解绑设备" forState:UIControlStateNormal];
     //   NSInteger statues;
        if (DATA_ENV.isDeviceOneline) {
            _deviceStatue.text = @"正常";

        } else {
            _deviceStatue.text = @"不正常";

        }
//       // statues = [[WineManager shareWineManager] getDeviceStatues];
//        if (statues== 0) {
//            _deviceStatue.text = @"不正常";
//         //   _bundingButton.enabled = NO;
//        } else if (statues == 1) {
//            _deviceStatue.text = @"不正常";
//          //  _bundingButton.enabled = YES;
//        } else if (statues == 2) {
//            _deviceStatue.text = @"正常";
//          //  _bundingButton.enabled = NO;
//        } else if (statues == 3) {
//            _deviceStatue.text = @"不正常";
//          //  _bundingButton.enabled = NO;
//        }
        
    } else {
        _arrowImage.hidden = YES;
        _deviceID.text = @"";
        [_deviceName setTitle:@"" forState:UIControlStateNormal];
        _deviceStatue.text = @"";
        _deviceName.enabled = NO;
        [_bundingButton setTitle:@"开始绑定" forState:UIControlStateNormal];
    }
    _successALertView = [FeedBackAndUpdateAlertView loadFromXib];
    _successALertView.frame = CGRectMake(0, 0, 320, self.view.bounds.size.height);
    _successALertView.type = UnBandingSuccess;
    [self.view addSubview:_successALertView];
    _successALertView.hidden = YES;
//    [self showDelegateWineAlertView];
   // DATA_ENV.deviceMac = @"0007A88A4666";

    // [self getUserDeviceInformation];
}

#pragma mark - getUserDeviceInformation

- (void)getUserDeviceInformation
{
    [UserInfoManager getUserDeviceWhenCompletion:^(BOOL isSuccess, id responseObject) {
        
    }];
}

#pragma mark - userAction
- (IBAction)unDeviceClick:(id)sender
{   // NSLog(@"&&&&%d",DATA_ENV.isBindingDevice);
//    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"解除绑定设备后,将不能使用控酒功能,若想继续使用,需要重新绑定设备。" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"解绑设备", nil];
//    alertView.delegate = self;
//    [alertView show];
    if (!DATA_ENV.isBindingDevice) {
//        MainViewController *mvc = [[MainViewController alloc]init];
//        mvc.isNoShowLogin = NO;
//        mvc.isWineBox = NO;
//        BaseNavigationController *nvc = [[BaseNavigationController alloc]initWithRootViewController:mvc];
//        nvc.navigationBarHidden = YES;
//        [self.revealController setFrontViewController:nvc focusAfterChange:YES completion:^(BOOL finished) {
//            
//        }];
        [[MenuViewController getMenuViewController] showHomeViewControllerWith:YES];

    } else {
        if (DATA_ENV.wineName.length == 0) {
            [self showBandingAlertView];
        } else {
            [self showDelegateWineAlertView];
        }
    }
  /* NSDictionary *device =@{
        @"devices": @[
                    @{
                        @"id": @"0007A88A4666",
                        @"mac": @"0007A88A4666",
                        @"name": @"海尔酒柜",
                        @"attrs": @{
                            @"brand": @"brand",
                            @"model": @"model"
                        },
                        @"type": @{
                            @"type": @"20",
                            @"subType": @"subType",
                            @"specialCode": @"specialCode",
                            @"typeIdentifier": TYPE_INDITIFIER
                        },
                        @"version": @{
                            @"eProtocolVer": @"eProtocol",
                            @"smartlink": @{
                                @"smartLinkSoftwareVersion": @"software",
                                @"smartLinkHardwareVersion": @"hardware",
                                @"smartLinkDevfileVersion": @"devfile",
                                @"smartLinkPlatform": @"platform"
                            }
                            
                        }
                    }
                    ]
        };

    NSString * requestUrl = [NSString stringWithFormat:@"%@/users/%@/devices",COMMON_SERVER_ADDRESS,DATA_ENV.userid];
    NSString * jsonString = [NSJSONSerialization jsonStringFromDictionary:device];
    NSDictionary * parameters = @{@"body": jsonString};
    NSLog(@"parameters---%@",parameters);
    [BingDeviceRequest requestWithParameters:parameters withRequestUrl:requestUrl withIndicatorView:nil onRequestFinished:^(ITTBaseDataRequest *request) {
        NSLog(@"绑定成功*****%@",request.handleredResult);
        [UserInfoManager getUserDeviceWhenCompletion:^(BOOL isSuccess, id responseObject) {
            [UserInfoManager renameDeiveByNewname:@"ggggggg" completion:^(BOOL isSuccess, id responseObject) {

 
            }];
        }];
    }];
 //   [UserInfoManager getUserDeviceWhenCompletion:^(BOOL isSuccess, id responseObject) {
        
  //  }];
//                    [UserInfoManager unbindDeviceByUserIds:[NSArray arrayWithObject:@"0007A88A4666"] completion:^(BOOL isSuccess, id responseObject) {
//                   [UserInfoManager getUserDeviceWhenCompletion:^(BOOL isSuccess, id responseObject) {
//                      
//                   }];
//                    }];
   */
}

- (void)showDelegateWineAlertView
{
    DeleteAlertView *alertView = [DeleteAlertView loadFromXib];
    alertView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    alertView.type = DeleteAlertViewTypeWine;
    alertView.delegate = self;
    [self.view addSubview:alertView];
}

- (void)showBandingAlertView
{
//    NSString *message = @"解除绑定设备后,将不能使用控酒功能,若想继续使用,需要重新绑定设备。";
//    NSString *buttonTitle = @"解绑设备";
////    if (DATA_ENV.deviceMac == nil) {
////        message = @"你还没有绑定设备";
////        buttonTitle = @"确定";
////    }
//    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:buttonTitle, nil];
//    alertView.delegate = self;
//    [alertView show];
    DeleteAlertView *alertView = [DeleteAlertView loadFromXib];
    alertView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    alertView.type = DeleteAlertViewTypeUnbandingFirst;
    alertView.delegate = self;
    [self.view addSubview:alertView];

}

//- (void)DeleteAlertViewClickedWithTag:(NSInteger)tag withType:(DeleteAlertViewType)type
//{
//    if(type == DeleteAlertViewTypeWine){
//        if (tag == 1) {
//            
//        }
//    }
//}


#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (DATA_ENV.deviceMac == nil) {
        return;
    }
    if (buttonIndex == 0){
        return;
    } else {
        if (DATA_ENV.wineName.length == 0) {
            [self unbandingDevice];
            
        } else {
            //   NSLog(@"*****%@",DATA_ENV.device.deviceMac);
           // [self delegateBoxWine];
            
        }
    }
}

- (void)delegateBoxWine
{
    NSDictionary *dict = @{@"appId": DATA_ENV.userid};
    [DelegateBoxWineRequest requestWithParameters:dict withIndicatorView:nil withCancelSubject:nil onRequestStart:nil onRequestFinished:^(ITTBaseDataRequest *request) {
        DATA_ENV.wineName = nil;
      //  [self unbandingDevice];
        [self showBandingAlertView];
    } onRequestCanceled:nil onRequestFailed:^(ITTBaseDataRequest *request) {
        DeleteAlertView *alert = [DeleteAlertView loadFromXib];
        alert.type = DeleteAlertViewTypeWineFail;
        alert.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
        alert.delegate = self;
        [self.view addSubview:alert];
    }];

}

- (void)DeleteAlertViewClickedWithTag:(NSInteger)tag withType:(DeleteAlertViewType)type
{
    if (type == DeleteAlertViewTypeUnbanding) {
        if (tag == 1)
        {
            [self unbandingDevice];
//            NSDictionary *dict = @{@"appId": DATA_ENV.userid};
//            [DelegateBoxWineRequest requestWithParameters:dict withIndicatorView:nil withCancelSubject:nil onRequestStart:nil onRequestFinished:^(ITTBaseDataRequest *request) {
//              //  [self showBandingAlertView];
//              //  [self unbandingDevice];
//            } onRequestCanceled:nil onRequestFailed:^(ITTBaseDataRequest *request) {
//                DeleteAlertView *alert = [DeleteAlertView loadFromXib];
//                alert.type = DeleteAlertViewTypeUnbanding;
//                alert.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
//                alert.delegate = self;
//                [self.view addSubview:alert];
//            }];
        }
    } else if (type == DeleteAlertViewTypeWine){
        if (tag == 1) {
            [self delegateBoxWine];
        }

    } else if (type == DeleteAlertViewTypeUnbandingFirst){
        if (tag == 1) {
            [self unbandingDevice];
        }
    } else if (type == DeleteAlertViewTypeWineFail){
        [self delegateBoxWine];
    }
}

- (void)unbandingDevice
{
    [UserInfoManager unbindDeviceByUserIds:nil completion:^(BOOL isSuccess, id responseObject) {
        if (isSuccess == YES) {
          //  DATA_ENV.isBindingDevice = NO;
            DATA_ENV.device = nil;
            DATA_ENV.deviceMac = nil;
 //           DATA_ENV.wineName = nil;
         //   [[WineManager shareWineManager] stopHaierUSDK];
            [UserInfoManager getUserDeviceWhenCompletion:^(BOOL isSuccess, id responseObject) {
                //
                if (!DATA_ENV.isBindingDevice) {
                    _deviceName.enabled = NO;
                    _deviceID.text = @"";
                    _arrowImage.hidden = YES;
                    _deviceStatue.text = @"";
                    [_deviceName setTitle:@""forState:UIControlStateNormal];
                    _successALertView.hidden = NO;
                    [_bundingButton setTitle:@"开始绑定" forState:UIControlStateNormal];

                } else {
                    DeleteAlertView *alert = [DeleteAlertView loadFromXib];
                    alert.type = DeleteAlertViewTypeUnbanding;
                    alert.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
                    alert.delegate = self;
                    [self.view addSubview:alert];
                }

            }];
            
        }else {
            DeleteAlertView *alert = [DeleteAlertView loadFromXib];
            alert.type = DeleteAlertViewTypeUnbanding;
            alert.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
            alert.delegate = self;
            [self.view addSubview:alert];
        }
        
    }];

}

- (IBAction)backButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - modifyName

- (IBAction)modifyName:(id)sender
{
    DeviceNameViewController *dnv = [[DeviceNameViewController alloc]init];
    dnv.delegate = self;
    dnv.isModefyName = YES;
    dnv.deviceName = _deviceName.titleLabel.text;
    [self.navigationController pushViewController:dnv animated:YES];
}

#pragma mark - DeviceNameDelegate

- (void)modifyDeviceName:(NSString *)deviceName
{
    [_deviceName setTitle:deviceName forState:UIControlStateNormal];
   // DATA_ENV.device.deviceName = deviceName;
   // NSLog(@"DATA_ENV.device.deviceName %@",DATA_ENV.device.deviceName);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
