//
//  SaveUserDataManager.m
//  haierwine--接口测试
//
//  Created by isoftstone on 14-7-4.
//  Copyright (c) 2014年 isoftstone. All rights reserved.
//

#import "SaveUserDataManager.h"
#import "ITTDataCacheManager.h"
#import "ITTNetworkTrafficManager.h"
#import "ITTObjectSingleton.h"

@implementation SaveUserDataManager

ITTOBJECT_SINGLETON_BOILERPLATE(SaveUserDataManager, sharedSaveUserDataManager)
// isMemory
- (void)setIsMemory:(BOOL)isMemory
{
    NSString * isMemoryStr = [NSString stringWithFormat:@"%d",isMemory];
    if (isMemoryStr) {
        [[ITTDataCacheManager sharedManager] addObject:isMemoryStr forKey:KEY_MEMORY_PASSWORD];
    }
}

- (BOOL)isMemory
{
    return [[[ITTDataCacheManager sharedManager] getCachedObjectByKey:KEY_MEMORY_PASSWORD] boolValue];
    
}
// isLocalOnline
- (void)setIsLocalOnline:(BOOL)isLocalOnline
{
    NSString * isLocalOnlineStr = [NSString stringWithFormat:@"%d",isLocalOnline];
    if (isLocalOnlineStr) {
        [[ITTDataCacheManager sharedManager] addObject:isLocalOnlineStr forKey:KEY_CACHE_LOCAL_ONLINE];
    }
}

- (BOOL)isLocalOnline
{
    return [[[ITTDataCacheManager sharedManager] getCachedObjectByKey:KEY_CACHE_LOCAL_ONLINE] boolValue];
}
//isBindingDevice
- (void)setIsBindingDevice:(BOOL)isBindingDevice
{
    NSString * isBindingDeviceStr = [NSString stringWithFormat:@"%d",isBindingDevice];
    if (isBindingDeviceStr) {
        [[ITTDataCacheManager sharedManager] addObject:isBindingDeviceStr forKey:KEY_CACHE_BINDING_DEVICE];
    }
}

- (BOOL)isBindingDevice
{
    return [[[ITTDataCacheManager sharedManager] getCachedObjectByKey:KEY_CACHE_BINDING_DEVICE] boolValue];
}

//accessToken
- (void)setAccessToken:(NSString *)accessToken
{
    if (accessToken) {
        [[ITTDataCacheManager sharedManager] addObject:accessToken forKey:KEY_CACHE_USER_ACCESSTOKEN];
    }else{
        [[ITTDataCacheManager sharedManager] addObject:@"" forKey:KEY_CACHE_USER_ACCESSTOKEN];
    }
    
}

- (NSString *)accessToken
{
    NSString * accessToken = [[ITTDataCacheManager sharedManager] getCachedObjectByKey:KEY_CACHE_USER_ACCESSTOKEN];
    if (accessToken) {
        return accessToken;
    }else{
        return @"";
    }
}

//userid
- (void)setUserid:(NSString *)userid
{
    
    if (userid) {
        [[ITTDataCacheManager sharedManager] addObject:userid forKey:KEY_CACHE_USER_ID];
    }else{
        [[ITTDataCacheManager sharedManager] removeObjectInCacheByKey:KEY_CACHE_USER_ID];
    }
}

- (NSString *)userid
{
    NSString * userid = [[ITTDataCacheManager sharedManager] getCachedObjectByKey:KEY_CACHE_USER_ID];
    if (userid) {
        return userid;
    }else{
        return @"";
    }
}
//deviceId
- (void)setDeviceId:(NSString *)deviceId
{
    if (deviceId) {
        [[ITTDataCacheManager sharedManager] addObject:deviceId forKey:KEY_CACHE_DEVICE_ID];
        [[ITTDataCacheManager sharedManager] doSave];
    }else{
        [[ITTDataCacheManager sharedManager] removeObjectInCacheByKey:KEY_CACHE_DEVICE_ID];
    }
}
- (NSString *)deviceId
{
    NSString * deviceId = [[ITTDataCacheManager sharedManager] getCachedObjectByKey:KEY_CACHE_DEVICE_ID];
    if (deviceId) {
        return deviceId;
    }else{
        return @"";
    }
}

//deviceName
- (void)setDeviceName:(NSString *)deviceName
{
    if (deviceName) {
        [[ITTDataCacheManager sharedManager] addObject:deviceName forKey:KEY_CACHE_DEVICE_NAME];
    }else{
        [[ITTDataCacheManager sharedManager] removeObjectInCacheByKey:KEY_CACHE_DEVICE_NAME];
    }
}

- (NSString *)deviceName
{
    NSString * deviceName = [[ITTDataCacheManager sharedManager] getCachedObjectByKey:KEY_CACHE_DEVICE_NAME];
    if (deviceName) {
        return deviceName;
    }else{
        return @"";
    }
}

// version
- (void)setHasNewVersion:(BOOL)hasNewVersion
{
    NSString
    * versionString = [NSString stringWithFormat:@"%d",hasNewVersion];
    [[ITTDataCacheManager sharedManager] addObject:versionString forKey:KEY_CACHE_VERSION_UPDATE];
}

- (BOOL)hasNewVersion
{
    if ([[ITTDataCacheManager sharedManager] hasObjectInCacheByKey:KEY_CACHE_VERSION_UPDATE]) {
        return  [[[ITTDataCacheManager sharedManager] getCachedObjectByKey:KEY_CACHE_VERSION_UPDATE] boolValue];
    }
    return FALSE;
}

//- (void)setVersion:(ITTVersion *)version
//{
//    if (version) {
//        [[ITTDataCacheManager sharedManager] addObject:version forKey:KEY_CACHE_VERSION_MODEL];
//    }else{
//        [[ITTDataCacheManager sharedManager] removeObjectInCacheByKey:KEY_CACHE_VERSION_MODEL];
//    }
//}
//
//- (ITTVersion *)version
//{
//    if ([[ITTDataCacheManager sharedManager] hasObjectInCacheByKey:KEY_CACHE_VERSION_MODEL]) {
//        return [[ITTDataCacheManager sharedManager] getCachedObjectByKey:KEY_CACHE_VERSION_MODEL];
//    }
//    return nil;
//}

// Jpush
- (void)setPushOpened:(BOOL)pushOpened
{
    NSString
    * pushString = [NSString stringWithFormat:@"%d",pushOpened];
    [[ITTDataCacheManager sharedManager] addObject:pushString forKey:KEY_CACHE_PUSH_NOTIFICATION];
}

- (BOOL)pushOpened
{
    if ([[ITTDataCacheManager sharedManager] hasObjectInCacheByKey:KEY_CACHE_PUSH_NOTIFICATION]) {
        return  [[[ITTDataCacheManager sharedManager] getCachedObjectByKey:KEY_CACHE_PUSH_NOTIFICATION] boolValue];
    }
    return FALSE;
}
@end
