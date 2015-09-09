//
//  MainPageLbModel.m
//  HaierWine
//
//  Created by david on 14/7/17.
//
//

#import "MainPageLbModel.h"

@implementation MainPageLbModel

- (NSDictionary *)attributeMapDictionary
{

    return @{
             @"mainId"  : @"id",
             @"mainImageurl" : @"imageurl",
             @"mainType" : @"type",
             @"mainTypeId" : @"typeid"
             };
}

@end
