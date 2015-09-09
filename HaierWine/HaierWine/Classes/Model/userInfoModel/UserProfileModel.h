//
//  UserProfileModel.h
//  HaierIceBox
//
//  Created by Jeremy on 14-6-12.
//
//

#import "ITTBaseModelObject.h"

@interface UserProfileModel : ITTBaseModelObject

@property (nonatomic, copy) NSString * avatarUrl;
@property (nonatomic, copy) NSString * nickName;

@end
