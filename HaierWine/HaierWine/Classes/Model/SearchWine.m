//
//  searchWine.m
//  HaierWine
//
//  Created by isoftstone on 14-7-21.
//
//

#import "SearchWine.h"

@implementation SearchWine

- (NSDictionary *)attributeMapDictionary
{
    return @{@"wineName"  : @"name",
             @"wineId"    : @"id"   ,
             @"wineImageUrl":@"url"};
}

@end
