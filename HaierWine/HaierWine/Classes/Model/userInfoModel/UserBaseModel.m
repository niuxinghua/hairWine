//
//  UserBaseModel.m
//  HaierIceBox
//
//  Created by Jeremy on 14-6-12.
//
//

#import "UserBaseModel.h"

@implementation UserBaseModel

- (NSDictionary *)attributeMapDictionary
{
    return @{@"userId": @"id",
             @"loginName":@"loginName",
             @"mobile":@"mobile",
             @"accType":@"accType",
             @"email":@"email",
             @"status":@"status"
             };
}


@end
