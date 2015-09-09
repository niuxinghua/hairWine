//
//  WineDetailInfo.m
//  HaierWine
//
//  Created by isoftstone on 14-7-8.
//
//

#import "WineDetailInfo.h"
#import "ITTObjectSingleton.h"

@implementation WineDetailInfo

- (NSDictionary *)attributeMapDictionary
{
    return @{@"wineIntroduction"        : @"introduction",
             @"wineSoundUrl"            : @"sound",
             @"wineRecommendTemperature": @"temperature",
             @"wineType"                : @"goods_type",
             @"wineYear"                : @"year",
             @"grapeType"               : @"grape_type",
             @"wineNetContent"          : @"netcontent",
             @"wineLevel"               : @"goods_level",
             @"wineAlcohol"             : @"alcohol",
             @"wineOccasion"            : @"occasion",
             @"wineCountry"             : @"country",
             @"wineCity"                : @"city",
             @"wineImported"            : @"imported",
             @"wineAgent"               : @"agent",
             @"wineCityPic"             : @"map",
             @"winePicture"             : @"Images",
             @"wineForeignMerchant"     : @"foreign_merchant",
             @"wineEcity"               : @"Ecountry",
             @"wineMerchantsId"         : @"merchantsId",
             @"wineForeignName"         : @"wwmc",
             @"wineCollectState"        : @"collectState"};
}

@end
