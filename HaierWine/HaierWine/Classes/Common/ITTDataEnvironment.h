//
//  DataEnvironment.h
//
//  Copyright 2010 itotem. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Personal.h"
#import "WineDevice.h"
@interface ITTDataEnvironment : NSObject {
    NSString *_urlRequestHost;
}

@property (nonatomic,strong) NSString   *urlRequestHost;
@property (nonatomic,strong) NSString   *wineID;
@property (nonatomic,strong) NSString   *wineName;
@property (nonatomic,strong) NSString   *wineType;
@property (nonatomic,strong) NSString   *userNickName;
@property (nonatomic,strong) NSString   *userAvatarUrl;
@property (nonatomic,strong) NSString   *suitableTemp;


@property (nonatomic,strong) Personal   *person;
@property (nonatomic,strong) WineDevice *device;
@property (nonatomic,strong) NSArray    *pushMessageArray;

@property (assign, nonatomic) BOOL      HereHerestep1;
@property (assign, nonatomic) BOOL      HereHerestep2;

@property (assign, nonatomic) BOOL      isAutoLogin;
@property (assign, nonatomic) BOOL      isMemory;            // 记住密码
@property (assign, nonatomic) BOOL      isLocalOnline;       //本地登陆状态
@property (assign, nonatomic) BOOL      isBindingDevice;     //绑定设备状态
@property (nonatomic,strong) NSString   *accessToken;    //token
@property (nonatomic,strong) NSString   *userid;         //userid
@property (nonatomic,strong) NSString   *deviceId;       //deviceId;
@property (nonatomic,strong) NSString   *deviceName;     //deviceName
@property (nonatomic,strong) NSString   *deviceMac;     //deviceMac

@property (nonatomic,strong) NSString   *deviceTypeIdentifier;     //TypeIdentifier
@property (nonatomic,strong) NSString   *iosDeviceToken;
@property (nonatomic,strong) NSString   *voiceOn;

@property (nonatomic,assign) BOOL       hasNewVersion;        //有新版本
//@property (nonatomic,strong) ITTVersion * version;      //保存新版本
@property (nonatomic,assign) BOOL       pushOpened;           //消息推送
@property (nonatomic,assign) BOOL       isAddWine;
@property (nonatomic,assign) BOOL       isSubcribe;
@property (nonatomic,assign) BOOL       isScanning;
@property (nonatomic,assign) BOOL       isOverBanding;
@property (nonatomic,assign) BOOL       isVistor;
@property (nonatomic,assign) BOOL       isDeviceOneline;


@property (nonatomic,strong) NSString   *userName;
@property (nonatomic,strong) NSString   *userPassword;



+ (ITTDataEnvironment *)sharedDataEnvironment;

- (void)clearNetworkData;
- (void)clearCacheData;

@end
