
//
//  MyLoveWine.m
//  HaierWine
//
//  Created by isoftstone on 14-7-21.
//
//

#import "MyLoveWine.h"

@implementation MyLoveWine

- (NSDictionary*)attributeMapDictionary
{
    return @{@"winePrice": @"price",
             @"wineName" : @"winename",
             @"winePic"  : @"url",
             @"scanwineName":@"name",
             @"wineGoodsId":@"goodsid",
             @"wineId" :@"id",
             @"wineScanPic":@"picurl"};
    //wineId 我的浏览 我的爱酒 删除id
    //wineGoodsId 我的浏览 我的爱酒 进入详情id
    
}
@end
