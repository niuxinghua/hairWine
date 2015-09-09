//
//  AlertMessageDetailViewController.m
//  HaierWine
//
//  Created by david on 14/8/15.
//
//

#import "AlertMessageDetailViewController.h"

@interface AlertMessageDetailViewController ()
{
        IBOutlet UILabel *_alertMessage;
}

@end

@implementation AlertMessageDetailViewController

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
    _alertMessage.text = _alertContent;
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
