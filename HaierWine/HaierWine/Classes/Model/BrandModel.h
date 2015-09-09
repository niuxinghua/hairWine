//
//  BrandModel.h
//  HaierWine
//
//  Created by david on 14/7/14.
//
//

#import "ITTBaseModelObject.h"

@interface BrandModel : ITTBaseModelObject
@property(nonatomic,strong)NSString *brandId;
@property(nonatomic,strong)NSString *brandImageurl;
@property(nonatomic,strong)NSString *brandName;
@property(nonatomic,strong)NSString *brandCity;
@property(nonatomic,strong)NSString *brandCountry;
@property(nonatomic,strong)NSString *brandCountry_img;
@property(nonatomic,strong)NSString *brandLevel;
@property(nonatomic,strong)NSString *brandLevel_img;
@end
