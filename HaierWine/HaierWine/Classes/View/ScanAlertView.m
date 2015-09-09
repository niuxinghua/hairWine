//
//  ScanAlertView.m
//  HaierWine
//
//  Created by david on 14/9/10.
//
//

#import "ScanAlertView.h"

@implementation ScanAlertView{

    IBOutlet UILabel     *_secondLabel;
    IBOutlet UIButton    *_rightButton;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (IBAction)buttonClicked:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    self.hidden = YES;
    [_delegate ScanAlertViewClickedWithTag:btn.tag];
}

-(void)setType:(ScanAlertType)type
{
    _type = type;
    if (_type == ScanAlertTypeFromHomePage) {
        
        _secondLabel.text = @"您是否再继续扫";
        [_rightButton setTitle:@"重试" forState:UIControlStateNormal];
        
    } else if (_type == ScanAlertTypeFromControlWine){
    
        _secondLabel.text = @"您可以自行控酒";
        [_rightButton setTitle:@"确定" forState:UIControlStateNormal];
        
    }
}
@end
