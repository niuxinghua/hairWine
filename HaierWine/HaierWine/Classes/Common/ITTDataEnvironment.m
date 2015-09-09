//
//  DataEnvironment.m
//  
//
//  Copyright 2010 itotem. All rights reserved.
//


#import "ITTDataEnvironment.h"
#import "ITTDataCacheManager.h"
#import "ITTNetworkTrafficManager.h"
#import "ITTObjectSingleton.h"
@interface ITTDataEnvironment()
- (void)restore;
- (void)registerMemoryWarningNotification;
@end
@implementation ITTDataEnvironment
@synthesize person = _person;
@synthesize device = _device;
@synthesize iosDeviceToken = _iosDeviceToken;
@synthesize pushMessageArray = _pushMessageArray;
@synthesize userName = _userName;
@synthesize userPassword = _userPassword;
@synthesize wineID = _wineID;
@synthesize wineName = _wineName;
@synthesize voiceOn= _voiceOn;
@synthesize deviceMac = _deviceMac;
@synthesize userAvatarUrl = _userAvatarUrl;
@synthesize userNickName = _userNickName;
@synthesize suitableTemp = _suitableTemp;
@synthesize wineType = _wineType;
//@synthesize isWineHelp = _isWineHelp;


ITTOBJECT_SINGLETON_BOILERPLATE(ITTDataEnvironment, sharedDataEnvironment)

#pragma mark - suitableTemp

- (void)setSuitableTemp:(NSString *)suitableTemp
{
    _suitableTemp = suitableTemp;
    if (_suitableTemp){
        [[ITTDataCacheManager sharedManager] addObject:_suitableTemp  forKey:@"suitableTemp"];
    } else {
        [[ITTDataCacheManager sharedManager] addObject:@"" forKey:@"suitableTemp"];
    }
}

- (NSString *)suitableTemp
{
    return [[ITTDataCacheManager sharedManager] getCachedObjectByKey:@"suitableTemp"];
}

- (void)setWineType:(NSString *)wineType
{
    _wineType = wineType;
    if (_wineType){
        [[ITTDataCacheManager sharedManager] addObject:_wineType  forKey:@"wineType"];
    } else {
        [[ITTDataCacheManager sharedManager] addObject:@"" forKey:@"wineType"];
    }
}

- (NSString *)wineType
{
    return [[ITTDataCacheManager sharedManager] getCachedObjectByKey:@"wineType"];
}
#pragma mark - userAvatarUrl

- (void)setUserAvatarUrl:(NSString *)userAvatarUrl
{
    _userAvatarUrl = userAvatarUrl;
    if (_userAvatarUrl){
        [[ITTDataCacheManager sharedManager] addObject:_userAvatarUrl  forKey:@"userAvatarUrl"];
    } else {
        [[ITTDataCacheManager sharedManager] addObject:@"" forKey:@"userAvatarUrl"];
    }
}

- (NSString *)userAvatarUrl
{
    return [[ITTDataCacheManager sharedManager] getCachedObjectByKey:@"userAvatarUrl"];
}


#pragma mark - userNickName

- (void)setUserNickName:(NSString *)userNickName
{
    _userNickName = userNickName;
    if (_userNickName){
        [[ITTDataCacheManager sharedManager] addObject:_userNickName  forKey:@"userNickName"];
    } else {
        [[ITTDataCacheManager sharedManager] addObject:@"" forKey:@"userNickName"];
    }
}

- (NSString *)userNickName
{
    return [[ITTDataCacheManager sharedManager] getCachedObjectByKey:@"userNickName"];
}

#pragma mark - voiceOn

- (void)setDeviceMac:(NSString *)deviceMac
{
    _deviceMac = deviceMac;
    if (_deviceMac){
        [[ITTDataCacheManager sharedManager] addObject:_deviceMac  forKey:@"deviceMac"];
    } else {
        [[ITTDataCacheManager sharedManager] addObject:@"" forKey:@"deviceMac"];
    }
}

- (NSString *)deviceMac
{
    return [[ITTDataCacheManager sharedManager] getCachedObjectByKey:@"deviceMac"];
}


#pragma mark - voiceOn

- (void)setVoiceOn:(NSString *)voiceOn
{
    _voiceOn = voiceOn;
    if (_voiceOn){
        [[ITTDataCacheManager sharedManager] addObject:_voiceOn  forKey:@"voiceOn"];
    } else {
        [[ITTDataCacheManager sharedManager] addObject:@"" forKey:@"voiceOn"];
    }
}

- (NSString *)voiceOn
{
    return [[ITTDataCacheManager sharedManager] getCachedObjectByKey:@"voiceOn"];
}

#pragma mark - userName

- (void)setUserName:(NSString *)userName
{
    _userName = userName;
    if (_userName){
        [[ITTDataCacheManager sharedManager] addObject:_userName  forKey:@"userName"];
    } else {
        [[ITTDataCacheManager sharedManager] addObject:@"" forKey:@"userName"];
    }
}

- (NSString *)userName
{
    return [[ITTDataCacheManager sharedManager] getCachedObjectByKey:@"userName"];
}

#pragma mark - userPassword

- (void)setUserPassword:(NSString *)userPassword
{
    _userPassword = userPassword;
    if (_userPassword){
        [[ITTDataCacheManager sharedManager] addObject:_userPassword  forKey:@"userPassword"];
    } else {
        [[ITTDataCacheManager sharedManager] addObject:@"" forKey:@"userPassword"];
    }

}

- (NSString *)userPassword
{
    return [[ITTDataCacheManager sharedManager] getCachedObjectByKey:@"userPassword"];
}

#pragma mark - wineName

- (void)setWineName:(NSString *)wineName
{
    _wineName = wineName;
    if (_wineName){
        [[ITTDataCacheManager sharedManager] addObject:_wineName  forKey:@"wineName"];
    } else {
        [[ITTDataCacheManager sharedManager] addObject:@"" forKey:@"wineName"];
    }
    
}

- (NSString *)wineName
{
    return [[ITTDataCacheManager sharedManager] getCachedObjectByKey:@"wineName"];
}


#pragma mark - userPassword

- (void)setWineID:(NSString *)wineID
{
    _wineID = wineID;
    if (_wineID){
        [[ITTDataCacheManager sharedManager] addObject:_wineID  forKey:@"wineID"];
    } else {
        [[ITTDataCacheManager sharedManager] addObject:@"" forKey:@"wineID"];
    }
    
}

- (NSString *)wineID
{
    return [[ITTDataCacheManager sharedManager] getCachedObjectByKey:@"wineID"];
}

#pragma mark - pushMessageArray
- (void)setPushMessageArray:(NSArray *)pushMessageArray
{
   // _pushMessageArray = pushMessageArray;
  //  if (_pushMessageArray){
        [[ITTDataCacheManager sharedManager] addObject:pushMessageArray  forKey:@"pushMessageArray"];
   // } else {
   //     [[ITTDataCacheManager sharedManager] addObject:@"" forKey:@"pushMessageArray"];
   // }
}

- (NSArray *)pushMessageArray
{
    return [[ITTDataCacheManager sharedManager] getCachedObjectByKey:@"pushMessageArray"];
}

#pragma mark - iosDeviceToken

- (void)setIosDeviceToken:(NSString *)iosDeviceToken
{
    _iosDeviceToken = iosDeviceToken;
    if (_iosDeviceToken) {
        [[ITTDataCacheManager sharedManager] addObject:_iosDeviceToken  forKey:@"iosDeviceToken"];
    } else {
        [[ITTDataCacheManager sharedManager] addObject:@"" forKey:@"iosDeviceToken"];
    }
}

- (NSString*)iosDeviceToken
{
    return [[ITTDataCacheManager sharedManager] getCachedObjectByKey:@"iosDeviceToken"];

}

#pragma mark - Personal

#define keyPerson @"keyPerson123asd12"

//- (void)setPerson:(Personal *)person
//{
//    NSLog(@"%@",person.userProfile.nickName);
//    _person = person;
//    if (_person) {
//        [[ITTDataCacheManager sharedManager] addObject:_person forKey:keyPerson];
//    } else {
//        [[ITTDataCacheManager sharedManager] addObject:@"" forKey:keyPerson];
//    }
//    
//}
//
//- (Personal *)person
//{
//   // NSLog(@"%@",((Personal*)[[ITTDataCacheManager sharedManager] getCachedObjectByKey:keyPerson]).userProfile.nickName);
//    return [[ITTDataCacheManager sharedManager] getCachedObjectByKey:keyPerson];
//    
//}

#pragma mark - Device

#define keyDevice @"keyDevice123asd12"

- (void)setDevice:(WineDevice *)device
{
     _device = device;
    if (_device) {
        [[ITTDataCacheManager sharedManager] addObject:_device forKey:keyDevice];
    } else {
        [[ITTDataCacheManager sharedManager] addObject:@"" forKey:keyDevice];
    }

}
- (WineDevice *)device
{
    return [[ITTDataCacheManager sharedManager] getCachedObjectByKey:keyDevice];
}

#pragma mark - lifecycle methods

- (id)init
{
    self = [super init];
	if ( self) {
		[self restore];
        [self registerMemoryWarningNotification];
	}
	return self;
}

#pragma mark - 

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

- (void)setIsAutoLogin:(BOOL)isAutoLogin
{
    NSString * isMemoryStr = [NSString stringWithFormat:@"%d",isAutoLogin];
    if (isMemoryStr) {
        [[ITTDataCacheManager sharedManager] addObject:isMemoryStr forKey:@"isAutoLogin"];
    }
}

- (BOOL)isAutoLogin
{
    return [[[ITTDataCacheManager sharedManager] getCachedObjectByKey:@"isAutoLogin"] boolValue];
    
}

//- (void)setisWineHelp:(BOOL)isWineHelp
//{
//    NSString * isMemoryStr = [NSString stringWithFormat:@"%d",isWineHelp];
//    if (isWineHelp) {
//        [[ITTDataCacheManager sharedManager] addObject:isMemoryStr forKey:@"isWineHelp"];
//    }
//}
//
//- (BOOL)isWineHelp
//{
//    return [[[ITTDataCacheManager sharedManager] getCachedObjectByKey:@"isWineHelp"] boolValue];
//    
//}
// isLocalOnline
//- (void)setIsLocalOnline:(BOOL)isLocalOnline
//{
//    NSString * isLocalOnlineStr = [NSString stringWithFormat:@"%d",isLocalOnline];
//    if (isLocalOnlineStr) {
//        [[ITTDataCacheManager sharedManager] addObject:isLocalOnlineStr forKey:KEY_CACHE_LOCAL_ONLINE];
//    }
//}
//
//- (BOOL)isLocalOnline
//{
//    return [[[ITTDataCacheManager sharedManager] getCachedObjectByKey:KEY_CACHE_LOCAL_ONLINE] boolValue];
//}
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
        return nil;
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

- (void)setDeviceTypeIdentifier:(NSString *)deviceTypeIdentifier
{
    if (deviceTypeIdentifier) {
        [[ITTDataCacheManager sharedManager] addObject:deviceTypeIdentifier forKey:@"deviceTypeIdentifier"];
    }else{
        [[ITTDataCacheManager sharedManager] removeObjectInCacheByKey:@"deviceTypeIdentifier"];
    }
}

- (NSString *)deviceTypeIdentifier
{
    NSString * deviceTypeIdentifier = [[ITTDataCacheManager sharedManager] getCachedObjectByKey:@"deviceTypeIdentifier"];
    if (deviceTypeIdentifier) {
        return deviceTypeIdentifier;
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

#pragma mark -

-(void)clearNetworkData
{
    [[ITTDataCacheManager sharedManager] clearAllCache];
}

#pragma mark - public methods

- (void)clearCacheData
{
    //clear cache data if needed
}

#pragma mark - private methods

- (void)restore
{
    _urlRequestHost = REQUEST_DOMAIN;
}

- (void)registerMemoryWarningNotification
{
#if TARGET_OS_IPHONE
    // Subscribe to app events
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(clearCacheData)
                                                 name:UIApplicationDidReceiveMemoryWarningNotification
                                               object:nil];    
#ifdef __IPHONE_4_0
    UIDevice *device = [UIDevice currentDevice];
    if ([device respondsToSelector:@selector(isMultitaskingSupported)] && device.multitaskingSupported){
        // When in background, clean memory in order to have less chance to be killed
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(clearCacheData)
                                                     name:UIApplicationDidEnterBackgroundNotification
                                                   object:nil];
    }
#endif
#endif        
}

@end