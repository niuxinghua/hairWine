//
//  MyLoveWine.h
//  HaierWine
//
//  Created by isoftstone on 14-7-21.
//
//

#import "ITTBaseModelObject.h"

@interface MyLoveWine : ITTBaseModelObject

//我的爱酒（收藏） 我的浏览共有
@property(nonatomic,strong)NSString *wineId;
@property(nonatomic,strong)NSString *wineGoodsId;
@property(nonatomic,assign)BOOL     isChecked;

//我的爱酒（收藏）
@property(nonatomic,strong)NSString *winePrice;
@property(nonatomic,strong)NSString *wineName;
@property(nonatomic,strong)NSString *winePic;

//我的浏览
@property(nonatomic,strong)NSString *scanwineName;
@property(nonatomic,strong)NSString *wineScanPic;
@end
