//
//  DetailWineViewController.m
//  HaierWine
//
//  Created by isoftstone on 14-7-7.
//
//

#import "DetailWineViewController.h"
#import "DetailBackgroundView.h"
#import "DetailWineButtonView.h"
#import "DetailSelectButtonView.h"
#import "DetailDescribeView.h"
#import "DetailWineRegionImageView.h"
#import "DetailWineAddressView.h"
#import "WineDetailInfo.h"
#import "UIImageView+WebCache.h"
#import "UIAlertView+ITTAdditions.h"
#import "WineDetailImages.h"
#import "MainViewController.h"
#import "WineShopListViewController.h"
#import "ITTImageView.h"
#import "BaseNavigationController.h"
#import "AppDelegate.h"
#import "PKRevealController.h"
#import "HaierDataCacheManager.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreText/CoreText.h>
//9.14d
#define HaierDataCacheManager ([HaierDataCacheManager sharedManager])
//9.14d

@interface DetailWineViewController ()
{
    
    IBOutlet UIButton *_voiceButton;
    IBOutlet UILabel *_tipLabel;
    IBOutlet UIView          *_tipView;
    IBOutlet UIView           *_imageBgView;
    IBOutlet UILabel          *_newHandLabel;
    IBOutlet UIView           *_newHandView;
    IBOutlet UIImageView      *_arrowImageView;
    IBOutlet UIView           *_certificateView;
    IBOutlet ITTImageView      *_certificateImageView;
    IBOutlet UIImageView      *_bgImageView;
    IBOutlet UITextView       *_textView;
    
    IBOutlet UILabel          *_wineForeignName;
    IBOutlet UIImageView      *_voiceImageView;
    IBOutlet UIView           *_contentView;
    IBOutlet UIView           *_winePopView;
    IBOutlet UIView           *_winePopContentView;
    IBOutlet UILabel          *_winePopTitleLabel;
    IBOutlet UILabel          *_winePopContentLabel;
    IBOutlet ITTImageView     *_winePopImageView;
    IBOutlet UIView           *_requestBackView;
    IBOutlet UIScrollView     *_detailScrollView;
    IBOutlet UIButton         *_wineCollectionButton;
    
    DetailDescribeView        *_detailDescribeView;
    DetailWineButtonView      *_detailWineButtonView;
    DetailWineRegionImageView *_detailWineRegionImageView;
    DetailWineAddressView     *_detailWineAddressView;
    DetailSelectButtonView    *_detailSelectButtonView;
    OriginView                *_originView;
    VegetableView             *_vegetableView;
    DetailBackgroundView      *_dbv;
    DetailWinePicVIew         *_picView;
    
    WineDetailInfo            *_wineDetailInfo;
    AudioStreamer             *_streamer;
    NSTimer                   *_timer;
    NSInteger                 _count;
    NSInteger                 _index;
    NSInteger                 _viewType;
    NSInteger                 _arrowTop;
    NSInteger                 _animationDuration;

    NSArray                   *_antiFakeImages;
    NSArray                   *_vegetableImages;
    
    NSString                  *_footTitle;
    CGFloat                    _labelAlpha;
    BOOL                       _isLoadData;
    BOOL                       _isVegetableViewFirst;
    BOOL                       _isOriginViewFirst;
    BOOL                       _isRequestForScan;
    BOOL                       _isDown;
    BOOL                       _isLabelDown;
    BOOL                       _isOverAnimation;
    BOOL                       _isAddWine;
    BOOL                       _isAnimation;
  //  BOOL                       _isPerform;

}
@end

@implementation DetailWineViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    _tipView.layer.cornerRadius = 8;
    _count = 0;
    _isAddWine = YES;
    _isRequestForScan = NO;
    _animationDuration = 0;
    //添加到我的浏览
    [self addScanRequest];
    // Do any additional setup after loading the view from its nib.
    _isLoadData = NO;
    _isOverAnimation = NO;
    _winePopContentView.layer.cornerRadius = 10;
    _imageBgView.layer.cornerRadius = 5;
    _isAnimation = NO;
    [self initView];
    
    self.navigationController.revealController.recognizesPanningOnFrontView = NO;
    _timer = [NSTimer timerWithTimeInterval:0.5 target:self selector:@selector(timeUp) userInfo:nil repeats:YES];
    [[NSRunLoop  currentRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
    [self wineDetailInfoRequest];
//    if (![DATA_ENV.voiceOn boolValue]) {
//        _voiceButton.enabled = YES;
//    } else {
//        _voiceButton.enabled = NO;
//        //   _isAnimation = NO;
//    }

    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [_streamer stop];
}


#pragma mark - popViewDelegate

- (IBAction)popViewDelegate:(id)sender
{
    _winePopView.hidden = YES;
   // self.blurView.hidden = YES;

}

#pragma mark - alertView delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
     //取消 回首页
       [self.navigationController popToRootViewControllerAnimated:YES];
//        MainViewController * root = (MainViewController *)self.navigationController.viewControllers[0];
//        [root showTemperature];
//        [self.navigationController popToRootViewControllerAnimated:NO];
        
        
        
    } else if (buttonIndex == 1){
    //确定 回控酒页
       
    }
    _isRequestForScan = NO;
}

- (void)initView
{
    _picView = [DetailWinePicVIew loadFromXib];
    [_detailScrollView addSubview:_picView];

    _detailSelectButtonView = [DetailSelectButtonView loadFromXib];
    _detailSelectButtonView.delegate = self;
    _detailSelectButtonView.top = 240;
    [_detailScrollView addSubview:_detailSelectButtonView];
    _detailDescribeView = [DetailDescribeView loadFromXib];
    _detailDescribeView.top = _detailSelectButtonView.bottom;
    _detailDescribeView.delegate = self;
    [_detailScrollView addSubview:_detailDescribeView];
    _detailWineButtonView = [DetailWineButtonView loadFromXib];
    _detailWineButtonView.delegate = self;
    _detailWineButtonView.top = _detailDescribeView.bottom;
    [_detailScrollView addSubview:_detailWineButtonView];
    _detailWineRegionImageView = [DetailWineRegionImageView loadFromXib];
    //tupian
    _detailWineRegionImageView.top = _detailWineButtonView.bottom;
    [_detailScrollView addSubview:_detailWineRegionImageView];
    _detailWineAddressView = [DetailWineAddressView loadFromXib];

    _detailWineAddressView.top = _detailWineRegionImageView.bottom;
    [_detailScrollView addSubview:_detailWineAddressView];
    [self setDetailScrollViewSize:_detailWineAddressView.bottom];
    
    [_contentView addSubview:_winePopView];
    [_contentView addSubview:_certificateView];
    _certificateView.hidden = YES;
    _winePopView.hidden = YES;
    
  }

#pragma mark - updateView

- (void)updateView
{
    if(DATA_ENV.HereHerestep1==YES && DATA_ENV.HereHerestep2 == YES){
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"newHandView"] isEqualToString:@"noWine"]) {
            _newHandView.frame = CGRectMake(0, -45, self.view.bounds.size.width, self.view.bounds.size.height);
            [self.view addSubview:_newHandView];
            _arrowTop = _arrowImageView.top;
            [self newHandArrowAnimation];
            _isDown = YES;
            _isLabelDown = YES;
            _labelAlpha = 0;
            [self newHandLabelAnimation];
            [[NSUserDefaults standardUserDefaults] setObject:@"haveWine" forKey:@"newHandView"];
        }
    }
    WineDetailImages *wineImage;
    [self AddForeignName:_wineDetailInfo.wineForeignName];
    if (_wineDetailInfo.winePicture.count>0) {
        wineImage = [_wineDetailInfo.winePicture objectAtIndex:0];
    }
    _picView.wineNameLabel.text = wineImage.wineName;
    _picView.wineTemperarureLabel.text = [NSString stringWithFormat:@"%@°C",_wineDetailInfo.wineRecommendTemperature];
    
    DATA_ENV.suitableTemp = _wineDetailInfo.wineRecommendTemperature;
    _picView.wineCityLabel.text = _wineDetailInfo.wineEcity;
    _picView.imageArray = _wineDetailInfo.winePicture;
    
    _detailDescribeView.wineName = wineImage.wineName;
    _wineName = wineImage.wineName;
    _detailDescribeView.wineDescribe = _wineDetailInfo.wineIntroduction;
    _detailWineButtonView.top = _detailDescribeView.bottom;
    NSArray *array = @[_wineDetailInfo.wineYear,_wineDetailInfo.grapeType,_wineDetailInfo.wineAlcohol,_wineDetailInfo.wineLevel,_wineDetailInfo.wineNetContent,_wineDetailInfo.wineOccasion,_wineDetailInfo.winesLevel.levelSwitch];
    _detailWineButtonView.titleArray = array;
    
    [_detailWineRegionImageView.detailWineRegionImageView loadImage:_wineDetailInfo.wineCityPic placeHolder:[UIImage imageNamed:@"detailWine_map_image"]];
    _detailWineRegionImageView.top = _detailWineButtonView.bottom;
    _detailWineAddressView.originAreaLabel.text = _wineDetailInfo.wineCountry;
    _detailWineAddressView.producingAreaLabel.text = _wineDetailInfo.wineCity;
    _detailWineAddressView.foreignBusinessLabel.text = _wineDetailInfo.wineForeignMerchant;
    _detailWineAddressView.importMerchant.text = _wineDetailInfo.wineImported;
    _detailWineAddressView.agentLabel.text = _wineDetailInfo.wineAgent;
    _detailWineAddressView.top = _detailWineRegionImageView.bottom;
    [self setDetailScrollViewSize:_detailWineAddressView.bottom];
    // NSString *str = @"http://y1.eoews.com/assets/ringtones/2012/6/29/36195/mx8an3zgp2k4s5aywkr7wkqtqj0dh1vxcvii287a.mp3";
    if (_wineDetailInfo.wineSoundUrl.length !=0) {
        NSString *str = _wineDetailInfo.wineSoundUrl;
        NSURL *url = [NSURL URLWithString:str];
        _streamer = [[AudioStreamer alloc] initWithURL:url];
        _voiceImageView.hidden = NO;
    } else {
        _voiceImageView.hidden = YES;
    }
    if ([_wineDetailInfo.wineCollectState isEqualToString:@"1"]) {
        _wineCollectionButton.selected = NO;
    } else if ([_wineDetailInfo.wineCollectState isEqualToString:@"0"]){
        _wineCollectionButton.selected = YES;
    }
}

#pragma mark - setFont

- (void)setSuiteTemperatureWith:(NSString *)temperature
{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:temperature];
    UIFont *font = [UIFont systemFontOfSize:11];
    [str addAttribute:(NSString *)kCTFontAttributeName
                value:(id)CFBridgingRelease(CTFontCreateWithName((CFStringRef)font.fontName,
                                                                 font.pointSize*2,
                                                                 NULL))
                range:NSMakeRange(temperature.length - 1, 1)];
    _picView.wineTemperarureLabel.attributedText = str;
}

#pragma mark - AddForeignName

- (void)AddForeignName:(NSString *)foreignName
{
    _wineForeignName.textAlignment = NSTextAlignmentCenter;
    _wineForeignName.text = foreignName;
   CGFloat labelWidth = [UILabel layoutLabelWidthWithText:_wineForeignName.text font:[UIFont systemFontOfSize:18] height:21];
    if (labelWidth>230) {
      // [UIView animat]
        _wineForeignName.width = labelWidth;
        [self foreignLabelAnimation:_wineForeignName];
    }
}

- (void)foreignLabelAnimation:(UILabel *)label;
{
    [UIView animateWithDuration:15 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        label.left = -label.width;
    } completion:^(BOOL finished) {
        label.left = label.width;
        [self foreignLabelAnimation:label];
    }];
}

- (void)setDetailScrollViewSize:(CGFloat)height
{
    _detailScrollView.contentSize = CGSizeMake(320, height);
    _bgImageView.height = height - 240;
}

#pragma mark - DetailDescribeViewDelegate

- (void)refreshUI:(CGFloat)addHeight
{
    _detailWineButtonView.top = _detailDescribeView.bottom;
    _detailWineRegionImageView.top = _detailWineButtonView.bottom;
    _detailWineAddressView.top = _detailWineRegionImageView.bottom;
    [self setDetailScrollViewSize:_detailWineAddressView.bottom];
   // [self initView];
}

#pragma mark - addScanRequest Methods
-(void) addScanRequest
{

    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setValue:DATA_ENV.userid forKey:@"appid"];
    [dic setValue:_wineID forKey:@"goodsid"];
    [UserScanAddRequest requestWithParameters:dic withIndicatorView:nil withCancelSubject:nil onRequestFinished:^(ITTBaseDataRequest *request) {
    }];
    
}

#pragma mark - Request Methods

- (void)wineDetailInfoRequest
{
    
    if (_wineID == nil) {
        return;
    }
    [self.view addSubview:_requestBackView];
    [self.view bringSubviewToFront:_requestBackView];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setValue:_wineID forKey:@"id"];
    if (DATA_ENV.userid) {
        [parameters setValue:DATA_ENV.userid forKeyPath:@"appId"];
    } else{
        [parameters setValue:@"0" forKeyPath:@"appId"];
    }
    LoadingView *loadingView = [LoadingView loadFromXib];
    if (isIOS7()) {
        
        loadingView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    } else {
    
        loadingView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    }
    
    [self.view addSubview:loadingView];
    [wineDetailRequest requestWithParameters:parameters
                           withIndicatorView:nil
                           withCancelSubject:nil
                              onRequestStart:nil onRequestFinished:^(ITTBaseDataRequest *request) {
                                  [_requestBackView removeFromSuperview];
                                  _wineDetailInfo = [request.handleredResult objectForKey:@"WineDetailInfo"];
                                  
                                  if ([request.handleredResult[@"result"] intValue] == 0) {
                                      
                                      _isLoadData = YES;

                                      [self updateView];
                                  } else {
                                      [self setDetailScrollViewSize:_detailWineAddressView.bottom];

                                  }
                                  [loadingView removeFromSuperview];
                                  
                                //  NSLog(@"requestSuccess tag :1 height: %f y: %f",_detailScrollView.contentSize.height,_detailScrollView.frame.origin.y);

                              } onRequestCanceled:nil
                             onRequestFailed:^(ITTBaseDataRequest *request) {
                                 [loadingView removeFromSuperview];

                                // [_requestBackView removeFromSuperview];
                               //  [UIAlertView popupAlertByDelegate:self title:@"提示" message:@"网络连接失败"];
                                 [self setDetailScrollViewSize:_detailWineAddressView.bottom];
                                 _dbv.height = _detailWineAddressView.bottom-240;

                             }];
    NSDictionary *dict = @{@"appId": DATA_ENV.userid};
    [QueryWineRequest requestWithParameters:dict withIndicatorView:nil withCancelSubject:nil onRequestStart:nil onRequestFinished:^(ITTBaseDataRequest *request) {
        if (![request.handleredResult[@"result"] isEqualToString:@"0"]) {
            _isAddWine = YES;
        } else {
            _isAddWine = NO;
        }
    } onRequestCanceled:nil onRequestFailed:^(ITTBaseDataRequest *request) {
        
    }];
    
}

- (void)getWineAntifakeListRequest
{
    LoadingView *loadingView = [LoadingView loadFromXib];
    if (isIOS7()) {
        
        loadingView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
        
    } else {
    
        loadingView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    }
    
    [self.view addSubview:loadingView];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setValue:_wineID forKey:@"id"];
    [wineAntiFakeRequest requestWithParameters:parameters
                             withIndicatorView:nil
                             withCancelSubject:nil
                                onRequestStart:nil onRequestFinished:^(ITTBaseDataRequest *request) {
                                    [loadingView removeFromSuperview];
                                    if ([request isSuccess]) {
                                        
                                        
                                        [_originView removeFromSuperview];
                                        _antiFakeImages = request.handleredResult[@"wineAntiFakeRequest"];
                                        
                                        _originView = [OriginView loadFromXib];
                                        _originView.delegate = self;

                                        [_originView layoutOriginViewWithArray:_antiFakeImages];
                                        [_detailScrollView addSubview:_originView];
                                        _originView.top = 290;
                                        if (_antiFakeImages.count == 0) {
                                           // _detailScrollView.contentSize = CGSizeMake(320, 300 + _originView.height+51);
                                            [self setDetailScrollViewSize:300 + _originView.height+51];

                                        } else {
                                       // _detailScrollView.contentSize = CGSizeMake(320, 300 + _originView.height);
                                            [self setDetailScrollViewSize:300 + _originView.height];
                                        }
                                    }

                                } onRequestCanceled:nil
                               onRequestFailed:^(ITTBaseDataRequest *request) {
                                   [loadingView removeFromSuperview];

                               }];
}

- (void)getVegetableRequest
{
    LoadingView *loadingView = [LoadingView loadFromXib];
    if (isIOS7()) {
        
        loadingView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
        
    } else {
    
        loadingView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
        
    }
    
    [self.view addSubview:loadingView];
   // [self.view addSubview:_requestBackView];
   // [self.view bringSubviewToFront:_requestBackView];
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    [parameters setValue:_wineID forKey:@"id"];
    [vegetableRequest requestWithParameters:parameters
                             withIndicatorView:nil
                             withCancelSubject:nil
                                onRequestStart:nil onRequestFinished:^(ITTBaseDataRequest *request) {
                                   // [_requestBackView removeFromSuperview];
                                    [loadingView removeFromSuperview];
                                    
                                    if ([request isSuccess]) {
                                    //    [_vegetableView removeFromSuperview];
                                        
                                        _vegetableImages = request.handleredResult[@"vegetableRequest"];
                                        _footTitle = request.handleredResult[@"footTitle"];
                                        _vegetableView = [VegetableView loadFromXib];
                                        _vegetableView.delegate = self;
                                        [_vegetableView layoutOriginViewWithArray:_vegetableImages andTitle:_footTitle ];
                                        [_detailScrollView addSubview:_vegetableView];
                                        _vegetableView.top = 290;
                                        _detailScrollView.contentSize = CGSizeMake(320, 300 + _vegetableView.height);
                                   //     NSLog(@"requestSuccess tag :2 height: %f y: %f",_detailScrollView.contentSize.height,_detailScrollView.frame.origin.y);
                                    }
                                } onRequestCanceled:nil
                               onRequestFailed:^(ITTBaseDataRequest *request) {
                                   [loadingView removeFromSuperview];
                                  // [_requestBackView removeFromSuperview];
                              //     [UIAlertView popupAlertByDelegate:self title:@"提示" message:@"网络连接失败"];
                             //      NSLog(@"requestfailed tag :2 height: %f y: %f",_detailScrollView.contentSize.height,_detailScrollView.frame.origin.y);
                               }];
    
}
#pragma mark - buttonClick
- (IBAction)backButtonClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)voiceButtonClick:(id)sender
{
    if (_wineDetailInfo.wineSoundUrl.length == 0) {
        return;
    }
    if ([_streamer isPlaying]) {
        return;
    }

    if (![DATA_ENV.voiceOn boolValue]) {
        [_streamer start];
      //  _animationDuration = 0;
    } else {
     //   _isAnimation = NO;
        _animationDuration = 10;
    }
    _isAnimation = YES;

}

- (void)timeUp
{
    if (!_isAnimation) {
        return;
    }
    switch (_count%3) {
        case 0:
            _voiceImageView.image = [UIImage imageNamed:@"detail_voice1_image"];
            break;
        case 1:
            _voiceImageView.image = [UIImage imageNamed:@"detail_voice2_image"];
            break;
        case 2:
            _voiceImageView.image = [UIImage imageNamed:@"detail_voice3_image"];
            break;
            
        default:
            break;
    }
    _count ++;
    if (_animationDuration==0) {
        if (_streamer.state == AS_STOPPING) {
            
            [self performSelector:@selector(stopStreamer) withObject:self afterDelay:3];
            _animationDuration = _count + 6;
        }
        
    } else if (_animationDuration == _count){
        [self performSelector:@selector(stopStreamer) withObject:self afterDelay:0];
        
    }
    // _voiceImageView.image =
}

- (void)stopStreamer
{
   // [_timer invalidate];
   // NSLog(@"声音播放结束");

    _count = 0;
    _isAnimation = NO;
    _voiceImageView.image = [UIImage imageNamed:@"detail_voice3_image"];
}

- (IBAction)toolBarButtonClick:(id)sender
{
    
    UIButton *button = (UIButton *)sender;
    if (button.tag == 1){
        
        //收藏
        if (_wineDetailInfo) {
            if (!_wineCollectionButton.selected) {
                if (DATA_ENV.isLocalOnline) {
                    [self collectWine];
                } else {
                    [self presentLoginViewController];
                    _viewType = 0;
                }
            } else {
                [self delegateCollectWine];
            }
        }
        
        
    } else if (button.tag == 2){
        
        //购买
        WineShopListViewController *shop = [[WineShopListViewController alloc]init];
        shop.wineName = _wineName;
        shop.wineID = _wineID;
        [self.navigationController pushViewController:shop animated:YES];
    } else if (button.tag == 3){
        if (DATA_ENV.isLocalOnline) {
            [self goControlWine];
        } else {
            [self presentLoginViewController];
            _viewType = 1;
        }

    }
        
}

#pragma mark - isLogin

#pragma mark - PresentLoginViewController

- (void)presentLoginViewController
{
    CommomAlertView *alertView = [CommomAlertView loadFromXib];
    alertView.frame = CGRectMake(0, 0, 320, self.view.bounds.size.height);
    alertView.delegate = self;
    [[AppDelegate getAppDelegate].window addSubview:alertView];
    //    [self.view addSubview:alertView];
    //  [CommomAlertView popAlertInViewController:self];
}

- (void)CommonAlertViewClickedWithTag:(NSInteger)tag
{
    if (tag == 1) {
        LoginViewController *nwvc = [[LoginViewController alloc]init];
        nwvc.delegate = self;
        nwvc.isDetailWine = YES;
        UINavigationController *nvc = [[UINavigationController alloc]initWithRootViewController:nwvc];
        [self presentViewController:nvc animated:YES completion:^{
            
        }];
    }
}

- (void)goControlWine
{
    //加入酒柜
    if (DATA_ENV.isBindingDevice == NO) {
        bandingAlertView *alertView = [bandingAlertView loadFromXib];
        alertView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
        alertView.delegate = self;
        [self.view addSubview:alertView];
    } else
    {
      //  [NSThread sleepForTimeInterval:3];
      //  NSInteger statues = [[WineManager shareWineManager] getDeviceStatues];
        if (!DATA_ENV.isDeviceOneline) {
            _tipView.frame = CGRectMake(205/2, self.view.bounds.size.height-49-40, 115, 30);
            _tipView.alpha = 0.8;
            _tipLabel.text = @"设备不可用";
            [self.view addSubview:_tipView];
            [self performSelector:@selector(removeTipes) withObject:nil afterDelay:1];
           // return;
        } else
        {
            DATA_ENV.isAddWine = YES;
            DATA_ENV.wineID = _wineID;
            DATA_ENV.wineName = _wineName;
            DATA_ENV.wineType = _wineDetailInfo.wineType;
            if (_isAddWine) {
                NSDictionary *dict = @{@"goodId": _wineID,
                                       @"appId" : DATA_ENV.userid,
                                       @"type"  : @"0"
                                       };
                [AddWineRequest requestWithParameters:dict withIndicatorView:nil withCancelSubject:nil onRequestStart:nil onRequestFinished:^(ITTBaseDataRequest *request) {
                    
                } onRequestCanceled:nil onRequestFailed:^(ITTBaseDataRequest *request) {
                    
                }];
            } else {
                NSDictionary *dict = @{@"goodId": _wineID,
                                       @"appId" : DATA_ENV.userid,
                                       @"type"  : @"0"
                                       };
                [ModifyWineRequest requestWithParameters:dict withIndicatorView:nil withCancelSubject:nil onRequestStart:nil onRequestFinished:^(ITTBaseDataRequest *request) {
                    
                } onRequestCanceled:nil onRequestFailed:^(ITTBaseDataRequest *request) {
                    
                }];
            }
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    }
}

- (void)bandingAlertViewClick:(NSInteger)tag
{
    if (tag == 0) {
        return;
    } else if (tag == 1) {
        DATA_ENV.isAddWine = YES;
        DATA_ENV.wineID = _wineID;
        DATA_ENV.wineName = _wineName;
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

- (void)delegateCollectWine
{
    LoadingView *loadingView = [LoadingView loadFromXib];
    if (isIOS7()) {
        
        loadingView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    } else {
        
        loadingView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    }
    
    // loadingView.frame = CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height);
    
    [self.view addSubview:loadingView];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setValue:DATA_ENV.userid forKey:@"appId"];
    [dic setValue:_wineID forKey:@"goodsId"];
    //            [dic setValue:_wineDetailInfo.wineMerchantsId forKey:@"merchantsId"];//酒商id
 //   [dic setValue:@"1" forKey:@"merchantsId"];//酒商id
    
    
    [DelegateCollectionRequest requestWithParameters:dic withIndicatorView:nil withCancelSubject:nil onRequestStart:^(ITTBaseDataRequest *request) {
        
    } onRequestFinished:^(ITTBaseDataRequest *request) {
        [loadingView removeFromSuperview];
        _wineCollectionButton.selected = NO;
        _tipView.frame = CGRectMake(205/2, self.view.bounds.size.height-49-40, 115, 30);
        _tipView.alpha = 0.8;
        _tipLabel.text = @"取消收藏成功";
        [self.view addSubview:_tipView];
        [self performSelector:@selector(removeTipes) withObject:nil afterDelay:1];
        //        _tipView.hidden = YES;
        //
        //        _tipView.hidden = NO;
        //        [self.view bringSubviewToFront:_tipView];
        
      //  NSLog(@"0000000000###%@",request.handleredResult[@"message"]);
    } onRequestCanceled:^(ITTBaseDataRequest *request) {
        
    } onRequestFailed:^(ITTBaseDataRequest *request) {
        
        [loadingView removeFromSuperview];
        
    }];
}
                 
- (void)collectWine
{
    LoadingView *loadingView = [LoadingView loadFromXib];
    if (isIOS7()) {
        
        loadingView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    } else {
        
        loadingView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    }

   // loadingView.frame = CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height);
    
    [self.view addSubview:loadingView];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setValue:DATA_ENV.userid forKey:@"appId"];
    [dic setValue:_wineID forKey:@"goodsId"];
    //            [dic setValue:_wineDetailInfo.wineMerchantsId forKey:@"merchantsId"];//酒商id
    [dic setValue:@"1" forKey:@"merchantsId"];//酒商id
    
    
    [FavouriteWineRequest requestWithParameters:dic withIndicatorView:nil withCancelSubject:nil onRequestStart:^(ITTBaseDataRequest *request) {
        
    } onRequestFinished:^(ITTBaseDataRequest *request) {
        [loadingView removeFromSuperview];
        _wineCollectionButton.selected = YES;
        _tipLabel.text = @"收藏成功";
        _tipView.frame = CGRectMake(110, self.view.bounds.size.height-49-40, 100, 30);
        _tipView.alpha = 0.8;
        [self.view addSubview:_tipView];
        [self performSelector:@selector(removeTipes) withObject:nil afterDelay:1];
    } onRequestCanceled:^(ITTBaseDataRequest *request) {
        
    } onRequestFailed:^(ITTBaseDataRequest *request) {
        
        [loadingView removeFromSuperview];
        
    }];
}

- (void)removeTipes
{
    [UIView animateWithDuration:0.5 animations:^{
        _tipView.alpha = 0;
    } completion:^(BOOL finished) {
        [_tipView removeFromSuperview];

    }];
}

- (void)loginSuccess
{
    if (_viewType == 0) {
        [self collectWine];
    } else if (_viewType == 1){
      //  [NSThread sleepForTimeInterval:2];
      //  [self goControlWine];
    }
}
#pragma mark - detailSelectButtonViewDelegate

-(void)selectButtonClick:(NSInteger)tag
{
    
    if (tag == 1) {
        
//        [_detailScrollView setContentOffset:CGPointMake(0, 0)];
        [_vegetableView removeFromSuperview];
        [_detailScrollView addSubview:_detailDescribeView];
        [_detailScrollView addSubview:_detailWineButtonView];
        [_detailScrollView addSubview:_detailWineRegionImageView];
        [_detailScrollView addSubview:_detailWineAddressView];
        [_originView removeFromSuperview];
        if (!_wineDetailInfo) {
            
            [self wineDetailInfoRequest];
            
        } else {
           // [self updateView];
            [self setDetailScrollViewSize:_detailWineAddressView.bottom];
            
        }
        
    } else if (tag == 3) {
        
        [self removeBaseInfoView];
        [_vegetableView removeFromSuperview];
        if (!_antiFakeImages && _antiFakeImages.count < 1)
        {
            [self getWineAntifakeListRequest];
            
        } else {
            [_vegetableView removeFromSuperview];
            [self removeBaseInfoView];
            [_detailScrollView addSubview:_originView];
            _originView.top = 290;
            [self setDetailScrollViewSize:300 + _originView.height+51];
            
        }

    } else if (tag == 2){
        
        [self removeBaseInfoView];
        [_originView removeFromSuperview];

        if (!_vegetableImages && _vegetableImages.count < 1) {
            
            [self getVegetableRequest];
            
        } else {
            
            [_detailScrollView addSubview:_vegetableView];
            _vegetableView.top = 290;
            [self setDetailScrollViewSize:320 + _vegetableView.height];
        }
        
    } else if (tag == 4){
        
        [_originView removeFromSuperview];
        [self removeBaseInfoView];
        [_originView removeFromSuperview];
        
    }
    
}

#pragma mark - detailWineButtonViewDelegate

- (void)PopViewButtonSelextedWithTag:(NSInteger)tag
{
    if (tag == 1) {
        _winePopView.hidden = NO;
        if (_wineDetailInfo.wineGrapeClass.grapeName) {
            [_winePopImageView loadImage:_wineDetailInfo.wineGrapeClass.grapePic placeHolder:[UIImage imageNamed:@"588x294"]];
        }
        _winePopTitleLabel.text = _wineDetailInfo.wineGrapeClass.grapeName;
        _textView.text = _wineDetailInfo.wineGrapeClass.grapeContent;
        [_contentView bringSubviewToFront:_winePopView];
    } else if (tag == 3){
        if ([_wineDetailInfo.winesLevel.levelSwitch isEqualToString:@"2"]) {
            return;
        }
        _winePopView.hidden = NO;
        if (_wineDetailInfo.winesLevel.levelPic) {
            [_winePopImageView loadImage:_wineDetailInfo.winesLevel.levelPic placeHolder:[UIImage imageNamed:@"588x294"]];
        }
        _winePopTitleLabel.text = _wineDetailInfo.winesLevel.levelName;
        _textView.text = _wineDetailInfo.winesLevel.levelContent;
       [_contentView bringSubviewToFront:_winePopView];
    }
}

- (void)removeBaseInfoView
{
    [_detailDescribeView removeFromSuperview];
    [_detailWineButtonView removeFromSuperview];
    [_detailWineRegionImageView removeFromSuperview];
    [_detailWineAddressView removeFromSuperview];
    
}

#pragma mark - levelMore

- (IBAction)levelMore:(id)sender
{
    NSRange range = {_textView.height*_index-40,_textView.height};
    [_textView scrollRangeToVisible:range];
    _index++;
}

#pragma mark - scrollViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y == 0) {
        _index = 2;
    }
}

#pragma mark - vegetableView delegate
- (void)refreshVegetableView:(CGFloat)addHeight{

    _detailScrollView.contentSize = CGSizeMake(320, 300 + addHeight);
    
}

#pragma mark - newHandArrowAnimation

- (void)newHandArrowAnimation
{
    if (_isOverAnimation) {
        return;
    }

    [UIView animateWithDuration:0.8 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        _arrowImageView.top = _arrowTop;
    } completion:^(BOOL finished) {
        if (_isDown) {
            _arrowTop = _arrowTop - 4;
        } else {
            _arrowTop = _arrowTop + 4;
        }
        _isDown = !_isDown;
        [self newHandArrowAnimation];

    }];
}

- (void)newHandLabelAnimation
{
    if (_isOverAnimation) {
        return;
    }
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        _newHandLabel.alpha = _labelAlpha;
    } completion:^(BOOL finished) {
        if (_isLabelDown) {
            _labelAlpha = 1;
        } else {
            _labelAlpha = 0;
        }
        _isLabelDown = !_isLabelDown;
        [self newHandLabelAnimation];
    }];
}

#pragma mark - newHandtaped

- (IBAction)newHandTaped:(id)sender
{    _isOverAnimation = YES;
    [_newHandView removeFromSuperview];
}

#pragma mark - OriginDelegate

- (void)largeImage:(NSInteger)tag
{
    _certificateView.hidden = NO;
    [_certificateImageView loadImage:[_antiFakeImages objectAtIndex:tag] placeHolder:[UIImage imageNamed: @"570x780"]];
}

- (IBAction)certificateButton:(id)sender
{
    _certificateView.hidden = YES;
}


@end
