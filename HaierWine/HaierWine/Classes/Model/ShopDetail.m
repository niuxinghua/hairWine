//
//  ShopDetail.m
//  HaierWine
//
//  Created by 张作伟 on 14-8-27.
//
//

#import "ShopDetail.h"

@implementation ShopDetail

- (NSDictionary *)attributeMapDictionary
{
    return @{@"shopLogo"      : @"logourl",
             @"shopName"      : @"name",
             @"shopAddress"   : @"address",
             @"shopPhone"     : @"phone",
             @"shopDisservice": @"disservices",
             @"shopList"      : @"list",
             @"wineNameArray" : @"wineNameArray"
             };
}

@end
