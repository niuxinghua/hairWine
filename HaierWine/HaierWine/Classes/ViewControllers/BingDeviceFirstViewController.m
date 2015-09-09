//
//  BingDeviceFirstViewController.m
//  HaierWine
//
//  Created by isoftstone on 14-7-28.
//
//

#import "BingDeviceFirstViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreText/CoreText.h>
#import "BingDeviceNextViewController.h"
#import "WineManager.h"
#import "WebViewController.h"

@interface BingDeviceFirstViewController ()
{
    IBOutlet UIImageView *_bgImageView;
    
    IBOutlet UILabel *_bingLabel1;
    
    IBOutlet UILabel *_bingLabel2;
    
    IBOutlet UILabel *_bingLabel3;
    IBOutlet UILabel *_bingLabel4;
    
    BOOL _isOpenUSDK;
    BOOL _isPush;
    WineManager       *_wineManager;
}

@end

@implementation BingDeviceFirstViewController

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
    _isOpenUSDK = NO;
   // _bgImageView.image = [self getBlurredImage:[UIImage imageNamed:@"设置1"]];
    //_bgImageView.image = [UIImage imageNamed:@"detail_background_image.jpg"];
   // [self setFont:[UIFont systemFontOfSize:12] fromIndex:0 length:1 withLabel:_bingLabel1];
  //  [self setFont:[UIFont systemFontOfSize:12] fromIndex:1 length:2 withLabel:_bingLabel3];
   // [self setFont:[UIFont systemFontOfSize:12] fromIndex:0 length:_bingLabel4.text.length withLabel:_bingLabel4];
//    _wineManager = [WineManager shareWineManager];
//    _wineManager.delegate= self;
}

//- (void)subscribeDeviceFinished
//{
//    [self.navigationController popViewControllerAnimated:YES];
//}

-(void)viewWillAppear:(BOOL)animated
{
//    if (_isPush && _isOpenUSDK && !DATA_ENV.person.isBindingDevice) {
//        [[WineManager shareWineManager] stopHaierUSDK];
//    }
}

-(void)viewWillDisappear:(BOOL)animated
{
//    if (_isOpenUSDK && !DATA_ENV.person.isBindingDevice) {
//        [[WineManager shareWineManager] stopHaierUSDK];
//    }
}

#pragma mark - setFont

- (void)setFont:(UIFont *)font fromIndex:(NSInteger)location length:(NSInteger)length withLabel:(UILabel *)label{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:label.text];
    [str addAttribute:(NSString *)kCTFontAttributeName
                       value:(id)CFBridgingRelease(CTFontCreateWithName((CFStringRef)font.fontName,
                                                                        font.pointSize*2,
                                                                        NULL))
                       range:NSMakeRange(location, length)];
   // NSString *strq = [NSString stringWithString:str];
    //label.text = strq;
}

#pragma mark - ButtonClick

- (IBAction)addDeviceButton:(id)sender
{
   // uSDKErrorConst error = [[WineManager shareWineManager] startHaierUSDK];

  //  if (error == RET_USDK_OK) {
    //    _isOpenUSDK = YES;
        BingDeviceNextViewController *bfv = [[BingDeviceNextViewController alloc]init];
        [self.navigationController pushViewController:bfv animated:YES];
    //} else {
#warning 提示uSDK错误 tip！
  //  }
  //  BingDeviceNextViewController *bfv = [[BingDeviceNextViewController alloc]init];
     //       [self.navigationController pushViewController:bfv animated:YES];

}


- (IBAction)navBackButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - buyWineBox

- (IBAction)buyWineBox:(id)sender
{
    WebViewController *wvc = [[WebViewController alloc]init];
    [self.navigationController pushViewController:wvc animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
