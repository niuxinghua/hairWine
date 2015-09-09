//
//  NewFeatureIntroViewController.m
//  HaierWine
//
//  Created by david on 14/7/29.
//
//

#import "NewFeatureIntroViewController.h"

@interface NewFeatureIntroViewController (){
    IBOutlet UIButton *_btn;
    IBOutlet UILabel  *_label;
    IBOutlet UILabel  *_versionNumLabel;
    IBOutlet UILabel  *_versionNum2Label;
}

@end

@implementation NewFeatureIntroViewController

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
 //   NSString *RequestURL = [NSString stringWithFormat:@"%@/appVersion/%@/latest",COMMON_SERVER_ADDRESS,APPID];
 //   [NewVirsionRequest requestWithParameters:nil withRequestUrl:RequestURL withIndicatorView:self.view onRequestFinished:^(ITTBaseDataRequest *request) {
      //  NSLog(@"版本更新--%@",reques)
 //   }];
    [self getRequest];
    
}

#pragma mark - requestMethod
-(void)getRequest{

    LoadingView *loadingView = [LoadingView loadFromXib];
    if (isIOS7()) {
        
        loadingView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    } else {
        
        loadingView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    }

    //loadingView.frame = CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height);
    
    [self.view addSubview:loadingView];
    
    NSMutableDictionary *paragram = [[NSMutableDictionary alloc]init];
    [paragram setValue:@"ios" forKeyPath:@"type"];
    
    [NewAppSubRequest requestWithParameters:paragram withIndicatorView:nil withCancelSubject:nil onRequestStart:^(ITTBaseDataRequest *request) {
        
    } onRequestFinished:^(ITTBaseDataRequest *request) {
        
        [loadingView removeFromSuperview];
        if ([request isSuccess]) {
            _versionNumLabel.text = request.handleredResult[@"data"][@"no"];
            _versionNum2Label.text = request.handleredResult[@"data"][@"no"];
            NSString * describeStr = request.handleredResult[@"data"][@"uphint"];
            CGSize size = [describeStr sizeWithFont:[UIFont systemFontOfSize:13.0f] constrainedToSize:CGSizeMake(280, 9999) lineBreakMode:NSLineBreakByCharWrapping];
            _label.frame  = CGRectMake(20, 317, 280, size.height);
            _label.text = describeStr;

        }
    } onRequestCanceled:^(ITTBaseDataRequest *request) {
        
    } onRequestFailed:^(ITTBaseDataRequest *request) {
        [loadingView removeFromSuperview];

    }];
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

@end
