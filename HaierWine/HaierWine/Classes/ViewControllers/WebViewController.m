//
//  WebViewController.m
//  HaierWine
//
//  Created by 张作伟 on 14-8-20.
//
//

#import "WebViewController.h"

@interface WebViewController ()
{
    IBOutlet UILabel                 *_navTitle;
    
    IBOutlet UIWebView               *_webView;
    
    IBOutlet UIActivityIndicatorView *_activityIndicatorView;
    
    IBOutlet UILabel                 *_loading;
}

@end

@implementation WebViewController

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
    _webView.scalesPageToFit = YES;
    [_webView setUserInteractionEnabled:YES];
    _webView.delegate = self;
    [_activityIndicatorView setHidden:YES];
    _loading.hidden = YES;
    _navTitle.text = _titleName;
   // [self loadWebPageWithString:@"http://m.ehaier.com/mobile/member/toBackPassword.html"];
    NSString *url;
    if (_type == 1) {
       // url =  @"http://m.haier.com/ids/mobile/find-pwd-loginName.jsp";
       // url = @"http://test.haier.com/mobile/my-find-pwd.shtml";
        url = @"http://m.haier.com/ids/mobile/find-pwd-loginName.jsp";
    }else if (_type == 2){
        url = @"http://www.happywine.cn/";
    } else {
        url = @"http://www.haier.com/cn/consumer/cloud/weijk/201410/t20141023_250247.shtml";
    }
    [self loadWebPageWithString:url];
    
}

#pragma mark - loadWebPageWithString

- (void)loadWebPageWithString:(NSString *)urlString
{
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [_activityIndicatorView stopAnimating];
    _activityIndicatorView.hidden = YES;
    _loading.hidden = YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [_activityIndicatorView startAnimating];
    _activityIndicatorView.hidden = NO;
    _loading.hidden = NO;
}

#pragma mark - back

- (IBAction)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
