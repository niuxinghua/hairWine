//
//  WhiteBoardViewController.m
//  HaierWine
//
//  Created by isoftstone on 14-7-7.
//
//

#import "WhiteBoardViewController.h"

@interface WhiteBoardViewController ()
{
    
    IBOutlet UIView *_bgView;
}

@end

@implementation WhiteBoardViewController

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
    for(UIView *view in self.view.subviews)
    {
        if(view.tag == 11)
        {
            
        }else if (view.tag == 12){
            
        }else{
            
        }
    }
    
    self.view.transform = CGAffineTransformMakeRotation(M_PI/2);
    self.view.bounds = CGRectMake(0, 0, 480, 320);
    _bgView.left = -20;
    self.view.clipsToBounds=NO;
   // [self.view addSubview:_bgView];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
   // [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

#pragma mark - userAction

- (IBAction)colorButtonClick:(id)sender
{
    UIButton *colorButton = (UIButton *)sender;
    if (colorButton.tag == 11){
        
    }else if (colorButton.tag == 12){
        
    }else if (colorButton.tag == 13){
        
    }else if (colorButton.tag == 14){
        
    }else if (colorButton.tag == 15){
        
    }else if (colorButton.tag == 16){
        
    }else if (colorButton.tag == 17){
        
    }
        
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
