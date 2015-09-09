//
//  PasswordPreventMoreModel.m
//  HaierIceBox
//
//  Created by Jeremy on 14-5-29.
//
//

#import "PasswordPreventMoreModel.h"

@implementation PasswordPreventMoreModel

- (NSDictionary *)attributeMapDictionary
{
    return @{@"user": @"user",
             @"pwd":@"pwd",
             @"counter":@"counter",
             @"startTimer":@"startTimer"};

}

@end
