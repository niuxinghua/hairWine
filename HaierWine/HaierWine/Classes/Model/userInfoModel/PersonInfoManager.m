//
//  UserInfoManager.m
//  HaierIceBox
//
//  Created by Jeremy on 14-6-12.
//
//

#import "PersonInfoManager.h"
#import "ITTObjectSingleton.h"
@implementation PersonInfoManager
ITTOBJECT_SINGLETON_BOILERPLATE(PersonInfoManager, sharedPersonInfoManager);

- (void)refreshPersonInfoBy:(UserModel *)userModel
{
    [[ITTDataCacheManager sharedManager] addObject:userModel forKey:KEY_CACHE_USER_INFO];
    [[ITTDataCacheManager sharedManager] addObject:userModel.userBase forKey:KEY_CACHE_USERBASE_INFO];
    [[ITTDataCacheManager sharedManager] addObject:userModel.userProfile forKey: KEY_CACHE_USERPROFILE_INFO];
    
    
}

- (UserModel *)getPersonInfo
{
    UserModel * userInfo = [[ITTDataCacheManager sharedManager] getCachedObjectByKey:KEY_CACHE_USER_INFO];
    UserBaseModel * userBase =[[ITTDataCacheManager sharedManager] getCachedObjectByKey:KEY_CACHE_USERBASE_INFO];
    UserProfileModel * userProfile = [[ITTDataCacheManager sharedManager] getCachedObjectByKey:KEY_CACHE_USERPROFILE_INFO];
    userInfo.userBase = userBase;
    userInfo.userProfile = userProfile;
    if (userInfo) {
        return userInfo;
    }
    return nil;
}

- (UserBaseModel *)getUserBase
{
    UserModel * user = [self getPersonInfo];
    if (user) {
        if (user.userBase) {
            return user.userBase;
        }
    }
    return nil;
}
- (UserProfileModel *)getUserProfile
{
    UserModel * user = [self getPersonInfo];
    if (user) {
        if (user.userBase) {
            return user.userProfile;
        }
    }
    return nil;
}

- (void)cleanPersonInfo
{
    if ([[ITTDataCacheManager sharedManager] hasObjectInCacheByKey:KEY_CACHE_USER_INFO]) {
        [[ITTDataCacheManager sharedManager] removeObjectInCacheByKey:KEY_CACHE_USER_INFO];
        [[ITTDataCacheManager sharedManager] removeObjectInCacheByKey:KEY_CACHE_USERPROFILE_INFO];
        [[ITTDataCacheManager sharedManager] removeObjectInCacheByKey:KEY_CACHE_USERBASE_INFO];
    }
    
}

@end
