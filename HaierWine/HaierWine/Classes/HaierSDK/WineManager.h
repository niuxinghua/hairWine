//
//  WineManager.h
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
#import <UIKit/UIKit.h>
#import "WineDevice.h"
#import "CustomMessageAlertView.h"

@protocol WineManagerDelegate <NSObject>

- (void)findWineDevice:(uSDKDevice *)device;
- (void)subscribeDeviceFinished;
- (void)refreshControlWineUIWith:(NSString *)temperature andLightStatue:(BOOL)isOn;

@end

@interface WineManager : NSObject<CustomMessageAlertViewDelegate>

@property (nonatomic ,strong) WineDevice *deviceAttr;
@property (nonatomic ,assign) id<WineManagerDelegate> delegate;

+ (id)shareWineManager;
//订阅设备
- (void)subscribeDeviceListChanged;
//开始停止uSDK
- (void)startHaierUSDK;
- (uSDKErrorConst)stopHaierUSDK;
- (NSInteger)getDeviceStatues;
- (void)remoteLoginWithAccessToken:(NSString *)token;

//配置设备到指定wifi
- (void)setConfigLinkSSID:(NSString *)ssid password:(NSString *)pw;

//从云平台获取设备列表
- (void)getDeviceListFromHaierUhome;

//订阅设备
- (void)SubscribeDeviceWithDeviceMac:(NSString *)deviceMac;
//取消设备订阅
- (void)cancelSubscribeDevice;


//控灯
- (void)controlLamp:(BOOL)isOn;

//控温
- (void)controlTemperature:(NSString *)temperature;

- (void)getWineDeviceList;


@end
