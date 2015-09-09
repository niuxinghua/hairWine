//
//  MainViewController.m
//  iTotemMinFramework
//
//  Created by  on 12-8-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
#import "MainViewController.h"
#import "PKRevealController.h"
#import "LoginViewController.h"
#import "SellerJoinViewController.h"
#import "UnBundingDeviceViewController.h"
#import "FeedbackViewController.h"
#import "DetailWineViewController.h"
#import "FamousParkWineViewController.h"
#import "ChangePasswordViewController.h"
#import "BrandViewController.h"
#import "MainSubView.h"
#import "WineFactoryViewController.h"
#import "SettingViewController.h"
#import "TemperatureView.h"
#import "UIImageView+WebCache.h"
#import "MainPageLbModel.h"
#import "MainPageNewsModel.h"
#import "ITTImageView.h"
#import "SearchWineViewController.h"
#import "MyLoveWineViewController.h"
#import "ScanViewController.h"
#import "NewWhiteBoardViewController.h"
#import "BingDeviceFirstViewController.h"
#import "WineManager.h"
#import "UserInfoManager.h"
#import "ControlWineAlertView.h"
//8.22
#import "UIViewController+CWPopup.h"
#import "WineManager.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreText/CoreText.h>
#import "BingDeviceNextViewController.h"
#import "WineManager.h"
#import "WebViewController.h"
#import "ControlWineAlertView.h"
#import "DetailViewController.h"
#import "DetailExperienceViewController.h"
#import "DetailProfessionalViewController.h"
#import "WineShopDetailViewController.h"
#import "AppDelegate.h"
#import "ScanningCodeViewController.h"
#import "Reachability.h"
#import "FeedBackAndUpdateAlertView.h"

#define TOP_TEMPERATURE 13
#define HaierDataCacheManager ([HaierDataCacheManager sharedManager])


@interface MainViewController ()
{
    
    IBOutlet UIButton       *_addWineButton;
    IBOutlet UIView         *_wineNameBgView;
    IBOutlet UIView         *_noWineBgView;
    
    IBOutlet UILabel        *_wineDeviceTem;
    IBOutlet UILabel        *_wineDeviceLabel;
    IBOutlet UIView         *_wineDeviceStatues;
    TopExchangeView         *_segment;
    iCarousel               *_iCarousel;
    TemperatureView         *_tempView;
    FeedBackAndUpdateAlertView *_alertView;
    IBOutlet UIView         *_navigationView;
    IBOutlet UILabel        *_fitTemperture;
    IBOutlet UIButton       *_wineBoxLightButton;
    IBOutlet UIView         *_animatonBgView;
    IBOutlet ITTImageView   *_popImageView;
    IBOutlet UIImageView    *_iconBackgroundImageView;
    IBOutlet UIView         *_mainView;
    IBOutlet UIView         *_controlView;
    IBOutlet UIScrollView   *_scrollView;
    IBOutlet UIScrollView   *_picScrollView;
    __weak IBOutlet UIScrollView *_MainScrollView;
    IBOutlet UIPageControl  *_pageControl;
    IBOutlet UIView         *_controlWineView;
    IBOutlet UIView         *_controlWineTemperatureView;
    IBOutlet UIImageView    *_liquidImageViewA1;
    IBOutlet UIImageView    *_liquidImageViewA2;
    IBOutlet UIImageView    *_liquidImageViewB1;
    IBOutlet UIImageView    *_liquidImageViewB2;
    IBOutlet UILabel        *_wineBoxTemperature;
    IBOutlet UIView         *_BingDeviceFirstView;
    IBOutlet UILabel        *_currentTemLabel;
    IBOutlet UILabel        *_suitableLabel;
    CAShapeLayer            *_circleShap;
    NSTimer                 *_timer;
    NSInteger               _circleCornerRadius;
    NSInteger               _circleIndex;
    NSInteger               _cornerradious;
    NSInteger               _previousIndex;
    CGFloat                 _circleShapWidth;
    CGFloat                 _circleBeginOpacity;
    CGFloat                 _circleEndOpacity;
    CGFloat                 _transformScale;
    CGFloat                 _circleLineWidth;
    CGFloat                 _circleOrigalOpacity;
  //  CGFloat                 _PreviousScrollOffset;

    BOOL                    _upOrDown;
    BOOL                    _isAmimationRun;
    BOOL                    _isFirstPic;
    BOOL                    _isTemperatureUp;
    BOOL                    _isStop;
    BOOL                    _isTopButtonLeft;
    BOOL                    _isScaning;
    BOOL                    _isMainView;
    BOOL                    _isDeciveConnection;
    BOOL                    _deviceEnable;
    BOOL                    _isInit;
    BOOL                    _isAnimatoning;
    
    //存储数据
    NSInteger               _timeCount;
    NSInteger               _previousTem;
    NSInteger               _num;//轮播图总页数
    NSArray                 *_lbPic; //轮播图
    NSMutableArray          *_lbDataArr;//轮播图数据存储
    NSInteger               _page;//轮播图当前页
    NSInteger               _lastPage;//轮播图最后页
    NSArray                 *_news;
    UILabel                 *_upLabel;
    UILabel                 *_currentLabel;
    UILabel                 *_downLabel;
    NSMutableArray          *_dataArray;
    NSMutableArray          *_circleShapArrayDown;
    NSMutableArray          *_circleShapArrayUp;
    NSString                *_currentWineBoxTem;
    NSString                *_button;
    //8.22
    BOOL                    _isOpenUSDK;
    BOOL                    _isAutoLogin;
    IBOutlet UIButton       *_wineNameButton;
    IBOutlet UIView         *_addWineBackgroundView;
    IBOutlet UIImageView    *_addWineImagView;
    IBOutlet UIButton       *_changeWineButton;
}
@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeWinName:) name:@"CHANGEWINENAME" object:nil];
    }
    return self;
}

- (void)mainScrollViewPanGestureRecognizer:(UIPanGestureRecognizer *)pan
{
    if (_isMainView) {
        [self.navigationController.revealController didRecognizePanWithGestureRecognizer:pan];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _currentWineBoxTem = @"12";
    _isAnimatoning = NO;
    _timeCount = 0;
    DATA_ENV.isVistor = YES;
    _deviceEnable = YES;
 //   [self getWineDeviceStatus];
   // DATA_ENV.wineName = nil;
    _timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(changePic) userInfo:nil repeats:YES];
    _lbDataArr = [[NSMutableArray alloc]init];
    _isMainView = YES;
    _isDeciveConnection = NO;
    _isAutoLogin = NO;
    _isInit = YES;
    _MainScrollView.contentSize = CGSizeMake(640, _MainScrollView.height);
    [_MainScrollView.panGestureRecognizer addTarget:self action:@selector(mainScrollViewPanGestureRecognizer:)];
    
    if (isIOS7()) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    } else {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    }
    
    DATA_ENV.isScanning = NO;
    //    [self initSwipe];
    
    _dataArray = [[NSMutableArray alloc]init];
    _circleShapArrayUp = [[NSMutableArray alloc]init];
    _circleShapArrayDown = [[NSMutableArray alloc]init];
    for (int i = 0; i<=TOP_TEMPERATURE; i++) {
        [_dataArray addObject:[NSString stringWithFormat:@"%d",i]];//°
    }
    _controlWineView.left = 320;
    _BingDeviceFirstView.left = 320;
    [self initSegment];
    [self initMainView];
    
    if ([HaierDataCacheManager isHaveDataWithKey:@"main0"]) {
        NSArray *arr0 = [HaierDataCacheManager getDataWithKey:@"main0"];
        NSArray *arr1 = [HaierDataCacheManager getDataWithKey:@"main1"];
        NSArray *arr2 = [HaierDataCacheManager getDataWithKey:@"main2"];
        NSArray *arr3 = [HaierDataCacheManager getDataWithKey:@"main3"];
        
        [_lbDataArr addObjectsFromArray:arr0];
        [self fillDataToLbView:arr0];
        [self fillDataToUnits:arr1 tag:400];
        [self fillDataToUnits:arr2 tag:401];
        [self fillDataToUnits:arr3 tag:402];
    }
    
    _picScrollView.delegate = self;
    if (is4InchScreen()) {
        _scrollView.contentSize = CGSizeMake(320,1346+56+4);
    } else {
        _scrollView.contentSize = CGSizeMake(320,1434+56+4);
    }
    
    _controlWineTemperatureView.layer.cornerRadius = 90;
    [self initiCarousel];
    //    [self.view addSubview:_controlWineView];
    _isStop = YES;
    [self setUpCircleShaps];
    [self temperatureAnimation];
    
    //    [_controlView addSubview:_mainView];
    //    [_controlView addSubview:_controlWineView];
    //dd
    [_MainScrollView addSubview:_controlWineView];
    [_MainScrollView addSubview:_BingDeviceFirstView];
    //
    _mainView.hidden = NO;
    _controlWineView.hidden = NO;
    _tempView = [TemperatureView loadFromXib];
    _tempView.delegate = self;
    if(isIOS7())
    {
        _tempView.top = 0;
    } else {
        _tempView.top = -20;
    }
    [self.view addSubview:_tempView];
    _tempView.hidden = YES;
    [_controlView bringSubviewToFront:_navigationView];
    if (DATA_ENV.userName.length>0 && DATA_ENV.userPassword.length>0){
        _isAutoLogin = YES;
        [self userAutoLogin];
    } else {
        LoginViewController *lvc = [[LoginViewController alloc]init];
        UINavigationController *nvc = [[UINavigationController alloc]initWithRootViewController:lvc];
        [self presentViewController:nvc animated:NO completion:^{
            
        }];
    }
    DATA_ENV.HereHerestep1 = NO;
    [self startUSDK];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeStatue:) name:WINE_BOX_STATUE_CHANGE object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showMainView) name:@"MainView" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showControlView) name:@"ControlWine" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceIsOnline:) name:@"ONLINE" object:nil];

}

- (BOOL)connectNet
{
    Reachability *r = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    if (_alertView !=nil) {
        [_alertView removeFromSuperview];
        _alertView = nil;
    }
    if ([r currentReachabilityStatus] == NotReachable) {
        _alertView = [FeedBackAndUpdateAlertView loadFromXib];
        _alertView.frame = CGRectMake(0, 0, 320, self.view.bounds.size.height+20);
        _alertView.type = UnconnectWIFI;
        [[AppDelegate getAppDelegate].window addSubview:_alertView];
     //   NSLog(@"当前无网络");

        return YES;
    }
 //   NSLog(@"当前有网络");


    return NO;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
  //  NSLog(@"界面即将显示");
    DATA_ENV.HereHerestep1 = NO;
    _liquidImageViewA1.left = 0;
    _liquidImageViewA2.left = -374;
    _liquidImageViewB1.left = 0;
    _liquidImageViewB2.left = -374;
    _isFirstPic = YES;
    [self viewAnimation];

    if (_isWineBox) {
        [_MainScrollView setContentOffset:CGPointMake(320, 0) animated:YES];
        [_segment onlyPicMoveToRight];
    }else{
        [_MainScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        [_segment onlyPicMoveToLeft];
    }

    if (DATA_ENV.isVistor){
        [_segment exchangeToLeft];
    }
    if (DATA_ENV.isAddWine){
        [_segment exchangeToRight];
        //  [self addTemperatureView];
        DATA_ENV.isAddWine = NO;
    }
    if (DATA_ENV.isScanning){
        [_segment exchangeToRight];
        [self addTemperatureView];
        DATA_ENV.isScanning = NO;
    }
    
    [_wineNameButton setTitle:DATA_ENV.wineName forState:UIControlStateNormal];
//       NSLog(@"^^^%@",DATA_ENV.wineName);
    if (DATA_ENV.wineName.length !=0) {
        [self isHasWine:YES];
       // NSLog(@"kkkk%@",DATA_ENV.wineName);
        _wineBoxTemperature.hidden = NO;
        _fitTemperture.hidden = NO;
        _suitableLabel.hidden = NO;
        _currentTemLabel.hidden = NO;
        _addWineBackgroundView.hidden = YES;
        [_controlWineView bringSubviewToFront:_wineNameBgView];
    } else {
        [self isHasWine:NO];
        _wineBoxTemperature.hidden = YES;
        _fitTemperture.hidden = YES;
        _suitableLabel.hidden = YES;
        _currentTemLabel.hidden = YES;
        _addWineBackgroundView.hidden = NO;
        [_controlWineView bringSubviewToFront:_addWineBackgroundView];
    }
    //  NSLog(@"DATA_ENV.deviceMac-%@",DATA_ENV.deviceMac);
//    if (DATA_ENV.userid != nil && DATA_ENV.deviceMac && DATA_ENV.isLocalOnline) {
    //    [self subscrb];
//    }
    //qufan
#warning 调试用
    //    NSLog(@"8888%d",DATA_ENV.isOverBanding);
    if (DATA_ENV.isBindingDevice == NO) {
        _BingDeviceFirstView.hidden = NO;
        _controlWineView.hidden = YES;
    } else {
        _BingDeviceFirstView.hidden = YES;
        _controlWineView.hidden = NO;
    }
   // [self getWineDeviceStatus];
    
    if (!_isNoShowLogin) {
        if (!_isInit) {
            LoginViewController *lvc = [[LoginViewController alloc]init];
            UINavigationController *nvc = [[UINavigationController alloc]initWithRootViewController:lvc];
            [self presentViewController:nvc animated:NO completion:^{
                
            }];
            _isNoShowLogin = YES;
        }
    }
    _isInit = NO;
    if (DATA_ENV.isDeviceOneline) {
        _wineNameButton.enabled = YES;
        if (DATA_ENV.wineName.length == 0) {
            _noWineBgView.hidden = NO;
            _wineDeviceStatues.hidden = YES;
            _wineDeviceLabel.hidden = YES;
        } else {
            _noWineBgView.hidden = YES;
            _wineDeviceStatues.hidden = NO;
            _wineDeviceLabel.hidden = YES;
        }

    } else {
        _wineNameButton.enabled = NO;
        _noWineBgView.hidden = YES;
        _wineDeviceStatues.hidden = YES;
        _wineDeviceLabel.text = @"当前设备不可用";
        _wineDeviceLabel.hidden = NO;
    }
    [self mainPageRequest];


}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (DATA_ENV.suitableTemp) {
        [self setSuitTemperature:[DATA_ENV.suitableTemp integerValue]];
        [[WineManager shareWineManager] controlTemperature:[NSString stringWithFormat:@"%d",[DATA_ENV.suitableTemp integerValue]-5]];
    } else {
        [self setSuitTemperature:12];
        [[WineManager shareWineManager] controlTemperature:[NSString stringWithFormat:@"%d",7]];
    }
    if (DATA_ENV.wineType.length !=0) {
        NSString *str = [self getSuitableTemperature:DATA_ENV.wineType];
        if (str != nil) {
            _fitTemperture.text = str;
        }
    }
    self.navigationController.revealController.recognizesPanningOnFrontView = YES;

     [_MainScrollView.panGestureRecognizer addTarget:self action:@selector(mainScrollViewPanGestureRecognizer:)];
    [self connectNet];

}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

}

- (void)changeWinName:(NSNotification *)noti
{
   // NSLog(@"8888%@",DATA_ENV.wineName);
    NSString *type = [noti userInfo][@"type"];
    if (![type isEqualToString:@"0"]) {
        DATA_ENV.wineName = [self getWineType:type];
        DATA_ENV.wineType = DATA_ENV.wineName;
    }
      // NSLog(@"%@",type);
    [_wineNameButton setTitle:DATA_ENV.wineName forState:UIControlStateNormal];
    if (DATA_ENV.wineType.length !=0) {
        NSString *str = [self getSuitableTemperature:DATA_ENV.wineType];
        if (str != nil) {
            _fitTemperture.text = str;
        }
    }
  //  NSLog(@"%@",DATA_ENV.wineName);
    if (DATA_ENV.wineName.length!=0) {
        [self isHasWine:YES];
       // NSLog(@"kkkk%@",DATA_ENV.wineName);
        _wineBoxTemperature.hidden = NO;
        _fitTemperture.hidden = NO;
        _suitableLabel.hidden = NO;
        _currentTemLabel.hidden = NO;
        _addWineBackgroundView.hidden = YES;
        [_controlWineView bringSubviewToFront:_wineNameBgView];
    } else {
        [self isHasWine:NO];
        _wineBoxTemperature.hidden = YES;
        _fitTemperture.hidden = YES;
        _suitableLabel.hidden = YES;
        _currentTemLabel.hidden = YES;
        _addWineBackgroundView.hidden = NO;
        [_controlWineView bringSubviewToFront:_addWineBackgroundView];
    }
}

- (NSString *)getSuitableTemperature:(NSString *)WineType
{
        //@"半干红葡萄酒",@"半甜/甜型葡萄酒",@"干红葡萄酒",@"半甜/甜型葡萄酒",@"半干白葡萄酒",@"干白葡萄酒",@"白兰地酒",@"起泡葡萄酒/香槟"℃
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"SuitableTemperature"] == nil) {
        NSDictionary *dict = @{@"干红葡萄酒"   : @"16℃~18℃",
                               @"半干红葡萄酒" : @"12℃~18℃",
                               @"半甜"        : @"8℃~16℃",
                               @"甜红葡萄酒"   : @"8℃~16℃",
                               @"干白葡萄酒"   : @"8℃~12℃",
                               @"半干白葡萄酒"  : @"5℃~8℃",
                               @"半甜"         : @"6℃~14℃",
                               @"甜白葡萄酒"   : @"6℃~14℃",
                               @"桃红葡萄酒"    : @"5℃~13℃",
                               @"起泡酒"        : @"5℃~10℃",
                               @"香槟"         : @"5℃~10℃"
                               };
        [[NSUserDefaults standardUserDefaults] setObject:dict forKey:@"SuitableTemperature"];
        return [dict objectForKey:WineType];
    } else {
        NSDictionary *temDict = [[NSUserDefaults standardUserDefaults] objectForKey:@"SuitableTemperature"];
        return [temDict objectForKey:WineType];
    }
    return nil;
}

- (void)showMainView
{
    _isWineBox = NO;
    [_MainScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    [_segment onlyPicMoveToLeft];
    [self.navigationController.revealController showViewController:self.navigationController.revealController.frontViewController animated:YES completion:^(BOOL finished) {

    }];
}

- (void)showControlView
{
    _isWineBox = YES;
    [_MainScrollView setContentOffset:CGPointMake(320, 0) animated:YES];
    [_segment onlyPicMoveToRight];
    [self.navigationController.revealController showViewController:self.navigationController.revealController.frontViewController animated:YES completion:^(BOOL finished) {

    }];
}

- (void)changeStatue:(NSNotification *)noti
{
    
    NSDictionary *dict = [noti userInfo];
   // NSLog(@"$$$$$$$$$$$$$%@",dict);
    //  NSString *str = [NSString stringWithFormat:@"%@",dict];
    dispatch_async(dispatch_get_main_queue(), ^{
        
        _isDeciveConnection = YES;
        
        // [UIAlertView popupAlertByDelegate:nil title:@"提示" message:str];
        if (![dict[@"temperature"] isEqualToString:@"tem"]) {
         //   NSLog(@"*****%@",dict[@"temperature"]);
          //  _noWineBgView.hidden = YES;
     //       _wineDeviceLabel.hidden = YES;
           // _wineDeviceStatues.hidden = NO;
            _wineBoxTemperature.text = [NSString stringWithFormat:@"%@°",dict[@"temperature"]];
            _wineDeviceTem.text = [NSString stringWithFormat:@"%@°",dict[@"temperature"]];
            _currentWineBoxTem = dict[@"temperature"];
            if ([dict[@"temperature"] intValue]<[DATA_ENV.suitableTemp intValue]) {
                _isTemperatureUp = YES;
                [self hiddenCAShapeLayer];
            }else if([dict[@"temperature"] intValue]>[DATA_ENV.suitableTemp intValue])
            {
                _isTemperatureUp = NO;
                [self hiddenCAShapeLayer];
                
            } else{
                for (CAShapeLayer *layer in _circleShapArrayUp) {
                    layer.hidden = YES;
                }
                for (CAShapeLayer *layer in _circleShapArrayDown) {
                    layer.hidden = YES;
                }
            }
        }
        if (![dict[@"setTemperature"] isEqualToString:@"setTem"]) {
            NSInteger setTemperature = [dict[@"setTemperature"] integerValue];
         //   NSLog(@"SDK返回的设定温度--%d",setTemperature);
            if (_previousTem != setTemperature) {
                _previousTem = setTemperature;
                [self setSuitTemperature:setTemperature];
            }
        }
 //       NSLog(@"控灯---%d", [dict[@"light"] boolValue]);
        _wineBoxLightButton.selected = [dict[@"light"] boolValue];
        
    });
}

- (void)deviceIsOnline:(NSNotification *)noti
{
    NSDictionary *dict = [noti userInfo];
    NSInteger statues = [[dict objectForKey:@"onLine"] integerValue];
  //  NSLog(@"上线下线上线下线上线下线--%d",statues);
    [self getWineDeviceStatus:statues];

}

- (void)subscrb
{
    // uSDKDeviceNetTypeConst
    [[WineManager shareWineManager] remoteLoginWithAccessToken:DATA_ENV.accessToken];
    //[[WineManager shareWineManager]  SubscribeDeviceWithDeviceMac:/*@"0007A88A4666"*/DATA_ENV.deviceMac];//0007A88A4B74//0007A88A4666
  //  DATA_ENV.deviceMac = @"0007A88A4666";
}

- (void)startUSDK
{
    //dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 耗时的操作
        [[WineManager shareWineManager] startHaierUSDK];

    //});
   // [[WineManager shareWineManager] startHaierUSDK];
   // DATA_ENV.isSubcribe = NO;
}

#pragma mark - userAutoLogin
- (void)userAutoLogin
{    LoadingView *loadingView = [LoadingView loadFromXib];
    if (isIOS7()) {
        
        loadingView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    } else {
        
        loadingView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    }
    
    [self.view addSubview:loadingView];

    [LoginManager loginRequestWithLoginID:DATA_ENV.userName password:DATA_ENV.userPassword isAutoLogin:YES completion:^(BOOL isSuccess, NSString *returnMsg) {
        [loadingView removeFromSuperview];
        if (isSuccess) {
        } else {
            LoginViewController *lvc = [[LoginViewController alloc]init];
            UINavigationController *nvc = [[UINavigationController alloc]initWithRootViewController:lvc];
            [self presentViewController:nvc animated:NO completion:^{
                
            }];
        }
    }];
}

//#pragma mark - getUserBindingDevice
//
//- (void)getUserBindingDevice
//{
//    [UserInfoManager getUserDeviceWhenCompletion:^(BOOL isSuccess, id responseObject) {
//        if(DATA_ENV.device)
//        {
//            uSDKErrorConst error = [[WineManager shareWineManager] startHaierUSDK];
//            
//            if (error == RET_USDK_OK) {
//                [NSThread sleepForTimeInterval:1];
//                NSArray *array = [[uSDKDeviceManager getSingleInstance] getDeviceList:0];
//                NSLog(@"uuuuuu%@",array);
//                for(uSDKDevice *device in array){
//                    NSLog(@"%@----%@",device.mac,DATA_ENV.deviceMac);
//                    if([device.mac isEqualToString:DATA_ENV.deviceMac])
//                        [[WineManager shareWineManager] SubscribeDeviceWithDeviceMac:DATA_ENV.deviceMac];
//                }
//                
//            }
//            
//        }
//    }];
//}

- (void)addTemperatureView
{
    if (self.blurView == nil) {
        [self addBlurViewOnView:_controlView];
        [_controlView bringSubviewToFront:_tempView];
    }
    self.blurView.alpha = 1.0f;
    _tempView.alpha = 1.0f;
    self.blurView.hidden = NO;
    _tempView.hidden = NO;

}


#pragma mark - isHasWine

- (void)isHasWine:(BOOL)hasWine
{
   // _noWineBgView.hidden      = hasWine;
   // _wineDeviceLabel.hidden   = hasWine;
   // _wineDeviceStatues.hidden = !hasWine;
    _liquidImageViewA1.hidden = !hasWine;
    _liquidImageViewA2.hidden = !hasWine;
    _liquidImageViewB1.hidden = !hasWine;
    _liquidImageViewB2.hidden = !hasWine;
    _addWineImagView.hidden   = !hasWine;
    _wineNameBgView.hidden    = !hasWine;
    _wineNameButton.hidden    = !hasWine;
    _changeWineButton.hidden  = !hasWine;
}

#pragma mark - temperatureDelegate

-(void)complite:(NSInteger)degree :(BOOL)isSure
{
    if (degree == 9999) {
        self.blurView.hidden = YES;
        _tempView.hidden = YES;
        [_segment showLeft];
        return;
    }
    
    [UIView animateWithDuration:1 animations:^{
        self.blurView.alpha = 0;
        _tempView.alpha = 0;
    } completion:^(BOOL finished) {
        self.blurView.hidden = YES;
        _tempView.hidden = YES;
    }];
    
    if (isSure) {
        
        DATA_ENV.suitableTemp = [NSString stringWithFormat:@"%d",degree];
        [self setSuitTemperature:degree];
        [[WineManager shareWineManager] controlTemperature:[NSString stringWithFormat:@"%d",degree-5]];

    }
    

   // [self.blurView removeFromSuperview];
}

#pragma mark - initSegment method
-(void)initSegment
{
    _segment = [TopExchangeView loadFromXib];
    _segment.delegate = self;
    _segment.left = (320-170)/2;
    _segment.top = 28;
    _isTopButtonLeft = YES;
    [_navigationView addSubview:_segment];
}
#pragma mark - mainPageRequest method
-(void)mainPageRequest
{

//    LoadingView *loadingView = [LoadingView loadFromXib];
//    
//    loadingView.frame = CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height);
//    
//    [self.view addSubview:loadingView];
    
   // _isTemperatureUp = YES;
    _upOrDown = YES;
    _isAmimationRun = NO;
    _circleIndex = 0;
  //  [self.view addSubview:_segment];
  //  [self viewAnimation];
   // _cornerradious = 93;//108
  //  [self initMainView];
    if (is4InchScreen()) {
        _scrollView.contentSize = CGSizeMake(320, 300+311*3+167);

    } else {
        _scrollView.contentSize = CGSizeMake(320, 300+311*3+167+80);

    }

    [HomePageRequest requestWithParameters:nil withIndicatorView:nil withCancelSubject:nil onRequestStart:nil onRequestFinished:^(ITTBaseDataRequest *request) {
        
        if ([request isSuccess]) {
            
        //    [loadingView removeFromSuperview];
            //处理数据
            [self fillDataToLbView:request.handleredResult[@"lb"]];
            if (_lbDataArr) {
                [_lbDataArr removeAllObjects];
            }
            [_lbDataArr addObjectsFromArray:request.handleredResult[@"lb"]];
            [self fillDataToUnits:request.handleredResult[@"news"] tag:400];
            [self fillDataToUnits:request.handleredResult[@"experience"] tag:401];
            [self fillDataToUnits:request.handleredResult[@"artice"] tag:402];
            
            NSArray *cacheArr0 = [NSArray arrayWithArray:request.handleredResult[@"lb"]];
            NSArray *cacheArr1 = [NSArray arrayWithArray:request.handleredResult[@"news"]];
            NSArray *cacheArr2 = [NSArray arrayWithArray:request.handleredResult[@"experience"]];
            NSArray *cacheArr3 = [NSArray arrayWithArray:request.handleredResult[@"artice"]];
            
            [HaierDataCacheManager addData:cacheArr0 WithKey:@"main0"];
            [HaierDataCacheManager addData:cacheArr1 WithKey:@"main1"];
            [HaierDataCacheManager addData:cacheArr2 WithKey:@"main2"];
            [HaierDataCacheManager addData:cacheArr3 WithKey:@"main3"];
        }
        
        
    } onRequestCanceled:nil onRequestFailed:^(ITTBaseDataRequest *request) {
      //  [loadingView removeFromSuperview];
      //  [UIAlertView popupAlertByDelegate:self title:@"提示" message:@"网络连接失败"];
    }];
    
}
#pragma mark - dateStringChange method
-(NSString *)dateStringChange:(NSString *)dateStr
{
    NSDate *date = [NSDate dateWithString:dateStr formate:@"yyyy-MM-dd HH:mm:ss.S"];
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    [format setDateFormat:@"yyyy年MM月dd日"];
    NSString *newDateStr = [format stringFromDate:date];
    return newDateStr;
}

#pragma mark - temperatureDelegate

- (void)suitableTemperature:(NSString *)str andWindKind:(NSString *)wineKind
{
    _fitTemperture.text = str;
    DATA_ENV.wineType = wineKind;
    DATA_ENV.wineName = wineKind;
    DATA_ENV.wineID = nil;
    [_wineNameButton setTitle:wineKind forState:UIControlStateNormal];
   // _wineNameButton.enabled = NO;
    NSDictionary *dict = @{@"goodId": [self getWineTypeId:wineKind],
                           @"appId" : DATA_ENV.userid,
                           @"type"  : @"1"
                           };
    [ModifyWineRequest requestWithParameters:dict withIndicatorView:nil withCancelSubject:nil onRequestStart:nil onRequestFinished:^(ITTBaseDataRequest *request) {
        
    } onRequestCanceled:nil onRequestFailed:^(ITTBaseDataRequest *request) {
        
    }];

}

-(NSString*)getWineTypeId:(NSString *)wineType
{
    if ([wineType isEqualToString:@"干红葡萄酒"]) {
        return @"1";
    } else if ([wineType isEqualToString:@"半干红葡萄酒"]){
        return @"19";
    }else if ([wineType isEqualToString:@"半甜/甜红葡萄酒"]){
        return @"20";
    }
    else if ([wineType isEqualToString:@"干白葡萄酒"]){
        return @"22";
    }
    else if ([wineType isEqualToString:@"半干白葡萄酒"]){
        return @"23";
    }
    else if ([wineType isEqualToString:@"半甜/甜白葡萄酒"]){
        return @"24";
    }
    else if ([wineType isEqualToString:@"桃红葡萄酒"]){
        return @"25";
    }
    else if ([wineType isEqualToString:@"起泡酒/香槟"]){
        return @"26";
    }
    return nil;
}

- (NSString *)getWineType:(NSString *)wineId
{
    if ([wineId isEqualToString:@"1"]) {
        return @"干红葡萄酒";
    } else if ([wineId isEqualToString:@"19"]){
        return @"半干红葡萄酒";
    }else if ([wineId isEqualToString:@"20"]){
        return @"半甜/甜红葡萄酒";
    }
    else if ([wineId isEqualToString:@"22"]){
        return @"干白葡萄酒";
    }
    else if ([wineId isEqualToString:@"23"]){
        return @"半干白葡萄酒";
    }
    else if ([wineId isEqualToString:@"24"]){
        return @"半甜/甜白葡萄酒";
    }
    else if ([wineId isEqualToString:@"25"]){
        return @"半甜/甜白葡萄酒";
    }
    else if ([wineId isEqualToString:@"26"]){
        return @"起泡酒/香槟";
    }
    return nil;

}

#pragma mark - fillDateToUnits method
-(void)fillDataToUnits:(NSArray *)UnitArray tag:(NSInteger)tag
{

    
    if (UnitArray.count == 0) {
        return;
    }
    
    MainSubView *view = (MainSubView *)[_scrollView viewWithTag:tag];
    for (int i = 0; i < UnitArray.count; i++) {
      //  NSLog(@"aaaarrrrrr%d    %@",UnitArray.count,UnitArray[i]);
        MainPageNewsModel *model = (MainPageNewsModel *)UnitArray[i];
   //     NSLog(@"[[[[[[[[[[[%@",model);
        if (i == 0) {
            [view.picImageView loadImage:model.mainImageurl placeHolder:[UIImage imageNamed:@"588x294"]];
            view.subscribeLabel.text = model.mainTitle;
            view.btn1.tag = model.mainId.integerValue;
        }else if(i == 1){
            [view.picImage1View loadImage:model.mainImageurl placeHolder:[UIImage imageNamed:@"100x100"]];
            view.subtitle1Label.text = model.mainTitle;
            view.date1Label.text = [self timeFormat:model.mainDate];
            view.btn2.tag = model.mainId.integerValue;
        }else{
            [view.picImage2View loadImage:model.mainImageurl placeHolder:[UIImage imageNamed:@"100x100"]];
            view.subtitle2Label.text = model.mainTitle;
            view.date2Label.text = [self timeFormat:model.mainDate];
            view.btn3.tag = model.mainId.integerValue;
        }

    }
    
        for (int i = 0; i < UnitArray.count; i++) {
           // NSLog(@"aaaarrrrrr%d    %@",UnitArray.count,UnitArray[i]);
            MainPageNewsModel *model = (MainPageNewsModel *)UnitArray[i];
            //NSLog(@"[[[[[[[[[[[%@",model);
            if (i == 0) {
                [view.picImageView loadImage:model.mainImageurl placeHolder:[UIImage imageNamed:@"588x294"]];
                view.subscribeLabel.text = model.mainTitle;
                view.btn1.tag = model.mainId.integerValue;
            }else if(i == 1){
                [view.picImage1View loadImage:model.mainImageurl placeHolder:[UIImage imageNamed:@"100x100"]];
                view.subtitle1Label.text = model.mainTitle;
                view.date1Label.text = [self timeFormat:model.mainDate];
                view.btn2.tag = model.mainId.integerValue;
            }else{
                [view.picImage2View loadImage:model.mainImageurl placeHolder:[UIImage imageNamed:@"100x100"]];
                view.subtitle2Label.text = model.mainTitle;
                view.date2Label.text = [self timeFormat:model.mainDate];
                view.btn3.tag = model.mainId.integerValue;
            }
        }

}
#pragma mark -timeFormat method
-(NSString *)timeFormat:(NSString *)time
{
    NSString *ret;
    NSDate *dateNow = [NSDate date];
    NSDate *date = [NSDate dateWithString:time formate:@"yyyy-MM-dd HH:mm:ss.S"];
    NSTimeInterval interval = -[date timeIntervalSinceNow];
   // NSLog(@"interval %f",interval);
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    [format setDateFormat:@"HH:mm"];
    NSDateFormatter *format2 = [[NSDateFormatter alloc]init];
    [format2 setDateFormat:@"yyyy年MM月dd日"];
    NSDateFormatter *format3 = [[NSDateFormatter alloc]init];
    [format3 setDateFormat:@"dd"];
    NSString* dayTime = [format3 stringFromDate:date];
    NSString* nowTime = [format3 stringFromDate:dateNow];
    NSInteger days = nowTime.integerValue - dayTime.integerValue;
    NSString* hourTime = [format stringFromDate:date];
    if (interval/86400 <= 1 && days == 0) {
        ret = [NSString stringWithFormat:@"今天 %@",hourTime];
   // } else if (interval/172800 <= 1 && days == 1){
     //   ret = [NSString stringWithFormat:@"昨天 %@",hourTime];
    } else {
        ret = [format2 stringFromDate:date];
    }
    return ret;
}


#pragma mark - fillDateToLbView method
-(void)fillDataToLbView:(NSArray *)lbArray
{
   
    //添加轮播图
    _num = lbArray.count;
    _pageControl.numberOfPages = _num;
    _pageControl.enabled = NO;
    

    if (_num == 0) {
        ITTImageView *imageView = [[ITTImageView alloc]initWithFrame:CGRectMake(0,0,320,180)];
        imageView.image = [UIImage imageNamed:@"640x360"];
        [_picScrollView addSubview:imageView];
        _pageControl.hidden = YES;
        [_timer invalidate];
        return;
    
    }
    
    if (_num == 1) {
    
        MainPageLbModel *model = lbArray[0];
        ITTImageView *imageView = [[ITTImageView alloc]initWithFrame:CGRectMake(0,0,320,180)];
        imageView.userInteractionEnabled = YES;
        [imageView loadImage:model.mainImageurl placeHolder:[UIImage imageNamed:@"640x360"]];
        imageView.tag = 0;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapTheImageView:)];
        [imageView addGestureRecognizer:tap];
        [_picScrollView addSubview:imageView];
        _pageControl.hidden = YES;
        [_timer invalidate];
        return;
        
    }
        
        for (int i = _num-1 ; i >=0; i--) {
            ITTImageView *imageView = [[ITTImageView alloc]initWithFrame:CGRectMake((i+1)*320, 0, 320,180)];
            imageView.userInteractionEnabled = YES;
            imageView.tag = i;
            //给图片添加手势
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapTheImageView:)];
            [imageView addGestureRecognizer:tap];
            
            //     UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i*320, 0, 320, 120)];
            MainPageLbModel *model = lbArray[i];
            //  [imageView setImageWithURL:[NSURL URLWithString:model.mainImageurl]];
            [imageView loadImage:model.mainImageurl placeHolder:[UIImage imageNamed:@"640x360"]];
            [_picScrollView addSubview:imageView];
        }
        //首尾再添加图片
        
        ITTImageView *firstImageView = [[ITTImageView alloc]initWithFrame:CGRectMake((_num+1)*320, 0, 320, 180)];
        firstImageView.tag = 0;
        MainPageLbModel *firstModel = lbArray[0];
        // [firstImageView setImageWithURL:[NSURL URLWithString:firstModel.mainImageurl]];
        [firstImageView loadImage:firstModel.mainImageurl placeHolder:[UIImage imageNamed:@"640x360"]];
        [_picScrollView addSubview:firstImageView];
        
        ITTImageView *lastImageView = [[ITTImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 180)];
        lastImageView.tag = _num-1;
        MainPageLbModel *lastModel = lbArray[_num-1];
        // [lastImageView setImageWithURL:[NSURL URLWithString:lastModel.mainImageurl]];
        [lastImageView loadImage:lastModel.mainImageurl placeHolder:[UIImage imageNamed:@"640x360"]];
        [_picScrollView addSubview:lastImageView];
        
        _picScrollView.contentOffset = CGPointMake(320, 0);
        //    _picScrollView.contentOffset = CGPointMake(0, 0);
        _picScrollView.contentSize = CGSizeMake(320*(_num+2), 0);
        //    _picScrollView.contentSize = CGSizeMake(320*_num, 120);
        _page = 1;
        //  _lastPage = _lbPic.count-1;
}

#pragma mark -  图片添加的手势9
-(void)tapTheImageView:(UIPanGestureRecognizer *)pan{
    
    MainPageLbModel *model = _lbDataArr[pan.view.tag];
  //  NSLog(@"id %@   type%@  typeid %@",model.mainId,model.mainType,model.mainTypeId);
    switch (model.mainTypeId.integerValue) {
        case 1:
        {//新闻详情
            DetailViewController *detailVc = [[DetailViewController alloc]init];
            detailVc.newsId = model.mainId;
            detailVc.type = NewsDetailType;
            [self.navigationController pushViewController:detailVc animated:YES];
        }
            break;
        case 2:
        {//品鉴心得详情
            /*
            f *detailVc = [[DetailExperienceViewController alloc]init];
            detailVc.ExperienceId = model.mainId;
            [self.navigationController pushViewController:detailVc animated:YES];
             */
            DetailViewController *detailVc = [[DetailViewController alloc]init];
            detailVc.newsId = model.mainId;
            detailVc.type = ExperienceDetailType;
            [self.navigationController pushViewController:detailVc animated:YES];
        }
            break;
        case 3:
        {//专业品鉴详情
            /*
            DetailProfessionalViewController *detailVc = [[DetailProfessionalViewController alloc]init];
            detailVc.ProfessionalId = model.mainId;
            [self.navigationController pushViewController:detailVc animated:YES];
             */
            DetailViewController *detailVc = [[DetailViewController alloc]init];
            detailVc.newsId = model.mainId;
            detailVc.type = ProfessionalDetailType;
            [self.navigationController pushViewController:detailVc animated:YES];
        }
            break;
        case 4:
        {//商品详情
            
            DetailWineViewController *dvc = [[DetailWineViewController alloc]init];
            dvc.wineID = model.mainId;
            [self.navigationController pushViewController:dvc animated:YES];
        }
            break;
        case 5:
        {//酒庄详情
            WineFactoryViewController *wfc = [[WineFactoryViewController alloc]init];
            wfc.WineFactoryID = model.mainId;
            wfc.type = @"0";
            [self.navigationController pushViewController:wfc animated:YES];
        }
            break;
        case 6:
        {//品牌详情
            
            WineFactoryViewController *wfc = [[WineFactoryViewController alloc]init];
            wfc.WineFactoryID = model.mainId;
            wfc.type = @"1";
            [self.navigationController pushViewController:wfc animated:YES];
        }
            break;
        case 7:
        {//酒商详情
            WineShopDetailViewController *wdv = [[WineShopDetailViewController alloc]init];
            wdv.shopId = model.mainId;
            [self.navigationController pushViewController:wdv animated:YES];
        }
            break;
            
        default:
        {
           
        }
            break;
    }
    
}

-(void)changePic
{
    _timeCount ++;
    _page++;
    [_picScrollView setContentOffset:CGPointMake(320*_page, 0) animated:YES];
 //   [self getWineDeviceStatus:<#(NSInteger)#>];
    if (_timeCount == 150) {
        [self connectNet];
    }
}

#pragma mark - ScrollView delegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == _picScrollView) {
        
    if (scrollView.contentOffset.x/320 == _num+1) {
        _picScrollView.contentOffset = CGPointMake(320, 0);
        _page = 0;
    }else if(scrollView.contentOffset.x == 0){
        _picScrollView.contentOffset = CGPointMake(320*_num, 0);
        _page = _num-1;
    }else{
        _page = scrollView.contentOffset.x/320 - 1;
    }
    _pageControl.currentPage = _page;

    } else if (scrollView == _MainScrollView) {

        if (scrollView.contentOffset.x == 320) {
            [LoginManager getBoxWineRequestCompletion:^(BOOL isSuccess, NSString *returnMsg) {
                
            }];
            if (DATA_ENV.deviceMac.length == 0) {
                [LoginManager getUserBindingDeviceCompletion:^(BOOL isSuccess, NSString *returnMsg) {
                    
                }];
            }
            _button = @"rightButton";
            _isMainView = NO;
            [_segment onlyPicMoveToRight];
            if (!DATA_ENV.isBindingDevice) {
                _BingDeviceFirstView.hidden = NO;
                _controlWineView.hidden = YES;
            } else {
             //   [self getWineDeviceStatus];
                _BingDeviceFirstView.hidden = YES;
                _controlWineView.hidden = NO;
            }
            if (!DATA_ENV.isLocalOnline) {
                CommomAlertView *alert = [CommomAlertView loadFromXib];
                alert.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
                alert.delegate = self;
                [[AppDelegate getAppDelegate].window addSubview:alert];
                
            }
            NSDictionary *dict = @{@"button": _button};
            [[NSNotificationCenter defaultCenter] postNotificationName:@"CHANGEBUTTON" object:nil userInfo:dict];

            
        } else if(scrollView.contentOffset.x == 0){
            
            
            _button = @"leftButton";
            [_segment onlyPicMoveToLeft];
            NSDictionary *dict = @{@"button": _button};
            [[NSNotificationCenter defaultCenter] postNotificationName:@"CHANGEBUTTON" object:nil userInfo:dict];

        }
        
    }
}

#pragma mark - CommonAlertViewDelegate

- (void)CommonAlertViewClickedWithTag:(NSInteger)tag
{
    if (tag == 1) {
        LoginViewController *nwvc = [[LoginViewController alloc]init];
        nwvc.delegate = self;
        UINavigationController *nvc = [[UINavigationController alloc]initWithRootViewController:nwvc];
        [self presentViewController:nvc animated:YES completion:^{
            
        }];
    } else {
        [_MainScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        [_segment onlyPicMoveToLeft];
    }
}

- (void)loginSuccess
{
 //   [_segment onlyPicMoveToRight];
  //  [self change:102];


}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (DATA_ENV.isBindingDevice == NO) {
        _BingDeviceFirstView.hidden = NO;
        _controlWineView.hidden = YES;
    } else {
        _BingDeviceFirstView.hidden = YES;
        _controlWineView.hidden = NO;
    }
    if (scrollView == _picScrollView) {

    [_timer setFireDate:[NSDate distantFuture]];
        
    }
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [_timer setFireDate:[NSDate distantPast]];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == _MainScrollView) {
        if (scrollView.contentOffset.x == 320) {
            _isMainView = NO;
        } else {
            _isMainView = YES;
        }
    } else {
        
    }
}

- (void)initiCarousel
{
    _previousIndex = 20;
    _iCarousel = [[iCarousel alloc]initWithFrame:CGRectMake(0, 0, 180, 180)];
    _iCarousel.vertical = YES;
    _iCarousel.delegate = self;
    _iCarousel.dataSource = self;
    _iCarousel.type = iCarouselTypeLinear;
    _iCarousel.decelerationRate = 0.5;
    [_controlWineTemperatureView addSubview:_iCarousel];
    [self setSuitTemperature:12];

}

#pragma mark - suitTemperature

- (void)setSuitTemperature:(NSInteger)temperature
{
    NSInteger upIndex;
    NSInteger downIndex;
    NSInteger currentIndex;
    NSInteger tem = TOP_TEMPERATURE +6 -temperature;
    if (temperature == 5) {
        upIndex = TOP_TEMPERATURE;
        downIndex = 1;
        currentIndex = 0;
    } else if (temperature == 6) {
        upIndex = TOP_TEMPERATURE - 1;
        downIndex = 14;
        currentIndex = 13;
    }
    else {
        upIndex = tem -1;
        downIndex = tem +1;
        currentIndex = tem;
    }
    [_iCarousel scrollToItemAtIndex:tem animated:YES];
   // _PreviousScrollOffset = _iCarousel.scrollOffset;
    
    [self setLabelFontWithIndex:upIndex and:downIndex with:currentIndex and:_iCarousel];
  //  NSLog(@"%d---%d",tem,_iCarousel.currentItemIndex);
}


#pragma mark - AddWineButton

- (IBAction)addWineButton:(id)sender
{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"newHandView"] == nil) {
        [[NSUserDefaults standardUserDefaults] setObject:@"noWine" forKey:@"newHandView"];
    }
    DATA_ENV.HereHerestep1 = YES;
    ScanningCodeViewController * reader = [ScanningCodeViewController new];
    reader.formWhere = @"1";
    reader.delegate = self;
    [self.navigationController pushViewController:reader animated:YES];
}

-(void)showTemperature
{
    
    [_segment exchangeToRight];
    if (self.blurView == nil) {
        
        [self addBlurViewOnView:_controlView];
        [_controlView bringSubviewToFront:_tempView];
        
    }
    self.blurView.alpha = 1.0f;
    _tempView.alpha = 1.0f;
    self.blurView.hidden = NO;
    _tempView.hidden = NO;
}

#pragma mark - iCarouselDataSource

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return [_dataArray count];
}

- (NSUInteger)numberOfVisibleItemsInCarousel:(iCarousel *)carousel
{
    return 3;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
  
    
    UILabel *label = nil;
	//create new view if no view is available for recycling
	if (view == nil)
	{
        view = [[UIView alloc]init];
        view.frame = CGRectMake(0, 0, 170, 70);
        view.backgroundColor = [UIColor clearColor];
		label = [[UILabel alloc] initWithFrame:view.bounds];
        label.backgroundColor = [UIColor clearColor];
		label.textAlignment = UITextAlignmentCenter;
		label.font = [label.font fontWithSize:30];
        label.textColor = [UIColor clearColor];
		[view addSubview:label];
	}
	else
	{
		label = [[view subviews] lastObject];
	}
	label.text = [_dataArray objectAtIndex:index];
	return view;
}

- (CGFloat)carouselItemWidth:(iCarousel *)carousel
{
    //usually this should be slightly wider than the item views
    return 70;
}

#pragma mark - iCarouselDelegate

- (void)carouselCurrentItemIndexUpdated:(iCarousel *)carousel
{
    NSInteger  upLabelIndex;
    NSInteger  downLabelIndex;

    upLabelIndex = carousel.currentItemIndex-1;
    downLabelIndex = carousel.currentItemIndex+1;
    if (carousel.currentItemIndex==0) {
        upLabelIndex = [_dataArray count]-1;
    }
    if (carousel.currentItemIndex == [_dataArray count]){
        downLabelIndex = 0;
    }
    [self setLabelFontWithIndex:upLabelIndex and:downLabelIndex with:carousel.currentItemIndex  and:carousel];
    
}
- (void)carouselWillBeginDragging:(iCarousel *)carousel
{
    _isStop = NO;
}

- (void)carouselDidEndDecelerating:(iCarousel *)carousel
{
    NSInteger  currenTemperature;
    //  NSInteger  setTemperature;
    
    NSInteger  userSetTemperature = TOP_TEMPERATURE - carousel.currentItemIndex+6;
    if (userSetTemperature == TOP_TEMPERATURE+6) {
        userSetTemperature = 5;
    }
    DATA_ENV.suitableTemp = [NSString stringWithFormat:@"%d",userSetTemperature];
    //   NSLog(@"currentTemperature---%d",currentTemperature);
    if (_isDeciveConnection) {
        [[WineManager shareWineManager] controlTemperature:[NSString stringWithFormat:@"%d",userSetTemperature-5]];
        
    }
    
    // if (_wineBoxTemperature.text.length!=0) {
    currenTemperature =[_currentWineBoxTem integerValue];
    //  } else {
    //    currenTemperature = 0;
    // }
    //_PreviousScrollOffset = carousel.scrollOffset;
  //  NSLog(@"_wineBoxTemperature=%@---%d",_currentWineBoxTem,userSetTemperature);
    if (userSetTemperature > currenTemperature&&_deviceEnable) {
        _isTemperatureUp = YES;
        [self hiddenCAShapeLayer];
    }else if(userSetTemperature < currenTemperature&&_deviceEnable) {
        _isTemperatureUp = NO;
        [self hiddenCAShapeLayer];
    } else{
        for (CAShapeLayer *layer in _circleShapArrayUp) {
            layer.hidden = YES;
        }
        for (CAShapeLayer *layer in _circleShapArrayDown) {
            layer.hidden = YES;
        }
    }

}
- (BOOL)carousel:(iCarousel *)carousel shouldSelectItemAtIndex:(NSInteger)index
{
    
    return YES;
}
- (void)carouselDidEndDragging:(iCarousel *)carousel willDecelerate:(BOOL)decelerate
{
    NSInteger  currenTemperature;
    //  NSInteger  setTemperature;
    
    NSInteger  userSetTemperature = TOP_TEMPERATURE - carousel.currentItemIndex+6;
    if (userSetTemperature == TOP_TEMPERATURE+6) {
        userSetTemperature = 5;
    }
    DATA_ENV.suitableTemp = [NSString stringWithFormat:@"%d",userSetTemperature];
    //   NSLog(@"currentTemperature---%d",currentTemperature);
    if (_isDeciveConnection) {
        [[WineManager shareWineManager] controlTemperature:[NSString stringWithFormat:@"%d",userSetTemperature-5]];
        
    }
    
    // if (_wineBoxTemperature.text.length!=0) {
    currenTemperature =[_currentWineBoxTem integerValue];
    //  } else {
    //    currenTemperature = 0;
    // }
    //_PreviousScrollOffset = carousel.scrollOffset;
   // NSLog(@"_wineBoxTemperature=%@---%d",_currentWineBoxTem,userSetTemperature);
    if (userSetTemperature > currenTemperature&&_deviceEnable) {
        _isTemperatureUp = YES;
        [self hiddenCAShapeLayer];
    }else if(userSetTemperature < currenTemperature&&_deviceEnable) {
        _isTemperatureUp = NO;
        [self hiddenCAShapeLayer];
    } else {
        for (CAShapeLayer *layer in _circleShapArrayUp) {
            layer.hidden = YES;
        }
        for (CAShapeLayer *layer in _circleShapArrayDown) {
            layer.hidden = YES;
        }
    }

}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
    NSInteger  currenTemperature;
    UILabel *label = (UILabel*)[carousel itemViewAtIndex:index].subviews.lastObject;
    
 //   NSLog(@"当前index%@---%d----%d",label.text,carousel.currentItemIndex,index);
    NSInteger  userSetTemperature = [label.text integerValue];//TOP_TEMPERATURE - carousel.currentItemIndex+5;
//    if (userSetTemperature == TOP_TEMPERATURE+6) {
//        userSetTemperature = 5;
//    }
    DATA_ENV.suitableTemp = [NSString stringWithFormat:@"%d",userSetTemperature];
    //   NSLog(@"currentTemperature---%d",currentTemperature);
    if (_isDeciveConnection) {
        [[WineManager shareWineManager] controlTemperature:[NSString stringWithFormat:@"%d",userSetTemperature-5]];
        
    }
    
    // if (_wineBoxTemperature.text.length!=0) {
    currenTemperature =[_currentWineBoxTem integerValue];
    //  } else {
    //    currenTemperature = 0;
    // }
    //_PreviousScrollOffset = carousel.scrollOffset;
  //  NSLog(@"_wineBoxTemperature=%d---%d",index,userSetTemperature);
    if (userSetTemperature > currenTemperature&&_deviceEnable) {
        _isTemperatureUp = YES;
        [self hiddenCAShapeLayer];
    }else if(userSetTemperature < currenTemperature&&_deviceEnable) {
        _isTemperatureUp = NO;
        [self hiddenCAShapeLayer];
    } else{
        for (CAShapeLayer *layer in _circleShapArrayUp) {
            layer.hidden = YES;
        }
        for (CAShapeLayer *layer in _circleShapArrayDown) {
            layer.hidden = YES;
        }
    }

   // NSLog(@"&&&&&&&&$$$%d",userSetTemperature);
}

- (void)stopanimation
{
    if(_isStop)
    {
        for (CAShapeLayer *layer in _circleShapArrayDown) {
            layer.hidden = YES;
        }
        for (CAShapeLayer *layer in _circleShapArrayUp) {
            layer.hidden = YES;
        }
    }
}
- (void)carouselDidScroll:(iCarousel *)carousel
{
    _isStop = NO;
    CGFloat  offset = fabs(carousel.scrollOffset-carousel.itemWidth*carousel.currentItemIndex);
    CGFloat textAlpha = 1-offset/35*0.9;
    CGFloat fontSize =(1- offset/35)*20+25;
    _currentLabel.textColor = [UIColor colorWithWhite:1 alpha:textAlpha];
    _currentLabel.font = [_currentLabel.font fontWithSize:fontSize];

}

- (void)setLabelFontWithIndex:(NSInteger)upIndex and:(NSInteger)downIndex with:(NSInteger)currentIndex and:(iCarousel *)carousel
{
    NSInteger labelIndex = carousel.numberOfItems - currentIndex+5;
   // NSInteger labelIndex = TOP_TEMPERATURE - currentIndex +6;
    NSInteger upLabelIndex = labelIndex + 1;
    NSInteger downLabelIndex = labelIndex - 1;
    if (currentIndex == 0) {
        labelIndex = 5;
        upLabelIndex = 6;
    }
    if (currentIndex == 1) {
        upLabelIndex = 5;
    }
    if (currentIndex == 13) {
        upLabelIndex = 7;
        downLabelIndex = 5;
        downIndex = 0;
    }
  //  NSLog(@"upIndex=%d----downIndex=%d----currentIndex=%d---%d",upIndex,downIndex,currentIndex,carousel.numberOfItems);
    _upLabel = (UILabel*)[carousel itemViewAtIndex:upIndex].subviews.lastObject;
    _upLabel.textColor = [UIColor colorWithWhite:1 alpha:0.1];
    _upLabel.font = [_upLabel.font fontWithSize:30];
    _upLabel.text = [NSString stringWithFormat:@"%d",upLabelIndex];
    
    _downLabel = (UILabel*)[carousel itemViewAtIndex:downIndex].subviews.lastObject;
    _downLabel.font = [_downLabel.font fontWithSize:30];
    _downLabel.textColor = [UIColor colorWithWhite:1 alpha:0.1];
    _downLabel.text = [NSString stringWithFormat:@"%d",downLabelIndex];

    _currentLabel = (UILabel*)carousel.currentItemView.subviews.lastObject;
    _currentLabel.font = [UIFont fontWithName:@"Helvetica" size:30];
    _currentLabel.textColor = [UIColor colorWithWhite:1 alpha:0.1];
    _currentLabel.text = [NSString stringWithFormat:@"  %d°",labelIndex];

}

#pragma mark - initMainView method

-(void)initMainView
{
//    _mainView.top = 64;
    
    //新闻 专业品鉴 品鉴心得
    for (int i = 0; i < 3; i++) {
        MainSubView *mainSubView = [MainSubView loadFromXib];
        float len1 = [UILabel layoutLabelWidthWithText:@"新闻" font:[UIFont systemFontOfSize:18] height:300];
        float len2 = [UILabel layoutLabelWidthWithText:@"专业品鉴" font:[UIFont systemFontOfSize:18] height:300];
        if (0 == i) {
            mainSubView.titleLabel.text = @"新闻";
            mainSubView.title2Label.left = 12+len1+4;
      //      mainSubView.title2Label.text = @"/NEWS";
        }else if(1 == i) {
            mainSubView.titleLabel.text = @"专业品鉴";
            mainSubView.title2Label.left = 12+len2+4;
     //       mainSubView.title2Label.text = @"/PROFESSIONAL";
        }else{
            mainSubView.titleLabel.text = @"品鉴心得";
            mainSubView.title2Label.left = 12+len2+4;
     //       mainSubView.title2Label.text = @"/EXPERIENCE";
        }
        mainSubView.tag = 400+i;
        mainSubView.controller = self;
        mainSubView.top = 15 + i * (15 + 305) +210+56+4;
        mainSubView.left = 13;
        [_scrollView addSubview:mainSubView];
    }
    //名酒庄 品牌汇
    for (int i = 0; i < 2; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(13+i*(144+6), 15+2*(15+305)+210+56+4+305+20, 144, 135);
        if (i == 0) {
            [btn setImage:[UIImage imageNamed:@"main_famous_park_n.png"] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(famousParkWineClick:) forControlEvents:UIControlEventTouchUpInside];
        }else{
            [btn setImage:[UIImage imageNamed:@"main_brand_n.png"] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(brandClick:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        btn.tag = 300+i;
        [_scrollView addSubview:btn];
    }
    if(!is4InchScreen()){
       // _MainScrollView.height = 480-64;
        _mainView.height = 480-64;
       // _scrollView.height = 480-64;
    } else {
       // _controlView.height = 504;
       // _mainView.height  = 504;
       // _MainScrollView.height =504;
    }
    [_MainScrollView addSubview:_mainView];
    
}

#pragma mark - famousParkWineClick method

-(void)famousParkWineClick:(id)sender
{
    
    FamousParkWineViewController *famousParkWine = [[FamousParkWineViewController alloc]init];
    [self.navigationController pushViewController:famousParkWine animated:YES];
}

#pragma mark - brandClick method

-(void)brandClick:(id)sender
{

    BrandViewController *brand = [[BrandViewController alloc]init];
    [self.navigationController pushViewController:brand animated:YES];
}

//#pragma mark - modifyPageControl method
//
//-(void)modifyPageControl
//{
//    
//}

#pragma mark - TopExchangeView delegate

-(void)changeWithOutAnimation:(NSInteger)tag
{
    if (DATA_ENV.isBindingDevice == NO) {
        _BingDeviceFirstView.hidden = NO;
        _controlWineView.hidden = YES;
    } else {
        _BingDeviceFirstView.hidden = YES;
        _controlWineView.hidden = NO;
    }
    if (101 == tag) {//首页
        _isTopButtonLeft = YES;
        //8.22       _mainView.hidden = NO;
        //8.22       _controlWineView.hidden = YES;
        [_MainScrollView setContentOffset:CGPointMake(0, 0) animated:NO];
    }else if(102 == tag){//我的酒柜
        _isTopButtonLeft = NO;
        //8.22        _mainView.hidden = YES;
        //8.22        _controlWineView.hidden = NO;
        [_MainScrollView setContentOffset:CGPointMake(320, 0) animated:NO];
        if (!DATA_ENV.isBindingDevice) {
            /*8.22
             BingDeviceFirstViewController *bing = [[BingDeviceFirstViewController alloc]init];
             [self.navigationController pushViewController:bing animated:YES];
             */
            _BingDeviceFirstView.hidden = NO;
            _controlWineView.hidden = YES;
        } else {
           //  [self getWineDeviceStatus];
            _BingDeviceFirstView.hidden = YES;
            _controlWineView.hidden = NO;
            
        }
        
    }
    
}

-(void)change:(NSInteger)tag
{
    if (101 == tag) {//首页
        _isTopButtonLeft = YES;
 //8.22       _mainView.hidden = NO;
 //8.22       _controlWineView.hidden = YES;
        _isWineBox = NO;
        [_MainScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }else if(102 == tag){//我的酒柜
        _isTopButtonLeft = NO;
        _isWineBox = YES;
//8.22        _mainView.hidden = YES;
//8.22        _controlWineView.hidden = NO;
        [_MainScrollView setContentOffset:CGPointMake(320, 0) animated:YES];
        
        if (!DATA_ENV.isBindingDevice) {
            /*8.22
            BingDeviceFirstViewController *bing = [[BingDeviceFirstViewController alloc]init];
            [self.navigationController pushViewController:bing animated:YES];
            */
            _BingDeviceFirstView.hidden = NO;
            _controlWineView.hidden = YES;
        } else {
          //  [self getWineDeviceStatus];
            _BingDeviceFirstView.hidden = YES;
            _controlWineView.hidden = NO;

        }
    }
}

#pragma mark - Button Methods
//温度
//-(IBAction)temperatureBtn:(id)sender
//{
//    TemperatureView *_tempView = [TemperatureView loadFromXib];
//    _tempView.top = 0;
//    [self.view addSubview:_tempView];
//}

- (IBAction)onMenuButton:(id)sender
{
    if (self.navigationController.revealController.focusedController == self.navigationController.revealController.leftViewController)
    {
        [_MainScrollView setContentOffset:CGPointMake(320, 0) animated:YES];
        [_segment onlyPicMoveToRight];
        [self.navigationController.revealController showViewController:self.navigationController.revealController.frontViewController animated:YES completion:^(BOOL finished) {
        }];
    }
    else
    {
        [self.navigationController.revealController showViewController:self.navigationController.revealController.leftViewController animated:YES completion:^(BOOL finished) {
            if (finished) {

                self.navigationController.revealController.recognizesPanningOnFrontView = YES;
//9.12dd
//                [_MainScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
//               [_segment onlyPicMoveToLeft];
//                self.navigationController.revealController.recognizesPanningOnFrontView = YES;
//9.12dd
            }
        }];
    }
}

-(IBAction)onSearchButton:(id)sender
{
    SearchWineViewController *svc = [[SearchWineViewController alloc]init];
    [self.navigationController pushViewController:svc animated:YES];

 //   NSLog(@"search");

}

-(IBAction)scanButton:(id)sender
{
  //  NSLog(@"扫一扫");
//    DetailWineViewController *detailVC = [[DetailWineViewController alloc]init];
//    detailVC.wineID = nil;
//    detailVC.isScan = YES;
//    _isScaning = YES;
//    [self.navigationController pushViewController:detailVC animated:NO];
    ScanningCodeViewController * reader = [ScanningCodeViewController new];
    reader.formWhere = @"0";
    [self.navigationController pushViewController:reader animated:YES];
    
}
-(IBAction)whiteButton:(id)sender
{

    NewWhiteBoardViewController *wvc = [[NewWhiteBoardViewController alloc]init];
    [self.navigationController pushViewController:wvc animated:YES];
}

- (IBAction)lightClick:(id)sender
{
    if(!DATA_ENV.isDeviceOneline){
        return;
    }
    UIButton *btn = (UIButton *)sender;
    [[WineManager shareWineManager] controlLamp:btn.selected];
    btn.selected = !btn.selected;
    //[[WineManager shareWineManager] controlTemperature:@"30"];
}

#pragma mark - temperatureAnimaton

-(void)setUpCircleShaps
{
    for (int i=0; i<8; i++) {
        
        NSMutableArray *circleShapeArray;
        if (_upOrDown) {
            _circleShapWidth = 188;
            _circleCornerRadius = 93;
            _circleLineWidth = 0.4;
            _transformScale = 1.1f;
            _circleBeginOpacity = 1;
            _circleEndOpacity = 0;
            circleShapeArray = _circleShapArrayUp;
            _upOrDown = !_upOrDown;
        } else {
            _circleShapWidth = 320;
            if( [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
            {
                _circleCornerRadius = 109;
            }
            _circleCornerRadius = 157;//108
            _circleLineWidth = 1;
            _transformScale = 0.58;
            _circleBeginOpacity = 0;
            _circleEndOpacity = 1;
            circleShapeArray = _circleShapArrayDown;
            _upOrDown = !_upOrDown;
        }
        CGRect pathFrame = CGRectMake(-_circleShapWidth/2, -_circleShapWidth/2, _circleShapWidth, _circleShapWidth);
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:pathFrame cornerRadius:_circleCornerRadius];//down107
        CAShapeLayer *circleShap = [CAShapeLayer layer];
        circleShap.path = path.CGPath;
        if (is4InchScreen()) {
            circleShap.position = CGPointMake(160, 160);
        } else {
            circleShap.position = CGPointMake(160, 126);
        }
        //127
        circleShap.fillColor = [UIColor clearColor].CGColor;
        circleShap.strokeColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.6].CGColor;
        circleShap.opacity = 0;
        circleShap.lineWidth = _circleLineWidth;
        [circleShapeArray addObject:circleShap];
        circleShap.hidden = YES;
        [_animatonBgView.layer addSublayer:circleShap];
    }
}

- (void)temperatureAnimation
{

    if (_circleIndex==3) {
        _circleIndex=0;
    }
    CAShapeLayer *circleShap = [_circleShapArrayUp objectAtIndex:_circleIndex];
    _transformScale = 1.7f;
    _circleBeginOpacity = 1;
    _circleEndOpacity = 0;
    [self animationWithCAShapLayer:circleShap];
    circleShap = [_circleShapArrayDown objectAtIndex:_circleIndex];
    _transformScale = 0.58;
    _circleBeginOpacity = 0;
    _circleEndOpacity = 1;
   [self animationWithCAShapLayer:circleShap];
    [self performSelector:@selector(temperatureAnimation) withObject:nil afterDelay:1.5];
    _circleIndex++;
}
- (void)animationWithCAShapLayer:(CAShapeLayer*)circleShap
{
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    scaleAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(_transformScale, _transformScale, 1)];
    CABasicAnimation *alphaAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    alphaAnimation.fromValue = [NSNumber numberWithInt:_circleBeginOpacity];
    alphaAnimation.toValue = [NSNumber numberWithInt:_circleEndOpacity];
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.delegate = self;
    animationGroup.animations = @[scaleAnimation,alphaAnimation];
    animationGroup.duration = 4.0f;
    animationGroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [circleShap addAnimation:animationGroup forKey:nil];
}

- (void)hiddenCAShapeLayer
{
    for (int i =0; i<_circleShapArrayUp.count; i++) {
        CAShapeLayer *shapLayer = [_circleShapArrayUp objectAtIndex:i];
        shapLayer.hidden = !_isTemperatureUp;
    }
    for (int i =0; i<_circleShapArrayDown.count; i++) {
        CAShapeLayer *shapLayer = [_circleShapArrayDown objectAtIndex:i];
        shapLayer.hidden = _isTemperatureUp;
    }
    
}

#pragma mark - liquidAnimation

- (void)viewAnimation
{
    [UIView animateWithDuration:10.5f delay:0 options:UIViewAnimationOptionCurveLinear  animations:^{
        CGFloat left = _liquidImageViewA1.left;//_liA1.left;
        left = left+374;
        _liquidImageViewA1.left = left;
        _liquidImageViewB1.left = left;
        
        left = _liquidImageViewA2.left;
        left = left+374;
        _liquidImageViewA2.left =left;
        _liquidImageViewB2.left = left;
    } completion:^(BOOL finished) {
        if (finished) {
            if(_isFirstPic){
                CGFloat left = -374;
                _liquidImageViewA1.left = left;
                _liquidImageViewB1.left = left;
                _isFirstPic = NO;
            } else{
                CGFloat left = -374;
                _liquidImageViewA2.left = left;
                _liquidImageViewB2.left = left;
                _isFirstPic = YES;
            }
            [self viewAnimation];
        }
        
    }];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
//
//#pragma mark - addNewWine
//
//- (IBAction)addNewWine:(id)sender
//{
//    //9.1 添加酒品
//    ScanningCodeViewController * reader = [ScanningCodeViewController new];
//    reader.formWhere = @"1";
//    reader.delegate = self;
//    [self.navigationController pushViewController:reader animated:YES];
//}

#pragma mark - detailWine

- (IBAction)detailWine:(id)sender
{
    if (DATA_ENV.wineID.length == 0) {
        [self addTemperatureView];
    } else {
    UIButton *btn = (UIButton *)sender;
    DetailWineViewController *detailWineViewController = [[DetailWineViewController alloc]init];
    detailWineViewController.wineID = DATA_ENV.wineID;
    detailWineViewController.wineName = btn.titleLabel.text;
    [self.navigationController pushViewController:detailWineViewController animated:YES];
    }
}

- (BOOL)carouselShouldWrap:(iCarousel *)carousel
{
    return YES;
}
//8.22
#pragma mark - ButtonClick

- (IBAction)addDeviceButton:(id)sender
{
   // uSDKErrorConst error = [[WineManager shareWineManager] startHaierUSDK];
    
    //if (error == RET_USDK_OK) {
     //   _isOpenUSDK = YES;
        BingDeviceNextViewController *bfv = [[BingDeviceNextViewController alloc]init];
        [self.navigationController pushViewController:bfv animated:YES];
   // } else {
#warning 提示uSDK错误 tip！
 //   }
    //  BingDeviceNextViewController *bfv = [[BingDeviceNextViewController alloc]init];
    //       [self.navigationController pushViewController:bfv animated:YES];
    
}

#pragma mark - buyWineBox

- (IBAction)buyWineBox:(id)sender
{
    WebViewController *wvc = [[WebViewController alloc]init];
    [self.navigationController pushViewController:wvc animated:YES];
}

#pragma mark - getDeviceStatus Notification

- (void)getWineDeviceStatus:(NSInteger)status
{
    NSString *deviceStatus;
   // NSInteger status=[[WineManager shareWineManager] getDeviceStatues];
    if (status == 0 || status == 1 || status == 3) {
        deviceStatus = @"当前设备不可用";
    } else {
        _deviceEnable = YES;
        _addWineButton.enabled = YES;
        _changeWineButton.enabled = YES;
        _wineDeviceLabel.hidden = YES;
        _wineNameButton.enabled = YES;
        _wineDeviceLabel.text = nil;
        DATA_ENV.isDeviceOneline = YES;
        if (DATA_ENV.wineName.length == 0) {
            _noWineBgView.hidden = NO;
            _wineDeviceStatues.hidden = YES;
            
        } else {
            _noWineBgView.hidden = YES;
            _wineDeviceStatues.hidden = NO;
        }
        return;
    }
   // _deviceEnable = NO;
    _changeWineButton.enabled = NO;
    _addWineButton.enabled = NO;
    _wineNameButton.enabled = NO;
    _noWineBgView.hidden = YES;
    _wineDeviceLabel.hidden = NO;
    _wineDeviceLabel.text = deviceStatus;
    _wineDeviceStatues.hidden = YES;
    _wineBoxLightButton.selected = NO;
    DATA_ENV.isDeviceOneline = NO;

//    for (CAShapeLayer *layer in _circleShapArrayUp) {
//        layer.hidden = YES;
//    }
//    for (CAShapeLayer *layer in _circleShapArrayDown) {
//        layer.hidden = YES;
//    }
}

#pragma mark - light

- (IBAction)drinkLight:(id)sender
{
    ControlWineAlertView *alertView = [ControlWineAlertView loadFromXib];
    alertView.alertViewImageView.image = [UIImage imageNamed:@"nextVersion_alertView"];
    alertView.alertViewImageView.frame = CGRectMake(108, 50, 53, 71);
    alertView.alertViewLabel.text = @"敬请期待, 后续版本";
    alertView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    [self.view addSubview:alertView];

}

- (IBAction)healthLight:(id)sender
{
    ControlWineAlertView *alertView = [ControlWineAlertView loadFromXib];
    alertView.alertViewImageView.image = [UIImage imageNamed:@"nextVersion_alertView"];
    alertView.alertViewImageView.frame = CGRectMake(108, 50, 53, 71);
    alertView.alertViewLabel.text = @"敬请期待, 后续版本";
    alertView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    [self.view addSubview:alertView];

}

#pragma mark - scancode delegate

- (void)showWineControl
{
    [self addTemperatureView];
    
}


@end
