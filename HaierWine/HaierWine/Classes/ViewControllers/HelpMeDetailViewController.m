//
//  HelpMeDetailViewController.m
//  HaierWine
//
//  Created by david on 14/8/14.
//
//

#import "HelpMeDetailViewController.h"

@interface HelpMeDetailViewController ()
{
    
    IBOutlet UIScrollView *_scrollView;
}

@end

@implementation HelpMeDetailViewController

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
    CGFloat height = [UILabel layoutLabelHeightText:_contentString font:[UIFont systemFontOfSize:16] width:290];
    _contentLabel.text = _contentString;
    _titleLabel.text = _titleString;
    [_contentLabel setHeight:height+5];
    [_imageView loadImage:_contentImage placeHolder:[UIImage imageNamed:@"640x360"]];//
    if (height>273) {
        _scrollView.contentSize = CGSizeMake(320, 509 + height-273);

    }
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
