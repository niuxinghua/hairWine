//
//  WineDetailInfo.h
//  HaierWine
//
//  Created by isoftstone on 14-7-8.
//
//

#import "ITTBaseModelObject.h"
#import "WineGrape.h"
#import "WineLevel.h"
@interface WineDetailInfo : ITTBaseModelObject

@property (nonatomic,strong) NSString *wineIntroduction;
@property (nonatomic,strong) NSString *wineSoundUrl;
@property (nonatomic,strong) NSString *wineRecommendTemperature;
@property (nonatomic,strong) NSString *wineType;
@property (nonatomic,strong) NSString *wineYear;
@property (nonatomic,strong) NSString *grapeType;
@property (nonatomic,strong) NSString *wineNetContent;
@property (nonatomic,strong) NSString *wineLevel;
@property (nonatomic,strong) NSString *wineAlcohol;
@property (nonatomic,strong) NSString *wineOccasion;
@property (nonatomic,strong) NSString *wineCountry;
@property (nonatomic,strong) NSString *wineCity;
@property (nonatomic,strong) NSString *wineImported;
@property (nonatomic,strong) NSString *wineAgent;
@property (nonatomic,strong) NSString *wineCityPic;
@property (nonatomic,strong) NSString *wineForeignMerchant;
@property (nonatomic,strong) NSString *wineEcity;
@property (nonatomic,strong) NSArray  *winePicture;
@property (nonatomic,strong) NSString *wineForeignName;
@property (nonatomic,strong) NSString *wineCollectState;
@property (nonatomic,strong) WineGrape *wineGrapeClass;
@property (nonatomic,strong) WineLevel *winesLevel;

//酒商id
@property (nonatomic,strong) NSString *wineMerchantsId;


@end
