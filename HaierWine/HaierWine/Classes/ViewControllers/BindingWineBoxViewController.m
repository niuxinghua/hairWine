//
//  BindingWineBoxViewController.m
//  HaierWine
//
//  Created by leon on 14-7-24.
//
//

#import <uSDKFramework/uSDKDeviceManager.h>
#import <uSDKFramework/uSDKManager.h>
#import <uSDKFramework/uSDKDevice.h>
#import <uSDKFramework/uSDKNotificationCenter.h>
#import "HaierSDK.h"
#import <SystemConfiguration/CaptiveNetwork.h>
#import "BindingWineBoxViewController.h"

@interface BindingWineBoxViewController ()
{
    
}
@end

@implementation BindingWineBoxViewController

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
}

//获取当前网络SSID
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
    if (ssid == nil) ssid = @"";
    return ssid;
}

@end
