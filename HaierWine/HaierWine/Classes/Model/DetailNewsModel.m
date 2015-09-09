//
//  DetailNewsModel.m
//  HaierWine
//
//  Created by david on 14/9/5.
//
//

#import "DetailNewsModel.h"

@implementation DetailNewsModel
- (NSDictionary *)attributeMapDictionary
{
    return @{@"newsPicArr"       : @"url",
             @"newsTitle"   : @"title",
             @"newsDate"    : @"date",
             @"newsContent" : @"content",
             @"newsSource" :@"infosource"
             };
}
@end
