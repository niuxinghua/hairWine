//
//  wineShop.h
//  HaierWine
//
//  Created by 张作伟 on 14-8-13.
//
//

#import "ITTBaseModelObject.h"

@interface WineShop : ITTBaseModelObject

@property (nonatomic,strong) NSString *wineShopId;
@property (nonatomic,strong) NSString *wineShopName;
@property (nonatomic,strong) NSString *winePrice;
@property (nonatomic,strong) NSString *wineShopType;
@property (nonatomic,strong) NSString *wineShopUrl;



@end
