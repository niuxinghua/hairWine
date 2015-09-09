//
//  FirstHelpViewController.m
//  HaierWine
//
//  Created by david on 14/8/5.
//
//

#import "FirstHelpViewController.h"
#import "HelpView.h"
#import "HelpView2.h"
@interface FirstHelpViewController (){
    
    IBOutlet UIScrollView *_scrollView;
    IBOutlet UIImageView  *_movePoint;
    IBOutlet UIImageView  *_firstRedPointImageView;
    IBOutlet UIImageView  *_secondRedPointImageView;
    IBOutlet UIImageView  *_thirdRedPointImageView;
    IBOutlet UIView       *_pageView;
    
}

@end

@implementation FirstHelpViewController

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
    HelpView2 *helpView = [HelpView2 loadFromXib];
    helpView.delegate = self;
    _scrollView.delegate = self;
    _secondRedPointImageView.hidden = YES;
    _thirdRedPointImageView.hidden = YES;
    [_scrollView addSubview:helpView];
    _scrollView.contentSize = CGSizeMake(960, [UIScreen mainScreen].bounds.size.height);

    if ([UIScreen mainScreen].bounds.size.height == 480) {
        helpView.image1.top -= 38;
        helpView.image2.top -= 37;
        helpView.image3.top -= 68;
        
        helpView.label1.top -= (19+38);
        helpView.label2.top -= (20+37);
        helpView.label3.top -= (0+68);
        
        helpView.labelText1.top -= (19+38);
        helpView.labelText2.top -= (20+37);
        helpView.labelText3.top -= (0+68);
        
        helpView.button.top -= (0+68-5);
        
        
        _pageView.top -= (0+68+8);
    }
 
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)startNow
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickNowButton)]) {
        [self.delegate didClickNowButton];
    }
}

#pragma mark - uiscrollView delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat l = scrollView.contentOffset.x;
   // NSLog(@"-----%f",scrollView.contentOffset.x);
   // NSLog(@"=====%f",scrollView.contentOffset.x/320.0*11.0+59);
    _movePoint.frame = CGRectMake(scrollView.contentOffset.x/320.0*18.0+59, _movePoint.frame.origin.y, _movePoint.frame.size.width, _movePoint.frame.size.height);
        
    _firstRedPointImageView.hidden = YES;
    _secondRedPointImageView.hidden = YES;
    _thirdRedPointImageView.hidden = YES;
        
 
    if (0 == l) {
        
        _firstRedPointImageView.hidden = NO;
        _secondRedPointImageView.hidden = YES;
        _thirdRedPointImageView.hidden = YES;
    }
    if (320 ==l) {
        
        _firstRedPointImageView.hidden = YES;
        _secondRedPointImageView.hidden = NO;
        _thirdRedPointImageView.hidden = YES;
        
    }
    
    if(640 == l) {
    
        _firstRedPointImageView.hidden = YES;
        _secondRedPointImageView.hidden = YES;
        _thirdRedPointImageView.hidden = NO;

        
    }
    
}

@end
