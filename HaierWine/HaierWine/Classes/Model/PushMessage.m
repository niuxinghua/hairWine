//
//  PushMessage.m
//  HaierWine
//
//  Created by 张作伟 on 14-8-19.
//
//

#import "PushMessage.h"

@implementation PushMessage

- (NSDictionary *)attributeMapDictionary
{
    return @{@"messageTitle"     : @"alert",
             @"messageType"      : @"msgtype",
             @"messageContent"   : @"msg",
             @"wineBoxMessage"   : @"wineBoxMessage",
             @"type"             : @"type",
             @"messageTime"      : @"messageTime"};
}

@end
