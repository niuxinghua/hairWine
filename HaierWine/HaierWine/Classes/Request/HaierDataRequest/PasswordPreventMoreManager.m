//
//  PasswordPreventMoreManager.m
//  HaierIceBox
//
//  Created by Jeremy on 14-5-29.
//
//

#import "PasswordPreventMoreManager.h"
#import "ITTObjectSingleton.h"

@interface PasswordPreventMoreManager()
{

}
@end

@implementation PasswordPreventMoreManager

ITTOBJECT_SINGLETON_BOILERPLATE(PasswordPreventMoreManager, sharedPasswordPreventMoreManager);

- (BOOL)judgeByUser:(NSString *)user password:(NSString *)password currDate:(NSDate *)currDate
{
    PasswordPreventMoreModel * model = [[PasswordPreventMoreModel alloc]init];
    model.user = user;
    model.pwd = password;
    model.counter  = @"1";
    model.startTimer = currDate;
    return [self addPassword:model];
}

- (BOOL)addPassword:(PasswordPreventMoreModel *)model
{
   PasswordPreventMoreModel * cacheModel = [[ITTDataCacheManager sharedManager] getCachedObjectByKey:KEY_CACHE_PREVENT_PWD_MORE];
    if (cacheModel == nil) {
        //表示user id 是第一次密码输入错误  所以直接加入到本地缓存
        [[ITTDataCacheManager sharedManager] addObject:model forKey:KEY_CACHE_PREVENT_PWD_MORE];
        return NO;
    }
    // 根据user 判断是否是同一user
    if ([cacheModel.user isEqual:model.user]) {
        //在3分钟时间范围之内
        if ([self compareCacheDate:cacheModel.startTimer currDate:model.startTimer]) {
            int counter = [cacheModel.counter intValue] + 1;
            if (counter>5) {
                return YES;
            }else{
                cacheModel.counter = [NSString stringWithFormat:@"%d",counter];
                [[ITTDataCacheManager sharedManager] addObject:cacheModel forKey:KEY_CACHE_PREVENT_PWD_MORE];
                return NO;
            }
        //超出3分钟之内，重新counte
        }else{
            [[ITTDataCacheManager sharedManager] addObject:model forKey:KEY_CACHE_PREVENT_PWD_MORE];
            return NO;
        }
    //不相同user 直接重新counte
    }else{
        [[ITTDataCacheManager sharedManager] addObject:model forKey:KEY_CACHE_PREVENT_PWD_MORE];
        return NO;
    }
}

- (BOOL)compareCacheDate:(NSDate *)lastDate currDate:(NSDate *)currDate
{
    NSComparisonResult  compareResult = [((NSDate *)[lastDate dateByAddingTimeInterval:3*60]) compare:currDate];
    if (compareResult < 0) {
        return NO;
    }else{
        return YES;
    }
}

- (void)clearCache
{
    if ([[ITTDataCacheManager sharedManager] hasObjectInCacheByKey:KEY_CACHE_PREVENT_PWD_MORE]) {
        [[ITTDataCacheManager sharedManager] removeObjectInCacheByKey:KEY_CACHE_PREVENT_PWD_MORE];
    }
}

@end
