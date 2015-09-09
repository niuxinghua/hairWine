//
//  PasswordPreventMoreManager.h
//  HaierIceBox
//
//  Created by Jeremy on 14-5-29.
//
//

#import <Foundation/Foundation.h>
#import "PasswordPreventMoreModel.h"
//该类用于密码防刷
@interface PasswordPreventMoreManager : NSObject

+ (PasswordPreventMoreManager *)sharedPasswordPreventMoreManager;

// 根据加入的password model 判断到底错误登陆了几次
- (BOOL)judgeByUser:(NSString *)user password:(NSString *)password currDate:(NSDate *)currDate;
- (BOOL)addPassword:(PasswordPreventMoreModel *)model;

//登陆成功以后清除 cache
- (void)clearCache;

@end
