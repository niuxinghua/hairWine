//
//  ShopDetail.h
//  HaierWine
//
//  Created by 张作伟 on 14-8-27.
//
//

#import "ITTBaseModelObject.h"

@interface ShopDetail : ITTBaseModelObject

@property(nonatomic,strong) NSString *shopLogo;
@property(nonatomic,strong) NSString *shopName;
@property(nonatomic,strong) NSString *shopAddress;
@property(nonatomic,strong) NSString *shopPhone;
@property(nonatomic,strong) NSString *shopDisservice;
@property(nonatomic,strong) NSArray  *shopList;
@property(nonatomic,strong) NSArray  *wineNameArray;


@end
