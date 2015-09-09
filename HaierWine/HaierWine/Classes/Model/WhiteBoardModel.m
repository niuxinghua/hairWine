//
//  WhiteBoardModel.m
//  HaierWine
//
//  Created by david on 14/7/28.
//
//

#import "WhiteBoardModel.h"

@implementation WhiteBoardModel

- (NSDictionary*)attributeMapDictionary
{
    return @{@"whiteBoardColorName": @"colorName",
             @"whiteBoardColorid"  : @"colorId",
             @"whiteBoardPlanList"  : @"planList",
             @"whiteBoardColorCode"  : @"colorcode",
             @"whiteBoardTextHeight" :@"whiteBoardTextHeight"};
}

@end
