//
//  ZZWBaseRequest.m
//  HaierWine
//
//  Created by leon on 14-7-2.
//
//

#import "ZZWBaseRequest.h"
#import "WineDetailInfo.h"
#import "WineDetailImages.h"
#import "WineFactoryDeatil.h"
#import "winePrice.h"
#import "RecommendWine.h"
#import "WineShop.h"
#import "WineLevel.h"
#import "WineGrape.h"
#import "ShopDetail.h"

@implementation ZZWBaseRequest

@end

@implementation wineDetailRequest

-(ITTRequestMethod)getRequestMethod
{
    return ITTRequestMethodGet;
}

-(NSString *)getRequestUrl
{
    return REQUEST_URL(@"m/appgoods");
}

-(void)processResult
{
    [super processResult];
   // NSLog(@"酒品详情酒品详情酒品详情酒品详情%@",self.handleredResult);
    if ([self isSuccess]&&[self.handleredResult[@"result"] isEqualToString:@"0"]) {
        NSDictionary *grapeDict = self.handleredResult[@"data"][@"grape"];
        WineGrape *wineGrape = [[WineGrape alloc]initWithDataDic:grapeDict];
        NSDictionary *grapeLevel = self.handleredResult[@"data"][@"level"];
        WineLevel *level = [[WineLevel alloc]initWithDataDic:grapeLevel];
        NSDictionary *dataDict = (self.handleredResult)[@"data"];
        if (dataDict == nil) {
            return;
        }
        NSArray *images = dataDict[@"images"];
        NSMutableArray *data = [[NSMutableArray alloc]init];
        WineDetailInfo *info = [[WineDetailInfo alloc]initWithDataDic:dataDict];
        info.wineCollectState = self.handleredResult[@"collectState"];
        for (NSDictionary *dic in images) {
            WineDetailImages *images = [[WineDetailImages alloc]initWithDataDic:dic];
            [data addObject:images];
        }
        info.grapeType = wineGrape.grapeName;
        info.wineLevel = level.levelName;
        info.winePicture = data;
        info.wineGrapeClass = wineGrape;
        info.winesLevel = level;
        [self.handleredResult setObject:info forKey:@"WineDetailInfo"];
      //  NSArray *array = @[info];
      //  [[HaierDataCacheManager sharedManager] addData:array WithKey:@"WineDetailInfo"];

    }
}

@end

@implementation wineAntiFakeRequest

-(ITTRequestMethod)getRequestMethod
{
    return ITTRequestMethodGet;
}

-(NSString *)getRequestUrl
{
    return REQUEST_URL(@"m/appgoodsFW");
}

-(void)processResult
{
    //    NSLog(@"防伪防伪%@",self.handleredResult);
    [super processResult];
    if ([self isSuccess]) {
     //   NSLog(@"%@",self.handleredResult);
        NSMutableArray *images = [[NSMutableArray alloc]init];
        NSArray *data = self.handleredResult[@"data"][@"url"];
        for (NSDictionary *dic in data) {
            NSString *url = dic[@"security_traceability_pic"];
            [images addObject:url];
        }
        
        [self.handleredResult setObject:images forKey:@"wineAntiFakeRequest"];
      //  NSArray *array = @[images];
      //  [[HaierDataCacheManager sharedManager] addData:array WithKey:@"wineAntiFakeRequest"];
    }
}

@end

@implementation wineFactoryRequest

-(ITTRequestMethod)getRequestMethod
{
    return ITTRequestMethodGet;
}

-(NSString *)getRequestUrl
{
    return REQUEST_URL(@"m/appchateau");
}

-(void)processResult
{
   // NSLog(@"%@",self.handleredResult);
    [super processResult];
    if ([self isSuccess]) {
        NSDictionary *dataDict = (self.handleredResult)[@"data"];
        NSArray *picArray = dataDict[@"imageurl"];
        NSMutableArray *imageArray = [[NSMutableArray alloc]init];
        for (NSDictionary *dict in picArray) {
            NSString *url = dict[@"url"];
         //   NSLog(@"++++%@",url);
            [imageArray addObject:url];
        }
        NSArray *wineListArray = dataDict[@"list"];
        NSMutableArray *wineNameArray = [[NSMutableArray alloc]init];
      //  NSMutableArray *wineArray = [[NSMutableArray alloc]init];
        NSMutableArray *AllWineArray = [[NSMutableArray alloc]init];
        for (NSDictionary *dict in wineListArray) {
            NSString *className = dict[@"classname"];
            [wineNameArray addObject:className];
            NSArray *wineArr =dict[@"classlist"];
            for (NSDictionary *dict in wineArr) {
                winePrice *wine = [[winePrice alloc]initWithDataDic:dict];
               // [wineArray addObject:wine];
                [AllWineArray addObject:wine];
            }
          //  [AllWineArray addObject:wineArray];
        }
        WineFactoryDeatil *wineFactoryDeatil = [[WineFactoryDeatil alloc]initWithDataDic:dataDict];
        wineFactoryDeatil.wineClassNameArray = wineNameArray;
        wineFactoryDeatil.wineFactoryWinesArray = AllWineArray;
    //    NSLog(@"******%@",imageArray);
        wineFactoryDeatil.wineFactoryPicsArray = imageArray;
        
       [self.handleredResult setObject:wineFactoryDeatil forKey:@"wineFactoryDeatil"];
       // NSArray *array = @[wineFactoryDeatil];
       // [[HaierDataCacheManager sharedManager] addData:array WithKey:@"wineFactoryDeatil"];

      //  NSLog(@"酒庄详情接口  %@",wineFactoryDeatil);
    }
}

@end

@implementation ServiceAgreementRequest

-(ITTRequestMethod)getRequestMethod
{
    return ITTRequestMethodGet;
}

-(NSString *)getRequestUrl
{
    return REQUEST_URL(@"m/appAgreement");
}

-(void)processResult
{
    [super processResult];
    if ([self isSuccess]) {
        if ([self.handleredResult[@"retCode"] isEqualToString:@"21024"]) {
            return;
        }
     //   NSLog(@"88888%@",self.handleredResult);
        NSString *serviceAgreement = self.handleredResult[@"data"][@"content"];
        [self.handleredResult setObject:serviceAgreement forKey:@"serviceAgreement"];
      //  NSArray *array = @[serviceAgreement];
      //  [[HaierDataCacheManager sharedManager] addData:array WithKey:@"serviceAgreement"];
    }

}
@end

@implementation RecommendWineRequest

-(ITTRequestMethod)getRequestMethod
{
    return ITTRequestMethodGet;
}

-(NSString *)getRequestUrl
{
    return REQUEST_URL(@"m/appgoodssearchTJ");
}

-(void)processResult
{
         //   NSLog(@"%@",self.handleredResult);
    [super processResult];
    if ([self isSuccess]) {
        //  NSLog(@"%@",self.handleredResult);
        if ([self.handleredResult[@"retCode"] isEqualToString:@"21024"]) {
            return;
        }
        NSMutableArray *wineArray = [[NSMutableArray alloc]init];
        NSString *recomentWineDefault =  self.handleredResult[@"data"][@"nameDefault"];
        NSArray *list = self.handleredResult[@"data"][@"list"];
        for (NSDictionary *dict in list)
        {
            RecommendWine *recommendWine = [[RecommendWine alloc]initWithDataDic:dict];
            [wineArray addObject:recommendWine];
        }

        [self.handleredResult setObject:wineArray forKey:@"RecommendWine"];
        [self.handleredResult setObject:recomentWineDefault forKey:@"recomentWineDefault"];
     //   NSArray *array = @[wineArray,recomentWineDefault];
      //  [[HaierDataCacheManager sharedManager] addData:array WithKey:@"RecommendWine"];

        //[self.handleredResult removeAllObjects];
    }
    
}

@end

@implementation BingDeviceRequest

-(ITTRequestMethod)getRequestMethod
{
    return ITTRequestMethodPost;
}

-(NSString *)getRequestUrl
{
    return nil;
}

-(void)processResult
{
    [super processResult];
    if ([self isSuccess]) {
      //  NSLog(@"bingding%@",self.handleredResult);
    }
}

- (ITTParameterEncoding)parmaterEncoding
{
    return ITTJSONParameterEncoding;
}

@end

@implementation NewVirsionRequest

-(ITTRequestMethod)getRequestMethod
{
    return ITTRequestMethodGet;
}

-(NSString *)getRequestUrl
{
    return nil;
}

-(void)processResult
{
   // NSLog(@"新版功能介绍 %@",self.handleredResult);
    [super processResult];
    if ([self isSuccess]) {
        
    }
}

- (ITTParameterEncoding)parmaterEncoding
{
    return ITTJSONParameterEncoding;
}

@end

@implementation WineShopRequest

-(ITTRequestMethod)getRequestMethod
{
    return ITTRequestMethodGet;
}

-(NSString *)getRequestUrl
{
    return REQUEST_URL(@"m/appmerchantlist");
}

-(void)processResult
{
   // NSLog(@"%@",self.handleredResult[@"message"]);
    [super processResult];
    if ([self isSuccess]) {
        NSArray *list = self.handleredResult[@"data"][@"list"];
        NSMutableArray *shopArray = [[NSMutableArray alloc]init];
        for (NSDictionary *dict in list) {
            WineShop *shop = [[WineShop alloc]initWithDataDic:dict];
            [shopArray addObject:shop];
        }
        [self.handleredResult setObject:shopArray forKey:@"WineShop"];
     //   [[HaierDataCacheManager sharedManager] addData:shopArray WithKey:@"WineShop"];

    }
}

- (ITTParameterEncoding)parmaterEncoding
{
    return ITTJSONParameterEncoding;
}

@end

@implementation WineShopDetailRequest

-(ITTRequestMethod)getRequestMethod
{
    return ITTRequestMethodGet;
}

-(NSString *)getRequestUrl
{
    return REQUEST_URL(@"m/appmerchant");
}

-(void)processResult
{
  //  NSLog(@"%@",self.handleredResult);
    [super processResult];
    if ([self isSuccess]) {
        NSDictionary *data = self.handleredResult[@"data"];
        ShopDetail *shopDetail = [[ShopDetail alloc]initWithDataDic:data];
        NSArray *list = self.handleredResult[@"data"][@"list"];
        NSMutableArray *wineNameArray = [[NSMutableArray alloc]init];
        NSMutableArray *wineArray = [[NSMutableArray alloc]init];
        NSMutableArray *allWineArray = [[NSMutableArray alloc]init];

        for (NSDictionary *dict in list) {
            NSString *className = dict[@"classname"];
            [wineNameArray addObject:className];
            NSArray *wineArr =dict[@"classlist"];
            for (NSDictionary *dict in wineArr) {
                winePrice *wine = [[winePrice alloc]initWithDataDic:dict];
                 [wineArray addObject:wine];
                //[AllWineArray addObject:wine];
            }
              [allWineArray addObject:wineArray];
        }
        shopDetail.shopList = allWineArray;
        [self.handleredResult setObject:shopDetail forKey:@"ShopDetail"];
        shopDetail.wineNameArray = wineNameArray;
    }
}

- (ITTParameterEncoding)parmaterEncoding
{
    return ITTJSONParameterEncoding;
}

@end

@implementation SellerJoinRequest

-(ITTRequestMethod)getRequestMethod
{
    return ITTRequestMethodGet;
}

-(NSString *)getRequestUrl
{
    return REQUEST_URL(@"m/seeAdminCompany");
}

-(void)processResult
{
    //NSLog(@"%@",self.handleredResult);
    [super processResult];
    if (![self.handleredResult[@"result"] isEqualToString:@"0"]) {
        return;
    }
    if ([self isSuccess]) {
        NSString *address = self.handleredResult[@"data"][@"address"];
        NSString *email = self.handleredResult[@"data"][@"email"];
        NSString *tel = self.handleredResult[@"data"][@"tel"];
        [self.handleredResult setObject:address forKey:@"address"];
        [self.handleredResult setObject:email forKey:@"email"];
        [self.handleredResult setObject:tel forKey:@"tel"];
      //  NSArray *array = @[address,email,tel];
      //  [[HaierDataCacheManager sharedManager] addData:array WithKey:@"SellerJoinRequest"];

        //        NSMutableArray *shopArray = [[NSMutableArray alloc]init];
        //        for (NSDictionary *dict in list) {
        //            WineShop *shop = [[WineShop alloc]initWithDataDic:dict];
        //            [shopArray addObject:shop];
        //        }
        //        [self.handleredResult setObject:shopArray forKey:@"WineShop"];
    }
}

- (ITTParameterEncoding)parmaterEncoding
{
    return ITTJSONParameterEncoding;
}

@end

@implementation GetPMSRequest

-(ITTRequestMethod)getRequestMethod
{
    return ITTRequestMethodPost;
}

-(NSString *)getRequestUrl
{
  //  return [NSString stringWithFormat:@"%@/pms/aas/MB-SINGLEGRADEVIN-0001/assignAdapter",test_url];
  //  NSLog(@"%@",[NSString stringWithFormat:@"%@/pms/aas/MB-SINGLEGRADEVIN-0001/assignAdapter",test_url]);
  return @"http://uhome.haier.net:6080/pms/aas/MB-SINGLEGRADEVIN-0001/assignAdapter";
}

-(void)processResult
{
   // NSLog(@"%@",self.handleredResult);
    [super processResult];
    if ([self isSuccess]) {
        NSString *url = self.handleredResult[@"appAdapter"][@"uri"];
        NSRange range = [url rangeOfString:@":"];
      //  NSLog(@"****%d",range.length)
    //    NSString *str1 = [url substringToIndex:range.location];
        NSString *str2 = [url substringFromIndex:range.location+1];
        range = [str2 rangeOfString:@":"];
        NSString *str3 = [str2 substringToIndex:range.location];
        NSString *getWayPort = [str2 substringFromIndex:range.location+1];
        NSString *getWayDomain = [str3 substringFromIndex:2];
    //    NSLog(@"getWayDomain--%@",getWayDomain);
        [self.handleredResult setObject:getWayDomain forKey:@"getWayDomain"];
        [self.handleredResult setObject:getWayPort forKey:@"getWayPort"];
      //  NSLog(@"getWayDomain--%@",getWayDomain);
      //  NSLog(@"getWayPort--%@",getWayPort);

    }
}

- (ITTParameterEncoding)parmaterEncoding
{
    return ITTJSONParameterEncoding;
}

@end

@implementation AddWineRequest

-(ITTRequestMethod)getRequestMethod
{
    return ITTRequestMethodGet;
}

-(NSString *)getRequestUrl
{
    return REQUEST_URL(@"m/winecabinetgoodsave");
}

-(void)processResult
{
   // NSLog(@"%@",self.handleredResult[@"message"]);
    [super processResult];
    if ([self isSuccess]) {
        
    }
}

- (ITTParameterEncoding)parmaterEncoding
{
    return ITTJSONParameterEncoding;
}

@end

@implementation QueryWineRequest

-(ITTRequestMethod)getRequestMethod
{
    return ITTRequestMethodGet;
}

-(NSString *)getRequestUrl
{
    return REQUEST_URL(@"m/winecabinetgoodsQuall");
}

-(void)processResult
{
    //NSLog(@"%@",self.handleredResult);
    [super processResult];
    if ([self isSuccess]) {
        
    }
}

- (ITTParameterEncoding)parmaterEncoding
{
    return ITTJSONParameterEncoding;
}

@end

@implementation ModifyWineRequest

-(ITTRequestMethod)getRequestMethod
{
    return ITTRequestMethodGet;
}

-(NSString *)getRequestUrl
{
    return REQUEST_URL(@"m/winecabinetgoodsEdit");
}

-(void)processResult
{
   // NSLog(@"%@",self.handleredResult[@"message"]);
    [super processResult];
    if ([self isSuccess]) {
    
    }
}

- (ITTParameterEncoding)parmaterEncoding
{
    return ITTJSONParameterEncoding;
}

@end

@implementation getPushMessage

-(ITTRequestMethod)getRequestMethod
{
    return ITTRequestMethodGet;
}

-(NSString *)getRequestUrl
{
    return nil;
}

-(void)processResult
{
  //  NSLog(@"推送推送%@",self.handleredResult);
    [super processResult];
    if ([self isSuccess]) {
        
    }
}

- (ITTParameterEncoding)parmaterEncoding
{
    return ITTJSONParameterEncoding;
}

@end

@implementation boxWineRequest

-(ITTRequestMethod)getRequestMethod
{
    return ITTRequestMethodGet;
}

-(NSString *)getRequestUrl
{
    return REQUEST_URL(@"m/appgoods");
}

-(void)processResult
{
    [super processResult];
  //  NSLog(@"酒品详情酒品详情酒品详情酒品详情%@",self.handleredResult);
    if ([self isSuccess]&&[self.handleredResult[@"result"] isEqualToString:@"0"]) {
        //  NSArray *array = @[info];
        //  [[HaierDataCacheManager sharedManager] addData:array WithKey:@"WineDetailInfo"];
        
    }
}
@end

@implementation SaveUserInfoRequest

-(ITTRequestMethod)getRequestMethod
{
    return ITTRequestMethodGet;
}

-(NSString *)getRequestUrl
{
    return REQUEST_URL(@"m/saveappuservali");
}

-(void)processResult
{
    [super processResult];
    if ([self isSuccess]&&[self.handleredResult[@"result"] isEqualToString:@"0"]) {
        //  NSArray *array = @[info];
        //  [[HaierDataCacheManager sharedManager] addData:array WithKey:@"WineDetailInfo"];
        
    }
}

@end

@implementation DelegateBoxWineRequest

-(ITTRequestMethod)getRequestMethod
{
    return ITTRequestMethodGet;
}

-(NSString *)getRequestUrl
{
    return REQUEST_URL(@"m/winecabinetgoodsDel");
}

-(void)processResult
{
    [super processResult];
    if ([self isSuccess]) {

        
    }
}

@end

@implementation DelegateCollectionRequest

-(ITTRequestMethod)getRequestMethod
{
    return ITTRequestMethodGet;
}

-(NSString *)getRequestUrl
{
    return REQUEST_URL(@"m/appstowRm");
}

-(void)processResult
{
  //  NSLog(@"删除收藏删除收藏删除收藏%@",self.handleredResult);

    [super processResult];
    if ([self isSuccess]) {
        //  NSArray *array = @[info];
        //  [[HaierDataCacheManager sharedManager] addData:array WithKey:@"WineDetailInfo"];
        
    }
}

@end
