//
//  UserNameAndPassword.m
//  HaierWine
//
//  Created by 张作伟 on 14-10-9.
//
//

#import "UserNameAndPassword.h"

@implementation UserNameAndPassword

- (NSDictionary *)attributeMapDictionary
{
    return @{@"user": @"user",
             @"pwd":@"pwd",
             @"counter":@"counter",
             @"startTimer":@"startTimer"};
    
}

@end
