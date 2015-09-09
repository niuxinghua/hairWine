//
//  WineFactoryDeatil.h
//  HaierWine
//
//  Created by isoftstone on 14-7-14.
//
//

#import "ITTBaseModelObject.h"

@interface WineFactoryDeatil : ITTBaseModelObject

@property (nonatomic,strong)NSString *wineFactoryInfo;
@property (nonatomic,strong)NSString *wineFactoryCountary;
@property (nonatomic,strong)NSString *wineFactoryAddress;
@property (nonatomic,strong)NSArray  *wineFactoryPicsArray;
@property (nonatomic,strong)NSArray  *wineFactoryWinesArray;
@property (nonatomic,strong)NSArray  *wineClassNameArray;

@end
