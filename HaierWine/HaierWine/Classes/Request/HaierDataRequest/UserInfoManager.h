//
//  UserInfoManager.h
//  HaierIceBox
//
//  Created by Jeremy on 14-6-9.
//
//

#import <Foundation/Foundation.h>

@interface UserInfoManager : NSObject
//user info
//修改用户信息
+ (void)modifyUserInfoByProfile:(NSDictionary *)profile completion:(void(^)(BOOL isSuccess, NSString * returnMsg))completion;
//查询用户信息
+ (void)queryUserInfoWhenCompletion:(void(^)(BOOL isSuccess, id responseObject))completion;
//上传用户头像
+ (void)uploadAvatarByAvatarData:(NSData *)avatarData ext:(NSString *)ext showView:(UIView *)showView completion:(void(^)(BOOL isSuccess, id responseObject))completion;

// user device
//获取用户设备列表
+ (void)getUserDeviceWhenCompletion:(void(^)(BOOL isSuccess, id responseObject))completion;
//绑定设备
+ (void)bindDeviceByDevice:(NSDictionary *)deviceDict completion:(void(^)(BOOL isSuccess, id responseObject))completion;
//解绑设备
+ (void)unbindDeviceByUserIds:(NSArray *)userIdArray completion:(void(^)(BOOL isSuccess, id responseObject))completion;
//设备重命名
+ (void)renameDeiveByNewname:(NSString *)newname completion:(void(^)(BOOL isSuccess, id responseObject))completion;
//查询设备信息
+ (void)queryDeviceInfoWhenCompletion:(void (^)(BOOL, id))completion;


@end
