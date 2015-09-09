//
//  WineFactoryDeatil.m
//  HaierWine
//
//  Created by isoftstone on 14-7-14.
//
//

#import "WineFactoryDeatil.h"

@implementation WineFactoryDeatil

- (NSDictionary *)attributeMapDictionary
{
    return @{@"wineFactoryInfo"       : @"info",
             @"wineFactoryCountary"   : @"country",
             @"wineFactoryAddress"    : @"address",
             @"wineFactoryPicsArray"  : @"imageurl",
             };
}
@end
