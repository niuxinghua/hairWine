//
//  SaveUserDataManager.h
//  haierwine--接口测试
//
//  Created by isoftstone on 14-7-4.
//  Copyright (c) 2014年 isoftstone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SaveUserDataManager : NSObject

@property (assign, nonatomic) BOOL     isMemory;            // 记住密码
@property (assign, nonatomic) BOOL     isLocalOnline;       //本地登陆状态
@property (assign, nonatomic) BOOL     isBindingDevice;     //绑定设备状态

@property (nonatomic,strong) NSString  *accessToken;    //token
@property (nonatomic,strong) NSString  *userid;         //userid
@property (nonatomic,strong) NSString  *deviceId;       //deviceId;
@property (nonatomic,strong) NSString  *deviceName;     //deviceName
@property (nonatomic,strong) NSString  *deviceMac;     //deviceMac


@property (nonatomic,assign) BOOL      hasNewVersion;        //有新版本
//@property (nonatomic,strong) ITTVersion * version;      //保存新版本
@property (nonatomic,assign) BOOL      pushOpened;           //消息推送

+ (SaveUserDataManager *)sharedSaveUserDataManager;

@end
