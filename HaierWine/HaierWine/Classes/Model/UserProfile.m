//
//  UserProfile.m
//  HaierWine
//
//  Created by isoftstone on 14-7-23.
//
//

#import "UserProfile.h"

@implementation UserProfile

- (NSDictionary *)attributeMapDictionary
{
    return @{@"avatarUrl"    : @"avatarUrl",
             @"nickName"     : @"nickName",
             @"address"      : @"address",
             @"age"          : @"age",
             @"gender"       : @"gender",
             @"mobilePhone"  : @"mobilePhone"
             };
}

@end
