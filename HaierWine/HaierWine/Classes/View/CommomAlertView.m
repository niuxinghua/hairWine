//
//  CommomAlertView.m
//  HaierWine
//
//  Created by david on 14/8/29.
//
//

#import "CommomAlertView.h"
#import "LoginViewController.h"
#import "PKRevealController.h"

@implementation CommomAlertView{

    IBOutlet UIView      *_alertBackgroundView;
    IBOutlet UIImageView *_alertBackgroundImageView;
}
static  UIViewController *_controller;
static  BOOL             _isMenuViewController;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+ (void)popAlertInViewController:(id)viewController isMenuController:(BOOL)isOrNo andAlertMessage:(NSString *)message;
{
    _isMenuViewController = isOrNo;
    _controller = (UIViewController *)viewController;
    CommomAlertView *alertView = [CommomAlertView loadFromXib];
    alertView.textLabel.text = message;
    [_controller.view addSubview:alertView];
    
}

#pragma mark - buttonClick

- (IBAction)buttonClicked:(id)sender
{
    UIButton *btn = (UIButton *)sender;
//    [_delegate CommonAlertViewClickedWithTag:btn.tag];
   // if (btn.tag == 1) {
//        LoginViewController *nwvc = [[LoginViewController alloc]init];
//        nwvc.delegate = self;
//        UINavigationController *nvc = [[UINavigationController alloc]initWithRootViewController:nwvc];
//        [_controller presentViewController:nvc animated:YES completion:^{
//            [self removeFromSuperview];
//
//        }];
        [_delegate CommonAlertViewClickedWithTag:btn.tag];
        
   // } else {
        
//        [_controller.navigationController.revealController showViewController:_controller.navigationController.revealController.leftViewController animated:YES completion:^(BOOL finished) {
//            if (finished) {
//                //                self.navigationController.revealController.recognizesPanningOnFrontView = YES;
//            }
//        }];

      //  [_controller.navigationController popViewControllerAnimated:NO];

 //   }
    [self removeFromSuperview];

}

- (void)isVister
{
    
}

- (void)awakeFromNib
{
    _alertBackgroundView.layer.cornerRadius = 5;
    //  _alertBackgroundImageView.image = [self drn_boxblurImageWithBlur:0 andImage:[UIImage imageNamed:@"alert_background_image.png"]];
    //alert_background_image.png
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
