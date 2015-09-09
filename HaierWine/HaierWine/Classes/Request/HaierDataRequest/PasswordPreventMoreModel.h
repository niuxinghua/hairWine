//
//  PasswordPreventMoreModel.h
//  HaierIceBox
//
//  Created by Jeremy on 14-5-29.
//
//

#import "ITTBaseModelObject.h"

@interface PasswordPreventMoreModel : ITTBaseModelObject

@property (copy ,nonatomic) NSString * user;
@property (copy ,nonatomic) NSString * pwd;
@property (copy ,nonatomic) NSString * counter;
@property (copy ,nonatomic) NSDate   * startTimer;


@end
