//
//  HelpMeModel.m
//  HaierWine
//
//  Created by david on 14/8/11.
//
//

#import "HelpMeModel.h"

@implementation HelpMeModel
- (NSDictionary *)attributeMapDictionary
{
    return @{@"helpMeName"      : @"helpname",
             @"helpMeContent"   : @"content",
             @"helpMeImage"     : @"img"
             };
}
@end
