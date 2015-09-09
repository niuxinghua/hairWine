//
//  NewWhiteBoardViewController.m
//  HaierWine
//
//  Created by david on 14/7/28.
//
//

#import "NewWhiteBoardViewController.h"
#import "WhiteBoardModel.h"
#import "WhiteBoardTableViewCell.h"
#import <AudioToolbox/AudioToolbox.h>
#import "PKRevealController.h"


#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height
#define IOS7 [[[UIDevice currentDevice] systemVersion]floatValue]>=7
#define HaierDataCacheManager ([HaierDataCacheManager sharedManager])

@interface NewWhiteBoardViewController (){
    IBOutlet ITTXibView     *_flexibleView;
    IBOutlet UIView         *_placeHolderTextView;
    IBOutlet UIImageView    *_backPicView;
    IBOutlet UITableView    *_tableView;
    IBOutlet UIView         *_planView;
    IBOutlet UIView         *_backView;
    WhiteBoardTableViewCell *_cell;
    
    
    UIView                  *_startView;
    NSMutableArray          *_dataArray;
    NSMutableArray          *_labelHeightArray;
    NSInteger               _beforeRandom;
    SystemSoundID           _SoundID;
    
    NSInteger               _beforeSelection; //前一个点击的按钮
}

@end

@implementation NewWhiteBoardViewController

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
    self.navigationController.revealController.recognizesPanningOnFrontView = NO;
    // Do any additional setup after loading the view from its nib.
    _beforeRandom = 99;
    _beforeSelection = -1;
    _labelHeightArray = [[NSMutableArray alloc]init];
    _dataArray = [[NSMutableArray alloc]init];
    //声音播放
 //   NSString *thesoundFilePath = [[NSBundle mainBundle] pathForResource:@"Click" ofType:@"wav"]; //音乐文件路径
 //   CFURLRef thesoundURL = (__bridge CFURLRef)[NSURL fileURLWithPath:thesoundFilePath];
//    AudioServesCreateSystemSoundID(thesoundURL, &_SoundID);
    //---------------
    NSString *thesoundFilePath = [[NSBundle mainBundle] pathForResource:@"Click" ofType:@"wav"];
    NSURL *filePath = [NSURL fileURLWithPath:thesoundFilePath isDirectory:NO];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)filePath, &_SoundID);
    //声音播放
    
    
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight animated:NO];
    
    if ([HaierDataCacheManager isHaveDataWithKey:@"WhiteBoard"]) {
        
        [_dataArray addObjectsFromArray:[HaierDataCacheManager getDataWithKey:@"WhiteBoard"]];
        
    }
  //  NSLog(@"eeeeeeeeee%@",_dataArray);
    [self whiteBoardRequest];
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"whiteBoardFirstLaunch"]){
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"whiteBoardFirstLaunch"];
        
        _startView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.height, 320)];
        _startView.backgroundColor = [UIColor darkGrayColor];
        _startView.alpha = 0.8;
        /*
         UIViewAutoresizingNone                 = 0,
         UIViewAutoresizingFlexibleLeftMargin   = 1 << 0,
         UIViewAutoresizingFlexibleWidth        = 1 << 1,
         UIViewAutoresizingFlexibleRightMargin  = 1 << 2,
         UIViewAutoresizingFlexibleTopMargin    = 1 << 3,
         UIViewAutoresizingFlexibleHeight       = 1 << 4,
         UIViewAutoresizingFlexibleBottomMargin = 1 << 5

         */
        _flexibleView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin;
     //   [_flexibleView addSubview:_startView];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.height-195)/2, 80, 195, 160)];
        imageView.image = [UIImage imageNamed:@"whiteBoard_exchangePic.png"];
        [_startView addSubview:imageView];
        _startView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin;
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.height-195)/2, 258, 195, 21)];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"请将手机横过来鉴酒";
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = [UIColor clearColor];
        label.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin;
        [_startView addSubview:label];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(remove)
                                                     name:UIDeviceOrientationDidChangeNotification
                                                   object:nil];
        
    }
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _placeHolderTextView.hidden = YES;
    _backPicView.hidden = YES;
    
    
   
    
}

-(void)remove
{
    if ([[UIDevice currentDevice]orientation] == UIDeviceOrientationLandscapeLeft) {
        
        [UIView animateWithDuration:2 animations:^{
            _startView.alpha = 0;
        } completion:^(BOOL finished) {
            [_startView removeFromSuperview];
            [[NSNotificationCenter defaultCenter]removeObserver:self];
        }];
        
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [UIView animateWithDuration:2 animations:^{
        _startView.alpha = 0;
    } completion:^(BOOL finished) {
        [_startView removeFromSuperview];
    }];
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait animated:NO];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];

    if (IOS7) {

    } else {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        window.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    }

}



-(void)viewWillAppear:(BOOL)animated
{
    //适配
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault];
    
    if (IOS7) {
        
        _flexibleView.top = (SCREENHEIGHT - 320)/2;
        _flexibleView.left = -_flexibleView.top;
        _flexibleView.width = SCREENHEIGHT;

    } else {
    
//        _flexibleView.top = (SCREENHEIGHT - 320)/2-20;
//        _flexibleView.height += 20;
//        _flexibleView.left = -_flexibleView.top;
//        _flexibleView.width = SCREENHEIGHT+20;
        /*
        _flexibleView.width = SCREENHEIGHT+20;
        _flexibleView.height = 320;
        _flexibleView.left = -10;
        _flexibleView.top =-30;
         */
        
        _flexibleView.top = (SCREENHEIGHT - 320)/2;
        _flexibleView.left = -_flexibleView.top;
        _flexibleView.width = SCREENHEIGHT;
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        window.frame = CGRectMake(0, -20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height+20);
//        UIWindow *window = [UIApplication sharedApplication].keyWindow;
//        window.frame = CGRectMake(0, -20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height+20);
        

    }
    
    _flexibleView.transform = CGAffineTransformMakeRotation(M_PI/2);
    
 //   self.view.transform = CGAffineTransformMakeRotation(M_PI/2);
   // _flexibleView.backgroundColor = [UIColor redColor];
    self.view.frame = CGRectMake(-100, -100, 100, 100);
   // NSLog(@"---------------------x:%f,y:%f,width:%f,height:%f",self.view.frame.origin.x,self.view.frame.origin.y,self.view.frame.size.width,self.view.frame.size.height);
  //  self.view.backgroundColor = [UIColor yellowColor];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    
}
#pragma mark - request method
-(void)whiteBoardRequest
{
    LoadingView *loadingView = [LoadingView loadFromXib];
//    if (isIOS7()) {
//        
//        loadingView.frame = CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height);
//    } else {
//        
//        loadingView.frame = CGRectMake(0, 44, self.view.bounds.size.width, self.view.bounds.size.height);
//    }

    loadingView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    
    [self.view addSubview:loadingView];
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc]init];
    [parameter setValue:DATA_ENV.userid forKey:@"appId"];
    [WhiteBoardRequest requestWithParameters:parameter withIndicatorView:nil withCancelSubject:nil onRequestStart:nil onRequestFinished:^(ITTBaseDataRequest *request) {
        
        [loadingView removeFromSuperview];
        if ([request isSuccess]) {
            
            [_flexibleView addSubview:_startView];
            _placeHolderTextView.hidden = NO;
            _backPicView.hidden = NO;
            [_dataArray removeAllObjects];
            NSArray *array = request.handleredResult[@"dataArray"];
       //     _dataArray = request.handleredResult[@"dataArray"];
            for (int i = 0; i < array.count; i++) {
                
                WhiteBoardModel *model = (WhiteBoardModel *)array[i];
                _labelHeightArray = [[NSMutableArray alloc]init];
                for (int j = 0; j < model.whiteBoardPlanList.count; j++) {
                    
                    NSString *str = model.whiteBoardPlanList[j];
                    CGSize size = [str sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(262.0f, 9999.0f) lineBreakMode:NSLineBreakByCharWrapping];
                    NSNumber *height = [NSNumber numberWithFloat:size.height];
                    [_labelHeightArray addObject:height];
                }
                model.whiteBoardTextHeight = _labelHeightArray;
                [_dataArray addObject:model];
                
                [HaierDataCacheManager addData:_dataArray WithKey:@"WhiteBoard"];
            }
            [_tableView reloadData];
            
        }
        
        
    } onRequestCanceled:nil onRequestFailed:^(ITTBaseDataRequest *request) {
        [loadingView removeFromSuperview];
     //   [UIAlertView popupAlertByDelegate:self title:@"通知" message:@"连接网络失败"];
        [_flexibleView addSubview:_startView];
        _placeHolderTextView.hidden = NO;
        _backPicView.hidden = NO;
    }];
}
#pragma mark - tableView delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"WhiteBoardTableViewCellId";
    WhiteBoardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [WhiteBoardTableViewCell cellFromNib];
     //   NSLog(@"WhiteBoardTableViewCellWhiteBoardTableViewCell");
    }
    WhiteBoardModel *model = _dataArray[indexPath.row];
    cell.colorNameLabel.text = model.whiteBoardColorName;
    cell.colorView.backgroundColor = [self hexStringToColor:model.whiteBoardColorCode];
    cell.colorRectView.backgroundColor = [self hexStringToColor:model.whiteBoardColorCode];
    
    if (model.isChecked) {
        //被选择
        cell.colorNameLabel.textColor = [UIColor whiteColor];
        cell.colorImageView.alpha = 1;
        cell.animationView.frame = CGRectMake(1, 0, 138, 62);
        cell.colorRectView.frame = CGRectMake(30, 1, 107, 58);
        
    } else {
        //没被选择
        cell.colorNameLabel.textColor = [UIColor blackColor];
        cell.colorImageView.alpha = 0;
        cell.animationView.frame = CGRectMake(20, 0, 138, 62);
        cell.colorRectView.frame = CGRectMake(30, 1, 0, 58);


    }
    return cell;
}

#pragma mark - color change
-(UIColor *) hexStringToColor: (NSString *) stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    
    if ([cString length] < 6) return [UIColor blackColor];
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor blackColor];
    
    // Separate into r, g, b substrings
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //播放声音
    
    if (![DATA_ENV.voiceOn boolValue]) {
        AudioServicesPlaySystemSound(_SoundID);
    }
   
    if (_beforeSelection == indexPath.row) {
        [self tableView:_tableView didDeselectRowAtIndexPath:indexPath];
        _placeHolderTextView.hidden = NO;
        _backPicView.hidden = NO;
        _planView.hidden = YES;
        _beforeSelection = -1;
        return;
    }
    
    _beforeSelection = indexPath.row;
    
    //NSLog(@"选择 %d",indexPath.row);
    [_planView removeAllSubviews];
    _planView.hidden = NO;
    _placeHolderTextView.hidden = YES;
    _backPicView.hidden = YES;
    
    WhiteBoardModel *model = _dataArray[indexPath.row];
    model.isChecked = YES;
    WhiteBoardTableViewCell *cell = (WhiteBoardTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    _cell = cell;
    
    cell.colorNameLabel.textColor = [UIColor whiteColor];
    
    
    [UIView animateWithDuration:0.3 animations:^{
        cell.colorImageView.alpha = 1;
        cell.animationView.frame = CGRectMake(1, 0, 138, 62);
        cell.colorRectView.frame = CGRectMake(30, 1, 107, 58);

    }];
    
    //9.10
    /*
    for (int i = 0; i < model.whiteBoardPlanList.count; i++) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, i*(22+5), 262, 22)];
        label.font = [UIFont systemFontOfSize:16];
        label.textColor = [UIColor colorWithHue:164/255.0f saturation:42/255.0f  brightness:80/255.0f  alpha:1];
        label.text = model.whiteBoardPlanList[i];
        label.textColor = [self hexStringToColor:model.whiteBoardColorCode];
        [_planView addSubview:label];
    }
    */
    
    if (model.whiteBoardPlanList.count != 0) {
        
        int randomNum = arc4random()%model.whiteBoardPlanList.count;
        while (randomNum == _beforeRandom && model.whiteBoardPlanList.count != 1) {
            
            randomNum = arc4random()%model.whiteBoardPlanList.count;
        }
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 262, 22)];
        label.numberOfLines = 0;
        
        //CGSize size = [model.whiteBoardPlanList[randomNum] sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(262.0f, 9999.0f) lineBreakMode:NSLineBreakByCharWrapping];
      
        NSNumber * height = (NSNumber *)model.whiteBoardTextHeight[randomNum];
        label.frame = CGRectMake(0, 0, 262, height.floatValue);
        
        label.font = [UIFont systemFontOfSize:16];
        label.textColor = [UIColor colorWithHue:164/255.0f saturation:42/255.0f  brightness:80/255.0f  alpha:1];
        
        label.text = model.whiteBoardPlanList[randomNum];
        
        label.textColor = [self hexStringToColor:model.whiteBoardColorCode];
        
        _beforeRandom = randomNum;
        
        [_planView addSubview:label];
        
    }
    
}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
   // NSLog(@"未选择 %d",indexPath.row);

    [_planView removeAllSubviews];
    WhiteBoardTableViewCell *cell = (WhiteBoardTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    /**/
    WhiteBoardModel *model = _dataArray[indexPath.row];
    model.isChecked = NO;
    
    cell.colorNameLabel.textColor = [UIColor blackColor];
    
    [UIView animateWithDuration:0.3 animations:^{
        cell.colorImageView.alpha = 0;
        cell.animationView.frame = CGRectMake(20, 0, 138, 62);
        cell.colorRectView.frame = CGRectMake(30, 1, 0, 58);
    }];
    
}
-(IBAction)clickWhitePlace:(id)sender
{
    _cell.colorNameLabel.textColor = [UIColor blackColor];
    _beforeSelection = -1;
    /**/
    
    [UIView animateWithDuration:0.3 animations:^{
        _cell.animationView.frame = CGRectMake(20, 0, 138, 62);
        _cell.colorRectView.frame = CGRectMake(30, 1, 0, 58);
        _cell.colorImageView.alpha = 0;
    }];
     
    _placeHolderTextView.hidden = NO;
    _backPicView.hidden = NO;
    _planView.hidden = YES;
}
@end
