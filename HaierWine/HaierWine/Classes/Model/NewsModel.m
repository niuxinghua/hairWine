//
//  NewsModel.m
//  HaierWine
//
//  Created by david on 14/7/23.
//
//

#import "NewsModel.h"

@implementation NewsModel
- (NSDictionary*)attributeMapDictionary
{

    return @{@"newsId": @"id",
             @"newsTitle" : @"title",
             @"newsDate" : @"date",
             @"newsPic"  : @"imageurl"
             };
}
@end
