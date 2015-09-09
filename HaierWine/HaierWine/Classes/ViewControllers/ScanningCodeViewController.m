//
//  ScanningCodeViewController.m
//  LingZhi
//
//  Created by boguoc on 14-2-27.
//
//

#import "ScanningCodeViewController.h"
#import "SearchWineViewController.h"
#import "AppDelegate.h"
#import "DetailWineViewController.h"
#import "PKRevealController.h"
#import "UIView+ITTAdditions.h"


#define SCANNER_WIDTH 200.0f
#define SCANNER_HEIGHT 120.0f
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface ScanningCodeViewController ()
{
    IBOutlet UILabel    *_label;
    BOOL                isScaned;
    BOOL                _isCameraLoad;
}

@property (nonatomic, strong) ZXCapture   *capture;
@property (nonatomic, strong) UILabel     *resultLabel;
@property (nonatomic, strong) UIImageView *lineView;//扫描线
@property (nonatomic, assign) BOOL        willUp;//扫描移动方向
@property (nonatomic, strong) NSTimer     *timer;//扫描线定时器

//@property (nonatomic,strong) ProductDetailInfoController *detailVc;
@end

@implementation ScanningCodeViewController{
    CGFloat scanner_X;
    CGFloat scanner_Y;
    CGRect viewFrame;
    
}

-(void)initBackgroundView{
    CGRect scannerFrame=CGRectMake(scanner_X, scanner_Y,SCANNER_WIDTH, SCANNER_HEIGHT);
    float x=scannerFrame.origin.x;
    float y=scannerFrame.origin.y;
    float width=scannerFrame.size.width;
    float height=scannerFrame.size.height;
    float mainWidth=viewFrame.size.width;
    
    /*dd*/
    
    /*dd*/
    
    UIView *upView;
    
    if (isIOS7()) {
        
        upView=[[UIView alloc]initWithFrame:CGRectMake(0, 64, mainWidth, y-64)];
        
    } else {
    
        upView=[[UIView alloc]initWithFrame:CGRectMake(0, 44, mainWidth, y-44)];
    }
  
    UIView *leftView=[[UIView alloc]initWithFrame:CGRectMake(0, y, x, height)];
    UIView *rightView=[[UIView alloc]initWithFrame:CGRectMake(x+width, y, mainWidth-x-width, height)];
    UIView *downView=[[UIView alloc]initWithFrame:CGRectMake(0, y+height, mainWidth, SCREEN_HEIGHT-y-64)];
//    UIView *downView=[[UIView alloc]initWithFrame:CGRectMake(0, y, mainWidth, SCREEN_HEIGHT-y-64)];
    
    NSArray *viewArray=[NSArray arrayWithObjects:upView,downView,leftView,rightView, nil];
    for (UIView *view in viewArray) {
        view.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5f];
        [self.view addSubview:view];
    }
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, y+height+20, mainWidth, 21)];
    label.text = @"扫描酒品条码,去酒瓶上找吧.";
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    //    UIImageView * imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    //    imageView.image = [UIImage imageNamed:@"C14.jpg"];
    //    imageView.alpha = 0.6;
//        [self.view addSubview:imageView];
}

-(void)reloadCamera
{
    isScaned = NO;

    //扫描器初始化
    self.capture = [[ZXCapture alloc] init];
    self.capture.camera = self.capture.back;
    self.capture.focusMode = AVCaptureFocusModeContinuousAutoFocus;
    self.capture.layer.frame = self.view.bounds;
    self.capture.rotation=90.0f;//可以竖屏扫描条形码
    
  //  [self.capture.captureDevice authorizationStatusForMediaType:@"AVMediaTypeVideo"];
//    if ([self.capture.captureDevice authorizationStatusForMediaType] == AVAuthorizationStatusDenied) {
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"相机" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
//        [alert show];
//       // NSLog(@"相机不可用");
//    }
    [self.view.layer addSublayer:self.capture.layer];
    if (isIOS7()) {
        
        [self.capture.layer setFrame:CGRectMake(0, 64, 320, SCREEN_HEIGHT-64)];
        
    } else {
        [self.capture.layer setFrame:CGRectMake(0, 44, 320, SCREEN_HEIGHT-44)];
    }
    
     [self initBackView];

}


//扫描线动画
-(void)lineAnimation{
    float y=self.lineView.frame.origin.y;
//    if (y<=scanner_Y) {
//        self.willUp=NO;
//    }else if(y>=scanner_Y+SCANNER_HEIGHT){
//        self.willUp=YES;
//    }
//    if(self.willUp){
//        y-=1;
//    //    self.lineView.frame=CGRectMake(scanner_X, y, SCANNER_WIDTH, 2);
//        self.lineView.frame=CGRectMake(scanner_X, y, SCANNER_WIDTH, 30);
//    }else{
//        y+=1;
//   //     self.lineView.frame=CGRectMake(scanner_X, y, SCANNER_WIDTH, 2);
//        self.lineView.frame=CGRectMake(scanner_X, y, SCANNER_WIDTH, 30);
//    }
    
    if (y<=scanner_Y+SCANNER_HEIGHT-30) {
        y+=1;
        self.lineView.frame=CGRectMake(scanner_X-7, y, SCANNER_WIDTH+14, 30);
    } else {
    self.lineView.frame=CGRectMake(scanner_X-7, scanner_Y-30, SCANNER_WIDTH+14, 30);
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.revealController.recognizesPanningOnFrontView = NO;
    _isCameraLoad = NO;
    if ([_formWhere isEqualToString:@"1"]) {
        DATA_ENV.HereHerestep2 = YES;
    }
    
}

-(void)initBackView{

    //坐标初始化
    CGRect frame=self.view.frame;
    //如果是ipad，横屏，交换坐标
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        viewFrame=CGRectMake(frame.origin.y, frame.origin.x, frame.size.height, frame.size.width);
    }else{
        viewFrame=self.view.frame;
    }
    CGPoint centerPoint=CGPointMake(viewFrame.size.width/2, viewFrame.size.height/2);
    //扫描框的x、y坐标
    scanner_X=centerPoint.x-(SCANNER_WIDTH/2);
    // scanner_Y=centerPoint.y-(SCANNER_WIDTH/2);
    scanner_Y=centerPoint.y-(SCANNER_HEIGHT/2);
    
    //半透明背景初始化
    [self initBackgroundView];
    //扫描框
    UIImageView *borderView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"scan_view_bar3.png"]];
    //  borderView.frame=CGRectMake(scanner_X-5, scanner_Y-5, SCANNER_WIDTH+10, SCANNER_WIDTH+10);
    //  borderView.frame=CGRectMake(scanner_X-5, scanner_Y-5, SCANNER_WIDTH+10, SCANNER_HEIGHT+10);
    borderView.frame=CGRectMake(scanner_X-3, scanner_Y-3, SCANNER_WIDTH+6, SCANNER_HEIGHT+6);
    [self.view addSubview:borderView];
    //扫描线
    self.lineView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"scan_scan_line"]];
    self.lineView.frame=CGRectMake(scanner_X-7, scanner_Y-30, SCANNER_WIDTH+14, 30);
    [self.view addSubview:self.lineView];
    self.timer=[NSTimer scheduledTimerWithTimeInterval:0.02f target:self selector:@selector(lineAnimation) userInfo:nil repeats:YES];
    
    
    //菜单
    float viewHeight=viewFrame.size.height;
    float viewWidth=viewFrame.size.width;
    UIView *menuView=[[UIView alloc]initWithFrame:CGRectMake(0, viewHeight-150, viewWidth, 100)];
    menuView.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.0f];
    [self.view addSubview:menuView];
    
    self.resultLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 30, viewWidth-20, 40)];
    //    self.resultLabel.backgroundColor=[UIColor grayColor];
    [menuView addSubview:self.resultLabel];
    self.resultLabel.hidden = YES;
    self.resultLabel.backgroundColor = [UIColor clearColor];
    self.resultLabel.textColor = [UIColor whiteColor];
    
    //    UIButton *submitBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    //    submitBtn.frame=CGRectMake(viewWidth-110, 50, 100, 40);
    //    [submitBtn setTitle:@"确定" forState:UIControlStateNormal];
    //    [submitBtn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    //    [submitBtn addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    //    [menuView addSubview:submitBtn];
    
}

-(void)clear{
    self.resultLabel.text=@"";
}

- (void)viewWillAppear:(BOOL)animated {
   
    [super viewWillAppear:animated];
    isScaned = NO;
    
//    if (!_isCameraLoad) {
        _isCameraLoad = YES;
        [self reloadCamera];
        self.capture.delegate = self;
        [self.timer setFireDate:[NSDate distantPast]];
//    } else {
//        self.timer=[NSTimer scheduledTimerWithTimeInterval:0.02f target:self selector:@selector(lineAnimation) userInfo:nil repeats:YES];
//        self.lineView.hidden = NO;
//        [self.timer setFireDate:[NSDate distantPast]];
//
//    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.capture.delegate = nil;
    self.lineView.hidden = YES;
    [self.timer invalidate];

}

-(void)viewDidDisappear:(BOOL)animated{
    
    self.capture = nil;//9.17

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(NSUInteger)supportedInterfaceOrientations {
	
	// iPhone only
	if( [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone )
		return UIInterfaceOrientationMaskPortrait;
	
	// iPad only
	return UIInterfaceOrientationMaskLandscape;
}

// Supported orientations. Customize it for your own needs
// Only valid on iOS 4 / 5. NOT VALID for iOS 6.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	// iPhone only
	if( [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone )
		return UIInterfaceOrientationIsPortrait(interfaceOrientation);
	
	// iPad only
	// iPhone only
	return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

#pragma mark -ZXCaptureDelegate

-(void)captureResult:(ZXCapture *)capture result:(ZXResult *)result{
    
    
//    [self.resultLabel performSelectorOnMainThread:@selector(setText:) withObject:result.text waitUntilDone:YES];
    if (!isScaned) {
        NSString * sku = nil;
        isScaned = !isScaned;
        if ([result.text length] == 13) {
            sku = result.text;
            self.lineView.hidden = YES;
            [self barcodeRequest:sku];
        }else{
            NSArray * array = [result.text componentsSeparatedByString:@"/"];
            sku = (NSString *)[array lastObject];

        }
      //  NSLog(@"sku = %@",sku);
    }
    
}


#pragma mark button Methods
- (IBAction)backToPreviewAction:(id)sender {

[self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:0] animated:YES];
}

-(IBAction)searchBtnClick:(id)sender
{
    SearchWineViewController *searchVC = [[SearchWineViewController alloc]init];
    [self.navigationController pushViewController:searchVC animated:NO];
}

#pragma mark - barcodeRequest method
-(void)barcodeRequest:(NSString *)code
{
    LoadingView *loadingView = [LoadingView loadFromXib];
    
    if (isIOS7()) {
        
        loadingView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
        
    } else {
    
        loadingView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    }
    
    [self.view addSubview:loadingView];
    
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
    [dic setValue:code forKey:@"codekey"];
    [dic setValue:DATA_ENV.userid forKey:@"appId"];
  //  NSLog(@"%@",DATA_ENV.userid);
    [BarcodeRequest requestWithParameters:dic
                        withIndicatorView:nil
                        withCancelSubject:nil
                           onRequestStart:nil
                        onRequestFinished:^(ITTBaseDataRequest *request) {
                            [loadingView removeFromSuperview];
                            if ([request.handleredResult[@"result"] isEqualToString:@"1"]) {
                                
                                //返回数据为空
                                if ([_formWhere isEqualToString:@"0"]) {
                                    //首页
                                //    [UIAlertView popupAlertByDelegate:self title:nil message:@"抱歉!未扫描到酒品\n是否继续" cancel:@"取消" others:@"确定"];
                                    
                                    ScanAlertView *alertView = [ScanAlertView loadFromXib];
                                    alertView.frame = CGRectMake(0, 0, 320, self.view.bounds.size.height);
                                    alertView.type = ScanAlertTypeFromHomePage;
                                    alertView.delegate = self;
                                    [self.view addSubview:alertView];
                                //    [[AppDelegate getAppDelegate].window addSubview:alertView];
                                    
                                } else {
                                // 控酒页
                                    
                                //    [UIAlertView popupAlertByDelegate:self title:nil message:@"抱歉!未扫描到酒品\n你可以自行控酒" cancel:@"取消" others:@"确定"];
                                    ScanAlertView *alertView = [ScanAlertView loadFromXib];
                                    alertView.frame = CGRectMake(0, 0, 320, self.view.bounds.size.height);
                                    alertView.type = ScanAlertTypeFromControlWine;
                                    alertView.delegate = self;
                                    [self.view addSubview:alertView];
                                 //   [[AppDelegate getAppDelegate].window addSubview:alertView];
                                    
                                }
                                
                                
                            } else {
                                isScaned = NO;
                                DetailWineViewController *detail = [[DetailWineViewController alloc]init];
                                detail.wineID = request.handleredResult[@"data"][@"id"];
                                [self.navigationController pushViewController:detail animated:YES];
                                
                            }
                            
                        } onRequestCanceled:nil onRequestFailed:^(ITTBaseDataRequest *request) {
                            [loadingView removeFromSuperview];
                            self.lineView.hidden = NO;
                        //    isScaned = NO;
                        }];
    
}
#pragma mark - alertView delegate
/*
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if ([_formWhere isEqualToString:@"0"]) {
        //首页
        if (buttonIndex == 0) {
            
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            isScaned = NO;
            self.lineView.hidden = NO;
        }
    } else {
    //控酒页
        if (buttonIndex == 0) {
            
            [self.navigationController popViewControllerAnimated:YES];
            
        } else {
            [_delegate showWineControl];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    
}
 */
#pragma mark - scan delegate
-(void)ScanAlertViewClickedWithTag:(NSInteger)tag{

    if ([_formWhere isEqualToString:@"0"]) {
        //首页
        if (tag == 0) {
            //取消
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            isScaned = NO;
            self.lineView.hidden = NO;
        }
    } else {
        //控酒页
        if (tag == 0) {
            
            
            [self.navigationController popViewControllerAnimated:YES];
            
        } else {
            [_delegate showWineControl];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}
@end
