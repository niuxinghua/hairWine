//
//  wineDevice.m
//  HaierWine
//
//  Created by leon on 14-7-31.
//
//

#import "WineDevice.h"

@implementation WineDevice

-(NSDictionary *)attributeMapDictionary
{
    return @{@"lamp"              : @"",
             @"temperature"       : @"",
             @"deviceMac"         : @"",
             @"deviceLocation"    : @"",
             @"deviceName"        : @"",
             @"deviceStatus"      : @"",
             @"typeIdentifier"    : @"",
             @"deviceType"        : @"",
             @"smartLinkPlatform" : @"",
             @"smartLinkSoftwareVersion" : @"",
             @"eProtocolVer"      : @""
             };
}

@end
