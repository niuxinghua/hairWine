//
//  UserInfoManager.h
//  HaierIceBox
//
//  Created by Jeremy on 14-6-12.
//
//

#import <Foundation/Foundation.h>
#import "UserBaseModel.h"
#import "UserProfileModel.h"
//该类用于登陆成功的用户个人信息保存
@interface PersonInfoManager : NSObject

+ (PersonInfoManager *)sharedPersonInfoManager;

- (void)refreshPersonInfoBy:(UserModel *)userModel;
- (UserModel *)getPersonInfo;
- (UserBaseModel *)getUserBase;
- (UserProfileModel *)getUserProfile;

- (void)cleanPersonInfo;

@end
