//
//  BrandModel.m
//  HaierWine
//
//  Created by david on 14/7/14.
//
//

#import "BrandModel.h"

@implementation BrandModel
- (NSDictionary *)attributeMapDictionary
{
    
    return @{
                      @"brandId" : @"id",
                      @"brandImageurl"  : @"imageurl",
                      @"brandName" : @"name",
                      @"brandCity" : @"city",
                      @"brandCountry" : @"country",
                      @"brandCountry_img" : @"country_img",
                      @"brandLevel_img" : @"level_pic",
                      @"brandLevel" : @"level"
                      };
    
}
@end
