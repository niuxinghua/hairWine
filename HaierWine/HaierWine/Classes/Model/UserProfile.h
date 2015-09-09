//
//  UserProfile.h
//  HaierWine
//
//  Created by isoftstone on 14-7-23.
//
//

#import "ITTBaseModelObject.h"

@interface UserProfile : ITTBaseModelObject

@property (nonatomic, copy) NSString * avatarUrl;
@property (nonatomic, copy) NSString * nickName;
@property (nonatomic, copy) NSString * address;
@property (nonatomic, copy) NSString * age;
@property (nonatomic, copy) NSString * gender;
@property (nonatomic, copy) NSString * mobilePhone;

@end
