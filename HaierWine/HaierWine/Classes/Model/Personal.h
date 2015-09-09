//
//  Personal.h
//  HaierWine
//
//  Created by isoftstone on 14-7-23.
//
//

#import "ITTBaseModelObject.h"
#import "UserBase.h"
#import "UserProfile.h"

@interface Personal : ITTBaseModelObject

@property(nonatomic,strong)UserBase    *userBase;
@property(nonatomic,strong)UserProfile *userProfile;
@property(nonatomic,assign)BOOL        isBindingDevice;

@end
