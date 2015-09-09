//
//  UserBase.h
//  HaierWine
//
//  Created by isoftstone on 14-7-23.
//
//

#import "ITTBaseModelObject.h"

@interface UserBase : ITTBaseModelObject

@property (nonatomic, strong) NSString * userId;
@property (nonatomic, copy)   NSString * loginName;
@property (nonatomic, copy)   NSString * mobile;
@property (nonatomic, copy)   NSString *  accType;
@property (nonatomic, copy)   NSString * email;
@property (nonatomic, copy)   NSString *  status;

@end
