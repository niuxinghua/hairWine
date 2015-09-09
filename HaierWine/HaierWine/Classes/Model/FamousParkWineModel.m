//
//  FamousParkWineModel.m
//  HaierWine
//
//  Created by david on 14/7/14.
//
//

#import "FamousParkWineModel.h"

@implementation FamousParkWineModel
- (NSDictionary *)attributeMapDictionary
{
    
    return @{@"parkId" : @"id",
             @"parkImageurl"  : @"imageurl",
             @"parkName" : @"name",
             @"parkAddress" : @"address",
             @"parkLevel" : @"level",
             @"parkType" : @"type",
             @"parkContry_img" : @"country_img",
             @"parkContry" : @"country"
             };
}
@end
