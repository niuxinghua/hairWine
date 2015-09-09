//
//  UserBaseModel.h
//  HaierIceBox
//
//  Created by Jeremy on 14-6-12.
//
//

#import "ITTBaseModelObject.h"

@interface UserBaseModel : ITTBaseModelObject

@property (nonatomic, strong) NSString * userId;
@property (nonatomic, copy) NSString * loginName;
@property (nonatomic, copy) NSString * mobile;
@property (nonatomic, copy) NSString *  accType;
@property (nonatomic, copy) NSString * email;
@property (nonatomic, copy) NSString *  status;

@end
