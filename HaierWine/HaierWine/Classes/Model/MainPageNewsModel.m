//
//  MainPageNewsModel.m
//  HaierWine
//
//  Created by david on 14/7/17.
//
//

#import "MainPageNewsModel.h"

@implementation MainPageNewsModel

- (NSDictionary *)attributeMapDictionary
{
   
    return @{
             @"mainId"  : @"id",
             @"mainTitle" : @"title",
             @"mainDate" : @"date",
             @"mainImageurl" : @"imageurl"
             };
}

@end
