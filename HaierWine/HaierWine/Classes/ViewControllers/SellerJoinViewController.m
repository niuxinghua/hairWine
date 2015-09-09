//
//  SellerJoinViewController.m
//  HaierWine
//
//  Created by isoftstone on 14-7-6.
//
//

#import "SellerJoinViewController.h"

@interface SellerJoinViewController ()
{
    IBOutlet UIView *_contentView;
    
    IBOutlet UIView *_titleView;
    
    IBOutlet UIButton *_ApplicationAddressButton;
    UIApplication     *_application;
    
    IBOutlet UIButton *_applicationTellButton;
    
    IBOutlet UIButton *_applicationEmailButton;
    NSString          *_address;

}

@end

@implementation SellerJoinViewController

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
    // Do any additional setup after loading the view from its nib.
    _application = [UIApplication sharedApplication];
    [self getDataRequest];
//    NSMutableAttributedString *content = [[NSMutableAttributedString alloc]initWithString:@"www.happyWine.com/ryzhu"];
//    NSRange contentRange = {0,content.length};
//    [content addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:contentRange];
//    _ApplicationAddressButton.titleLabel.attributedText = content;
    if (is4InchScreen()) {
        _titleView.top = _titleView.top +25;
        _contentView.top = _contentView.top + 40;
    }
}

#pragma mark - getDataRequest

- (void)getDataRequest
{
    [SellerJoinRequest requestWithParameters:nil withIndicatorView:nil onRequestFinished:^(ITTBaseDataRequest *request) {
     //   _ApplicationAddressButton.titleLabel.text = request.handleredResult[@"address"];
        [_ApplicationAddressButton setTitle:request.handleredResult[@"address"] forState:UIControlStateNormal];
        //_address = request.handleredResult[@"address"];
        //_applicationEmailButton.titleLabel.text = request.handleredResult[@"email"];
         [_applicationEmailButton setTitle:request.handleredResult[@"email"] forState:UIControlStateNormal];
      //  _applicationTellButton.titleLabel.text = request.handleredResult[@"tel"];
        [_applicationTellButton setTitle:request.handleredResult[@"tel"] forState:UIControlStateNormal];
    }];
}

#pragma mark - userAction
- (IBAction)ApplicationAddressClick:(id)sender
{
   // [_application openURL:[NSURL URLWithString:@"http://www.happyWine.com/ryzhu"]];
    _address = [NSString stringWithFormat:@"http://%@",_ApplicationAddressButton.titleLabel.text ];
  //  NSLog(@"%@",_address);
    [_application openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_ApplicationAddressButton.titleLabel.text]]];
}

- (IBAction)telButtonClick:(id)sender
{
    [_application openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",_applicationTellButton.titleLabel.text]]];
  /*  UIWebView *callWebView = [[UIWebView alloc]init];
    NSURL *telURL = [NSURL URLWithString:@"tel:400-800-1234"];
    [callWebView loadRequest:[NSURLRequest requestWithURL:telURL]];
    [self.view addSubview:callWebView];*/
}

- (IBAction)mailButtonClick:(id)sender
{
    [_application openURL:[NSURL URLWithString:[NSString stringWithFormat:@"mailto://%@",_applicationEmailButton.titleLabel.text]]];
}

- (IBAction)backButtonClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
