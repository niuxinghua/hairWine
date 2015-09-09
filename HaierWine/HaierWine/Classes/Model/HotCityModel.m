//
//  HotCityModel.m
//  HaierWine
//
//  Created by david on 14/8/19.
//
//

#import "HotCityModel.h"

@implementation HotCityModel
- (NSDictionary *)attributeMapDictionary
{
    return @{@"cityId": @"id",
             @"cityCityName": @"cityName",
             @"cityCountryId": @"countryid"
             };
}
@end
