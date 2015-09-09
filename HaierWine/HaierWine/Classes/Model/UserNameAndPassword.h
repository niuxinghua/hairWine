//
//  UserNameAndPassword.h
//  HaierWine
//
//  Created by 张作伟 on 14-10-9.
//
//

#import "ITTBaseModelObject.h"

@interface UserNameAndPassword : ITTBaseModelObject

@property (copy ,nonatomic) NSString * user;
@property (copy ,nonatomic) NSString * pwd;
@property (copy ,nonatomic) NSString * counter;
@property (copy ,nonatomic) NSDate   * startTimer;

@end
