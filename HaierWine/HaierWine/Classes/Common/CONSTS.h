//
//  CONSTS.h
//  Hupan
//
//  Copyright 2010 iTotem Studio. All rights reserved.
//


#define test_url @"http://uhome.haier.net:7360"

#define server_url [NSString stringWithFormat:@"%@/appwine/",test_url]
//#define COMMON_SERVER_ADDRESS [NSString stringWithFormat:@"%@/commonapp",SECURITY_LOGIN]
#define COMMON_SERVER_ADDRESS @"http://uhome.haier.net:6000/commonapp"
#define SECURITY_LOGIN  @"http://uhome.haier.net:9080"//9080安全

#define REQUEST_URL(url) [NSString stringWithFormat:@"%@%@",server_url,url]

#define server_url_l_b @"http://192.168.190.206:8080/miniwine/"
#define REQUEST_URL_L_B(url) [NSString stringWithFormat:@"%@%@",server_url_l_b,url]
#define ServerUrl @"http://192.168.130.207:8080/ifserver/"
#define RequestUrl(url) [[NSString stringWithFormat:@"%@%@",ServerUrl,url];

#define REQUEST_DOMAIN @"http://cx.itotemstudio.com/api.php" // default env
//#define PASSWOR_MANAGER [LoginErrorMoreManager sharedLoginErrorMoreManager]
//text
#define TEXT_LOAD_MORE_NORMAL_STATE @"向上拉动加载更多..."
#define TEXT_LOAD_MORE_LOADING_STATE @"更多数据加载中..."
#define isIOS7() ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)

//other consts
typedef enum{
	kTagWindowIndicatorView = 501,
	kTagWindowIndicator,
} WindowSubViewTag;

typedef enum{
    kTagHintView = 101
} HintViewTag;
#define APPDELEGATE ((AppDelegate *)[[UIApplication sharedApplication] delegate])
//#define PASSWOR_MANAGER [PasswordPreventMoreManager sharedPasswordPreventMoreManager]
#define SAVEUSERDATA [SaveUserDataManager sharedSaveUserDataManager]
#define WineDetailData [WineDetailInfo sharedWineDetailInfo]
#define WINE_BOX_STATUE_CHANGE @"WineBoxStatueChange"
#define FIND_WINE_DEVICE @"findWineDevice"
//cache key
#define KEY_CACHE_USER @"KEY_CACHE_USER"
#define KEY_MEMORY_PASSWORD @"KEY_MEMORY_PASSWORD"
#define KEY_CACHE_FRIDGE_INFO @"KEY_CACHE_FRIDGE_INFO"
#define KEY_CACHE_LOCAL_ONLINE @"KEY_CACHE_LOCAL_ONLINE"
#define KEY_CACHE_BINDING_DEVICE @"KEY_CACHE_BINDING_DEVICE"

#define KEY_CACHE_USER_ACCESSTOKEN @"KEY_CACHE_USER_ACCESSTOKEN"
#define KEY_CACHE_USER_ID   @"KEY_CACHE_USER_ID"
#define KEY_CACHE_DEVICE_ID @"KEY_CACHE_DEVICE_ID"
#define KEY_CACHE_DEVICE_NAME @"KEY_CACHE_DEVICE_NAME"
#define KEY_CACHE_USER_INFO @"KEY_CACHE_USER_INFO"
#define KEY_CACHE_USERPROFILE_INFO @"KEY_CACHE_USERPROFILE_INFO"
#define KEY_CACHE_USERBASE_INFO @"KEY_CACHE_USERBASE_INFO"

//- prevent password more
#define KEY_CACHE_PREVENT_PWD_MORE @"KEY_CACHE_PREVENT_PWD_MORE"
// version
#define KEY_CACHE_VERSION_UPDATE @"KEY_CACHE_VERSION_UPDATE"
#define KEY_CACHE_VERSION_MODEL  @"KEY_CACHE_VERSION_MODEL"
//push
#define KEY_CACHE_PUSH_NOTIFICATION @"KEY_CACHE_PUSH_NOTIFICATION"

//notification
#define NOTIFICATION_FRIDGE_INFO_CHANGE @"NOTIFICATION_FRIDGE_INFO_CHANGE"
#define NOTIFICATION_CONFIGURE_SUCCESS @"NOTIFICATION_CONFIGURE_SUCCESS"
#define NOTIFICATION_CONFIFURE_FAILURE @"NOTIFICATION_CONFIFURE_FAILURE"
#define NOTIFICATION_USER_HEAD_CHANGE @"NOTIFICATION_USER_HEAD_CHANGE"
#define NOTIFICATION_USER_NICKNAME_CHANGE @"NOTIFICATION_USER_NICKNAME_CHANGE"
#define NOTIFICATION_CHECK_VERSION_UPDATE @"NOTIFICATION_CHECK_VERSION_UPDATE"
#define NOTIFICATION_START_BINGING_DEVICE @"NOTIFICATION_START_BINGING_DEVICE"
#define NOTIFICATION_PUSH_NOTIFICATION_CHANGE @"NOTIFICATION_PUSH_NOTIFICATION_CHANGE"
//EdgeInsets
#define ImageEdgeInsets_NO  UIEdgeInsetsMake(17, 25, 18, 26)
#define ImageEdgeInsets_YES UIEdgeInsetsMake(17, 24, 17, 23)

//data request

#define APPID @"MB-SINGLEGRADEVIN-0001"
#define APPKEY @"5998da18fc2fa3df3ae8a19d77e3c350"
#define APPVERSION @"01.01.01.01026"

#define TYPE_INDITIFIER @"111c120024000810080300718000674200000000000000000000000000000000"
#define DEVICE_TYPE  @"08"

#define FLASHDURATION 3000



