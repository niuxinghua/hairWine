//
//  WineShopDetail.h
//  HaierWine
//
//  Created by 张作伟 on 14-8-13.
//
//

#import "ITTBaseModelObject.h"

@interface WineShopDetail : ITTBaseModelObject

@property (nonatomic,strong) NSString *wineShopLogoUrl;
@property (nonatomic,strong) NSString *wineShopName;
@property (nonatomic,strong) NSString *wineShopAddress;
@property (nonatomic,strong) NSString *wineShopPhone;
@property (nonatomic,strong) NSString *wineShopDisservices;

@end
