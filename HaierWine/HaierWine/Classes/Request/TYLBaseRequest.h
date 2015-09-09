//
//  TYLBaseRequest.h
//  HaierWine
//
//  Created by leon on 14-7-2.
//
//

#import "ITTAFNBaseDataRequest.h"


@interface TYLBaseRequest : ITTAFNBaseDataRequest

@end


@interface LogoRequest : ITTAFNBaseDataRequest

@end
//开机闪图
@interface StartLogoRequest : ITTAFNBaseDataRequest

@end

//首页
@interface HomePageRequest : ITTAFNBaseDataRequest

@end
//城镇查询
@interface CountryRequest : ITTAFNBaseDataRequest

@end

@interface vegetableRequest : ITTAFNBaseDataRequest

@end
//品牌汇
@interface BrandRequest : ITTAFNBaseDataRequest

@end

//品牌汇详情
@interface BrandDetailRequest : ITTAFNBaseDataRequest

@end
//酒品收藏
@interface FavouriteWineRequest : ITTAFNBaseDataRequest

@end
//酒品收藏列表
@interface FavouriteWineListRequest : ITTAFNBaseDataRequest

@end
//酒品收藏删除
@interface FavouriteWineDeleteRequest : ITTAFNBaseDataRequest

@end
//版本升级
@interface UpdateRequest : ITTAFNBaseDataRequest

@end
//新功能介绍
@interface NewAppSubRequest : ITTAFNBaseDataRequest

@end

//扫描条形码空接口
@interface BarcodeRequest : ITTAFNBaseDataRequest

@end
//酒品搜索
@interface SearchWineRequest : ITTAFNBaseDataRequest

@end
//酒庄详情
@interface WineParkDetailRequest : ITTAFNBaseDataRequest

@end
//名酒庄
@interface FamousParkWineRequest : ITTAFNBaseDataRequest

@end
//新闻
@interface NewsRequest : ITTAFNBaseDataRequest

@end
//新闻详情
@interface NewsDetailRequest : ITTAFNBaseDataRequest

@end

//专业品鉴
@interface ProfessionalRequest : ITTAFNBaseDataRequest

@end
//专业品鉴详情
@interface ProfessionalDetailRequest : ITTAFNBaseDataRequest

@end

//品鉴心得
@interface ExperienceRequest : ITTAFNBaseDataRequest

@end
//品鉴心得详情
@interface ExperienceDetailRequest : ITTAFNBaseDataRequest

@end

//白板荐酒
@interface WhiteBoardRequest : ITTAFNBaseDataRequest

@end
//意见反馈
@interface UserFeedbackRequest : ITTAFNBaseDataRequest

@end
//使用帮助列表
@interface HelpMeRequest : ITTAFNBaseDataRequest

@end
//用户浏览列表
@interface UserScanListRequest : ITTAFNBaseDataRequest

@end
//用户浏览删除
@interface UserScanDeleteRequest : ITTAFNBaseDataRequest

@end
//用户浏览列表添加
@interface UserScanAddRequest : ITTAFNBaseDataRequest

@end
//热门城市
@interface HotCityRequest : ITTAFNBaseDataRequest

@end
