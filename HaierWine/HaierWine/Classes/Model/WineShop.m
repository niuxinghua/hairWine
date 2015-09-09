//
//  wineShop.m
//  HaierWine
//
//  Created by 张作伟 on 14-8-13.
//
//

#import "WineShop.h"

@implementation WineShop

- (NSDictionary *)attributeMapDictionary
{
    return @{@"wineShopId": @"id",
             @"wineShopName": @"name",
             @"winePrice": @"price",
             @"wineShopType": @"type",
             @"wineShopUrl": @"url"};
}

@end
