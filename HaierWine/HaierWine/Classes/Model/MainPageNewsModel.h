//
//  MainPageNewsModel.h
//  HaierWine
//
//  Created by david on 14/7/17.
//
//

#import "ITTBaseModelObject.h"

@interface MainPageNewsModel : ITTBaseModelObject

@property(nonatomic,strong)NSString *mainId;
@property(nonatomic,strong)NSString *mainTitle;
@property(nonatomic,strong)NSString *mainDate;
@property(nonatomic,strong)NSString *mainImageurl;

@end
