//
//  MyFavouriteWineModel.m
//  HaierWine
//
//  Created by david on 14/7/10.
//
//

#import "MyFavouriteWineModel.h"

@implementation MyFavouriteWineModel

- (NSDictionary *)attributeMapDictionary
{
    return @{@"wineName" : @"gname",
             @"winePic"  : @"goods_pic"
             };
}

@end
