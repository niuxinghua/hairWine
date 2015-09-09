//
//  TYLBaseRequest.m
//  HaierWine
//
//  Created by leon on 14-7-2.
//
//

#import "TYLBaseRequest.h"
#import "FamousParkWineModel.h"
#import "MainPageModel.h"//没有用
#import "MainPageLbModel.h"
#import "MainPageNewsModel.h"
#import "SearchWine.h"
#import "MyLoveWine.h"
#import "BrandModel.h"
#import "NewsModel.h"
#import "WhiteBoardModel.h"
#import "HelpMeModel.h"
#import "HotCityModel.h"
#import "WineFactoryDeatil.h"
#import "winePrice.h"
#import "DetailNewsModel.h"

@implementation TYLBaseRequest

@end

//logo图
@implementation LogoRequest

-(ITTRequestMethod)getRequestMethod
{
    return ITTRequestMethodGet;
}

-(NSString *)getRequestUrl
{
    return REQUEST_URL(@"m/appLogo");
}

-(void)processResult
{
    [super processResult];
   // NSLog(@"%@",self.handleredResult);

//    NSLog(@"%@",self.handleredResult);
    if ([self isSuccess]) {
        
    }
}
@end
//开机闪图
@implementation StartLogoRequest


-(ITTRequestMethod)getRequestMethod
{
    return ITTRequestMethodGet;
}

-(NSString *)getRequestUrl
{
    return REQUEST_URL(@"m/appFlashPicAction");
}

-(void)processResult
{
    [super processResult];

   // NSLog(@"开机闪图闪入%@",self.handleredResult);

//    NSLog(@"%@",self.handleredResult);

    if ([self isSuccess]) {
        
    }
}

@end
//首页
@implementation HomePageRequest


-(ITTRequestMethod)getRequestMethod
{
    return ITTRequestMethodGet;
}

-(NSString *)getRequestUrl
{
    return REQUEST_URL(@"m/appHomePage");
}

-(void)processResult
{
    [super processResult];
    if ([self isSuccess]) {
        NSDictionary *dic = self.handleredResult[@"data"];

      //  NSLog(@"首页 before %@",self.handleredResult);


        NSArray *lbArr = [dic objectForKey:@"lb"];
        NSArray *newsArr = [dic objectForKey:@"news"];
        NSArray *experienceArr = [dic objectForKey:@"pjxd"];
        NSArray *articeArr = [dic objectForKey:@"artice"];
        NSMutableArray *lbMutableArr = [[NSMutableArray alloc]init];
        NSMutableArray *newsMutableArr = [[NSMutableArray alloc]init];
        NSMutableArray *experienceMutableArr = [[NSMutableArray alloc]init];
        NSMutableArray *articeMutableArr = [[NSMutableArray alloc]init];
        for (NSDictionary* lbDic in lbArr) {
            MainPageLbModel * lbModel = [[MainPageLbModel alloc]initWithDataDic:lbDic];

            [lbMutableArr addObject:lbModel];
        }
        for (NSDictionary* newDic in newsArr) {
            MainPageNewsModel *newsModel = [[MainPageNewsModel alloc]initWithDataDic:newDic];
            [newsMutableArr addObject:newsModel];
        }
        for (NSDictionary* experienceDic in experienceArr) {
            MainPageNewsModel *experienceModel = [[MainPageNewsModel alloc]initWithDataDic:experienceDic];
            [experienceMutableArr addObject:experienceModel];
        }
        for (NSDictionary* articeDic in articeArr) {
            MainPageNewsModel *articeModel = [[MainPageNewsModel alloc]initWithDataDic:articeDic];
            [articeMutableArr addObject:articeModel];
        }
        
//        [self.handleredResult setObject:lbMutableArr forKey:@"lb"];
//        [self.handleredResult setObject:newsMutableArr forKey:@"news"];
//        [self.handleredResult setObject:experienceMutableArr forKey:@"experience"];
//        [self.handleredResult setObject:articeMutableArr forKey:@"artice"];
        //handleredResult里面都有什么数据呢
        [self.handleredResult setValue:lbMutableArr forKey:@"lb"];
        [self.handleredResult setValue:newsMutableArr forKey:@"news"];
        [self.handleredResult setValue:experienceMutableArr forKey:@"experience"];
        [self.handleredResult setValue:articeMutableArr forKey:@"artice"];
        
        

    }
}

@end
//城镇查询
@implementation CountryRequest

-(ITTRequestMethod)getRequestMethod
{
    return ITTRequestMethodGet;
}

-(NSString *)getRequestUrl
{
    return REQUEST_URL_L_B(@"m/appcity");
}

-(void)processResult
{
    [super processResult];

    if ([self isSuccess]) {
        
    }
}

@end

@implementation vegetableRequest

-(ITTRequestMethod)getRequestMethod
{
    return ITTRequestMethodGet;
}

-(NSString *)getRequestUrl
{
    return REQUEST_URL(@"m/appgoodsCJDP");
}

-(void)processResult
{
          //  NSLog(@"vegtable%@",self.handleredResult);
    [super processResult];
    if ([self isSuccess]) {
        if (![self.handleredResult[@"result"] isEqualToString:@"0"]) {
            return;
        }
        NSMutableArray *images = [[NSMutableArray alloc]init];
        NSArray *data = self.handleredResult[@"data"][@"url"];
        for (NSDictionary *dic in data) {
            NSString *url = dic[@"recommend"];
            [images addObject:url];
        }
        
        NSString *footTitle = self.handleredResult[@"data"][@"foodDesc"];
//        [self.handleredResult setObject:images forKey:@"vegetableRequest"];
//        [self.handleredResult setObject:footTitle forKey:@"footTitle"];
        [self.handleredResult setValue:images forKey:@"vegetableRequest"];
        [self.handleredResult setValue:footTitle forKey:@"footTitle"];
    }
}

@end



//品牌汇
@implementation BrandRequest

-(ITTRequestMethod)getRequestMethod
{
    return ITTRequestMethodGet;
}

-(NSString *)getRequestUrl
{
    return REQUEST_URL(@"m/appbrandList");
}

-(void)processResult
{

  //  NSLog(@"2品牌会品牌会品牌会%@",self.handleredResult);
    [super processResult];
    if ([self isSuccess]) {
        NSMutableArray *dataArray = [[NSMutableArray alloc]init];
        NSDictionary *dataDic = self.handleredResult[@"data"];
        NSArray *listArr = [dataDic objectForKey:@"list"];
        for (NSDictionary *dic in listArr) {
            BrandModel *model = [[BrandModel alloc]initWithDataDic:dic];
            [dataArray addObject:model];
        }
     //   [self.handleredResult setObject:dataArray forKey:@"dataArray"];
        [self.handleredResult setValue:dataArray forKey:@"dataArray"];
        
    }
}

@end
//品牌会详情
@implementation BrandDetailRequest

-(ITTRequestMethod)getRequestMethod
{
    return ITTRequestMethodGet;
}

-(NSString *)getRequestUrl
{
    return REQUEST_URL(@"m/appBrandDetail");
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
        
      //  [self.handleredResult setObject:wineFactoryDeatil forKey:@"wineFactoryDeatil"];
        [self.handleredResult setValue:wineFactoryDeatil forKey:@"wineFactoryDeatil"];
        
        
      //  NSLog(@"品牌会详情接口  %@",wineFactoryDeatil);
    }
}

@end



//酒品收藏
@implementation FavouriteWineRequest

-(ITTRequestMethod)getRequestMethod
{
    return ITTRequestMethodGet;
}

-(NSString *)getRequestUrl
{
    return REQUEST_URL(@"m/appstow");
}

-(void)processResult
{

    [super processResult];
    if ([self isSuccess]) {
        
    }
}
@end
//酒品收藏列表
@implementation FavouriteWineListRequest

-(ITTRequestMethod)getRequestMethod
{
    return ITTRequestMethodGet;
}

-(NSString *)getRequestUrl
{
    return REQUEST_URL(@"m/appstowquery");
}

-(void)processResult
{
    [super processResult];
    if ([self isSuccess]) {
        NSMutableArray *array = [[NSMutableArray alloc]init];
        NSArray *list = self.handleredResult[@"data"][@"list"];
        for (NSDictionary *dict in list) {
            MyLoveWine *myLoveWine = [[MyLoveWine alloc]initWithDataDic:dict];
            [array addObject:myLoveWine];
        }
       // [self.handleredResult removeObjectForKey:@"data"];
      //  [self.handleredResult setObject:array forKey:@"MyLoveWine"];
        [self.handleredResult setValue:array forKey:@"MyLoveWine"];

     //   NSLog(@"MyLoveWine--%@",array);


    }
}
@end
//酒品收藏删除
@implementation FavouriteWineDeleteRequest

-(ITTRequestMethod)getRequestMethod
{
    return ITTRequestMethodGet;
}

-(NSString *)getRequestUrl
{
    return REQUEST_URL(@"m/appstowdel");
}

-(void)processResult
{
    [super processResult];
    if ([self isSuccess]) {
        
    }
}
@end

//版本升级
@implementation UpdateRequest

-(ITTRequestMethod)getRequestMethod
{
    return ITTRequestMethodGet;
}

-(NSString *)getRequestUrl
{
    return REQUEST_URL(@"m/appupgrade");
}

-(void)processResult
{
    [super processResult];
    if ([self isSuccess]) {
        
    }
}

@end
//新功能介绍
@implementation NewAppSubRequest

-(ITTRequestMethod)getRequestMethod
{
    return ITTRequestMethodGet;
}

-(NSString *)getRequestUrl
{
    return REQUEST_URL(@"m/appedition");
}

-(void)processResult
{
   // NSLog(@"新功能介绍 %@",self.handleredResult);
    [super processResult];
    if ([self isSuccess]) {
        
    }
}

@end

//扫描条形码空接口
@implementation BarcodeRequest

-(ITTRequestMethod)getRequestMethod
{
    return ITTRequestMethodGet;
}

-(NSString *)getRequestUrl
{
    return REQUEST_URL(@"m/appscanwine");
}

-(void)processResult
{
   // NSLog(@"扫一扫--%@",self.handleredResult);
    [super processResult];
    if ([self isSuccess]) {
        
    }
}

@end
//酒品搜索
@implementation SearchWineRequest

-(ITTRequestMethod)getRequestMethod
{
    return ITTRequestMethodGet;
}

-(NSString *)getRequestUrl
{
    return REQUEST_URL(@"m/appgoodssearch");
}

-(void)processResult
{
    [super processResult];
  //  NSLog(@"$$$$$%@",self.handleredResult);
    NSString *result = self.handleredResult[@"result"];
    NSArray *list = self.handleredResult[@"data"][@"list"];
    NSMutableArray *wineArray = [[NSMutableArray alloc]init];
    for (NSDictionary *dict in list) {
        SearchWine *searchWine = [[SearchWine alloc]initWithDataDic:dict];
        [wineArray addObject:searchWine];
    }
    
  //  [self.handleredResult setObject:wineArray forKey:@"SearchWine"];
    [self.handleredResult setValue:wineArray forKey:@"SearchWine"];
    if (result) {
     //   [self.handleredResult setObject:result forKey:@"result"];
        [self.handleredResult setValue:result forKey:@"result"];
    }
}

@end
//酒庄详情
@implementation WineParkDetailRequest

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
    [super processResult];
    if ([self isSuccess]) {
        
    }
}
@end
//名酒庄
@implementation FamousParkWineRequest

-(ITTRequestMethod)getRequestMethod
{
    return ITTRequestMethodGet;
}

-(NSString *)getRequestUrl
{
    return REQUEST_URL(@"m/appchateaulist");
}

-(void)processResult
{
   // NSLog(@"2名庄酒名庄酒名庄酒名庄酒%@",self.handleredResult);
    [super processResult];
    if ([self isSuccess]) {
        NSMutableArray *dataArray = [[NSMutableArray alloc]init];
                NSDictionary *data = self.handleredResult[@"data"];
                NSArray *list = [data valueForKey:@"list"];
                for (NSDictionary *dic in list) {
                    FamousParkWineModel *model = [[FamousParkWineModel alloc]initWithDataDic:dic];
                    
                  //  [model setValuesForKeysWithDictionary:dic];
                    [dataArray addObject:model];
                }
   //     [self.handleredResult setObject:dataArray forKey:@"dataArray"];
        [self.handleredResult setValue:dataArray forKey:@"dataArray"];
     //   NSLog(@"名庄酒名庄酒名庄酒名庄酒%@",dataArray);
    }
}
@end
//新闻
@implementation NewsRequest

-(ITTRequestMethod)getRequestMethod
{
    return ITTRequestMethodGet;
}

-(NSString *)getRequestUrl
{
    return REQUEST_URL(@"m/appnewsList");
}

-(void)processResult
{
    
   // NSLog(@"NewsRequest%@",self.handleredResult[@"data"]);
    [super processResult];
    if ([self isSuccess]) {
        NSMutableArray *newsArray = [[NSMutableArray alloc]init];
        NSDictionary* dataDic = self.handleredResult[@"data"];
        NSArray *list = [dataDic valueForKey:@"list"];
        for (NSDictionary *newDic in list) {
            NewsModel *model = [[NewsModel alloc]initWithDataDic:newDic];
            [newsArray addObject:model];
        }
        [self.handleredResult setValue:newsArray forKey:@"dataArray"];
    }
}
@end
//新闻详情
@implementation NewsDetailRequest

-(ITTRequestMethod)getRequestMethod
{
    return ITTRequestMethodGet;
}

-(NSString *)getRequestUrl
{
    return REQUEST_URL(@"m/appnews");
}

-(void)processResult
{
    
    [super processResult];
    if ([self isSuccess]) {
        NSDictionary *dataDic = self.handleredResult[@"data"];
        DetailNewsModel *model = [[DetailNewsModel alloc]initWithDataDic:dataDic];
        NSArray *picArr = [dataDic valueForKey:@"url"];
        model.newsPicArr = picArr;
     //   [self.handleredResult setObject:model forKey:@"DetailNewsModel"];
        [self.handleredResult setValue:model forKey:@"DetailNewsModel"];
    }
}
@end
/***/
//专业品鉴
@implementation ProfessionalRequest

-(ITTRequestMethod)getRequestMethod
{
    return ITTRequestMethodGet;
}

-(NSString *)getRequestUrl
{
    return REQUEST_URL(@"m/appzypjList");
}

-(void)processResult
{
    
    [super processResult];
    if ([self isSuccess]) {
        NSMutableArray *newsArray = [[NSMutableArray alloc]init];
        NSDictionary* dataDic = self.handleredResult[@"data"];
        NSArray *list = [dataDic valueForKey:@"list"];
        for (NSDictionary *newDic in list) {
            NewsModel *model = [[NewsModel alloc]initWithDataDic:newDic];
            [newsArray addObject:model];
        }
        [self.handleredResult setValue:newsArray forKey:@"dataArray"];
    }
}
@end
//专业品鉴详情
@implementation ProfessionalDetailRequest

-(ITTRequestMethod)getRequestMethod
{
    return ITTRequestMethodGet;
}

-(NSString *)getRequestUrl
{
    return REQUEST_URL(@"m/appzypj");
}

-(void)processResult
{
    
    [super processResult];
    if ([self isSuccess]) {
        NSDictionary *dataDic = self.handleredResult[@"data"];
        DetailNewsModel *model = [[DetailNewsModel alloc]initWithDataDic:dataDic];
        NSArray *picArr = [dataDic valueForKey:@"url"];
        model.newsPicArr = picArr;
    //    [self.handleredResult setObject:model forKey:@"DetailNewsModel"];
        [self.handleredResult setValue:model forKey:@"DetailNewsModel"];
    }
}
@end
//品鉴心得
@implementation ExperienceRequest

-(ITTRequestMethod)getRequestMethod
{
    return ITTRequestMethodGet;
}

-(NSString *)getRequestUrl
{
    return REQUEST_URL(@"m/apppjxdList");
}

-(void)processResult
{
   // NSLog(@"品鉴心得--%@",self.handleredResult);
    [super processResult];
    if ([self isSuccess]) {
        NSMutableArray *newsArray = [[NSMutableArray alloc]init];
        NSDictionary* dataDic = self.handleredResult[@"data"];
        NSArray *list = [dataDic valueForKey:@"list"];
        for (NSDictionary *newDic in list) {
            NewsModel *model = [[NewsModel alloc]initWithDataDic:newDic];
            [newsArray addObject:model];
        }
        [self.handleredResult setValue:newsArray forKey:@"dataArray"];
    }
}
@end
//品鉴心得详情
@implementation ExperienceDetailRequest

-(ITTRequestMethod)getRequestMethod
{
    return ITTRequestMethodGet;
}

-(NSString *)getRequestUrl
{
    return REQUEST_URL(@"m/apppjxd");
}

-(void)processResult
{
    
    [super processResult];
    if ([self isSuccess]) {
        NSDictionary *dataDic = self.handleredResult[@"data"];
        DetailNewsModel *model = [[DetailNewsModel alloc]initWithDataDic:dataDic];
        NSArray *picArr = [dataDic valueForKey:@"url"];
        model.newsPicArr = picArr;
     //   [self.handleredResult setObject:model forKey:@"DetailNewsModel"];
        [self.handleredResult setValue:model forKey:@"DetailNewsModel"];
    }
}
@end
/***/
//白板荐酒
@implementation WhiteBoardRequest

-(ITTRequestMethod)getRequestMethod
{
    return ITTRequestMethodGet;
}

-(NSString *)getRequestUrl
{
    return REQUEST_URL(@"m/appwhiteboardList");
}

-(void)processResult
{
  //  NSLog(@"白板荐酒 %@",self.handleredResult);
    [super processResult];
    if ([self isSuccess]) {
        NSMutableArray *dataArr = [[NSMutableArray alloc]init];
        NSArray *colorlist = self.handleredResult[@"data"][@"colorlist"];
        for (NSDictionary *dic in colorlist) {
            WhiteBoardModel *model = [[WhiteBoardModel alloc]init];
            model.whiteBoardColorid = [dic objectForKey:@"colorId"];
            model.whiteBoardColorCode = [dic objectForKey:@"colorcode"];
            model.whiteBoardColorName = [dic objectForKey:@"colorName"];
            NSArray *planList = [dic objectForKey:@"planList"];
            NSMutableArray *planArr = [[NSMutableArray alloc]init];
            for (NSDictionary *planDic in planList) {
                NSString *planStr = [planDic objectForKey:@"plan"];
                [planArr addObject:planStr];
            }
            model.whiteBoardPlanList = planArr;
            [dataArr addObject:model];
        }
        [self.handleredResult setValue:dataArr forKey:@"dataArray"];
    }
}
@end
//意见反馈
@implementation UserFeedbackRequest

-(ITTRequestMethod)getRequestMethod
{
    return ITTRequestMethodGet;
}

-(NSString *)getRequestUrl
{
    return REQUEST_URL(@"m/appUserFeedback");
}

-(void)processResult
{
    
    [super processResult];
    if ([self isSuccess]) {
        
    }
}
@end
//使用帮助列表
@implementation HelpMeRequest

-(ITTRequestMethod)getRequestMethod
{
    return ITTRequestMethodGet;
}

-(NSString *)getRequestUrl
{
    return REQUEST_URL(@"m/apphelplist");
}

-(void)processResult
{
    
    [super processResult];
   // NSLog(@"++++++++++%@",self.handleredResult);

    if ([self isSuccess]) {
        
        NSMutableArray *dataArray = [[NSMutableArray alloc]init];
        NSArray *arr = self.handleredResult[@"data"][@"list"];
        for (NSDictionary *dic in arr) {
            
            HelpMeModel *model = [[HelpMeModel alloc]initWithDataDic:dic];
//            NSString *helpName = [dic valueForKey:@"helpname"];
//            NSString *helpContent = [dic valueForKey:@"content"];
//            model.helpMeImage = [dic]
//            model.helpMeContent = helpContent;
//            model.helpMeName = helpName;
            [dataArray addObject:model];
            
        }
        [self.handleredResult setValue:dataArray forKey:@"dataArray"];
    }
}
@end

//用户浏览列表
@implementation UserScanListRequest

-(ITTRequestMethod)getRequestMethod
{
    return ITTRequestMethodGet;
}

-(NSString *)getRequestUrl
{
    return REQUEST_URL(@"m/appgoodsseequery");
}

-(void)processResult
{
    
    [super processResult];
    if ([self isSuccess]) {
        NSMutableArray *dataArray = [[NSMutableArray alloc]init];
        NSArray *arr = self.handleredResult[@"data"][@"List"];
        for (NSDictionary *dic in arr) {
            MyLoveWine *myLoveWine = [[MyLoveWine alloc]initWithDataDic:dic];
            [dataArray addObject:myLoveWine];
            
        }
        [self.handleredResult setValue:dataArray forKey:@"dataArray"];
    }
}
@end

//用户浏览删除
@implementation UserScanDeleteRequest

-(ITTRequestMethod)getRequestMethod
{
    return ITTRequestMethodGet;
}

-(NSString *)getRequestUrl
{
    return REQUEST_URL(@"m/appgoodsseedel");
}

-(void)processResult
{
    
    [super processResult];
    if ([self isSuccess]) {
        
    }
}
@end

//用户浏览添加
@implementation UserScanAddRequest

-(ITTRequestMethod)getRequestMethod
{
    return ITTRequestMethodGet;
}

-(NSString *)getRequestUrl
{
    return REQUEST_URL(@"m/appgoodsseeadd");
}

-(void)processResult
{
    
    [super processResult];
    if ([self isSuccess]) {
        
    }
}
@end

//热门城市
@implementation HotCityRequest

-(ITTRequestMethod)getRequestMethod
{
    return ITTRequestMethodGet;
}

-(NSString *)getRequestUrl
{
    return REQUEST_URL(@"m/hotappcity");
}

-(void)processResult
{
    
    [super processResult];
    if ([self isSuccess]) {
       
        NSMutableArray *dataArray = [[NSMutableArray alloc]init];
        NSArray *arr = self.handleredResult[@"data"];
        for (NSDictionary *dic in arr) {
            HotCityModel *model = [[HotCityModel alloc]init];
            model.cityCityName = [dic valueForKey:@"cityName"];
            model.cityCountryId = [dic valueForKey:@"countryid"];
            model.cityId = [dic valueForKey:@"id"];
            
            [dataArray addObject:model];
            
        }
        [self.handleredResult setValue:dataArray forKey:@"dataArray"];
        
    }
}
@end
