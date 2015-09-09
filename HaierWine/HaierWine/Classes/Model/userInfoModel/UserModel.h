//
//  UserModel.h
//  HaierIceBox
//
//  Created by jeremy on 14-5-21.
//
//

#import "ITTBaseModelObject.h"
#import "UserBaseModel.h"
#import "UserProfileModel.h"

@interface UserModel : ITTBaseModelObject

@property (strong, nonatomic) NSString * account;               //账号：手机号
@property (strong, nonatomic) NSString * password;              //密码


@property (strong, nonatomic) UserBaseModel * userBase;         //用户基本信息
@property (strong, nonatomic) UserProfileModel * userProfile;   //用户扩展信息

@end
