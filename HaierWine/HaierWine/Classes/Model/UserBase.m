//
//  UserBase.m
//  HaierWine
//
//  Created by isoftstone on 14-7-23.
//
//

#import "UserBase.h"

@implementation UserBase

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
