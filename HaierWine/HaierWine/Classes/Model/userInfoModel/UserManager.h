//
//  UserManager.h
//  HaierIceBox
//
//  Created by jeremy on 14-5-21.
//
//

#import <Foundation/Foundation.h>
#import "UserModel.h"
//该类为了 保存登陆成功的手机号和密码信息
//用于最近登陆的用户信息提示

@interface UserManager : NSObject

+ (UserManager *)sharedUserManager;
//获取保存用户数组
- (NSArray *)getAllUsers;
//获取上次登陆用户
- (UserModel *)getLastLoginUser;

- (void)addUser:(UserModel *)userModel;
- (void)removeUserAtIndex:(NSInteger)index;



@end
