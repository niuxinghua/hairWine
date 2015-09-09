//
//  ServiceAgreementViewController.m
//  登陆
//
//  Created by isoftstone on 14-6-29.
//  Copyright (c) 2014年 isoftstone. All rights reserved.
//

#import "ServiceAgreementViewController.h"

@interface ServiceAgreementViewController ()
{
    IBOutlet UITextView *_serviceTextView;
    
    IBOutlet UIButton *_nextPageButton;
    NSInteger         _index;
 
}

@end

@implementation ServiceAgreementViewController

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
    NSString *str = @" ";
    _serviceTextView.delegate = self;
   // _serviceTextView.text = str;
    _index = 2;
  // _serviceTextView.text = @"";
//    [ServiceAgreementRequest requestWithParameters:nil withIndicatorView:self.view onRequestFinished:^(ITTBaseDataRequest *request) {
//        _serviceTextView.text = request.handleredResult[@"serviceAgreement"];
//    }];

}
#pragma mark - buttonClick

- (IBAction)backButtonClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)nextPageClick:(id)sender
{
    NSRange range = {_serviceTextView.height*_index-40,_serviceTextView.height};
    [_serviceTextView scrollRangeToVisible:range];
    _index++;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y == 0) {
        _index = 2;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
