//
//  LoginErrorMoreManager.h
//  HaierWine
//
//  Created by 张作伟 on 14-10-9.
//
//

#import <Foundation/Foundation.h>
#import "UserNameAndPassword.h"

@interface LoginErrorMoreManager : NSObject

+ (LoginErrorMoreManager *)sharedLoginErrorMoreManager;

// 根据加入的password model 判断到底错误登录了几次
- (BOOL)judgeByUser:(NSString *)user password:(NSString *)password currDate:(NSDate *)currDate;
- (BOOL)addPassword:(UserNameAndPassword *)model;

//登录成功以后清除 cache
- (void)clearCache;
@end
