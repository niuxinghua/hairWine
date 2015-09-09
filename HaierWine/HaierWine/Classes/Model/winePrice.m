//
//  winePrice.m
//  HaierWine
//
//  Created by isoftstone on 14-7-14.
//
//

#import "winePrice.h"

@implementation winePrice

- (NSDictionary *)attributeMapDictionary
{
    return @{@"wineId"     : @"id",
             @"winePrice"  : @"price",
             @"wineName"   : @"winename",
             @"winePic"    : @"s_pic"
             };
}
@end
