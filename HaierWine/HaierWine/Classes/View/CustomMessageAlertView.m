//
//  CustomMessageAlertView.m
//  HaierWine
//
//  Created by david on 14/8/29.
//
//

#import "CustomMessageAlertView.h"

@implementation CustomMessageAlertView{

    IBOutlet UIView *_alertBackgroundView;
    IBOutlet UIImageView *_alertBackgroundImageView;
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

#pragma mark - buttonClick

- (IBAction)buttonClicked:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    //self.hidden = YES;
    if (btn.tag == 1) {
      //  [[NSNotificationCenter defaultCenter] postNotificationName:@"SHOWDETAILMESSAGE" object:nil];
      //  [[NSNotificationCenter defaultCenter] postNotificationName:@"SHOWDETAILMESSAGE" object:self userInfo:nil];
        //[UIAlertView popupAlertByDelegate:nil title:@"adsfhadf" message:@"adsf;af"];
        
    }
    [_delegate customMessageAlertViewClickedWithTag:btn.tag];
    [self removeFromSuperview];
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
