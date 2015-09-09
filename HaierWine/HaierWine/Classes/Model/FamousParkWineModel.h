//
//  FamousParkWineModel.h
//  HaierWine
//
//  Created by david on 14/7/14.
//
//

#import "ITTBaseModelObject.h"


@interface FamousParkWineModel : ITTBaseModelObject
@property(nonatomic,strong)NSString *parkId;
@property(nonatomic,strong)NSString *parkImageurl;
@property(nonatomic,strong)NSString *parkName;
@property(nonatomic,strong)NSString *parkAddress;
@property(nonatomic,strong)NSString *parkLevel;
@property(nonatomic,strong)NSString *parkType;
@property(nonatomic,strong)NSString *parkContry_img;
@property(nonatomic,strong)NSString *parkContry;
@end
