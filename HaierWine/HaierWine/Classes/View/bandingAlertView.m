//
//  bandingAlertView.m
//  HaierWine
//
//  Created by 张作伟 on 14-9-14.
//
//

#import "bandingAlertView.h"

@interface bandingAlertView ()
{
    
    IBOutlet UIView *_bgView;
}
@end

@implementation bandingAlertView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    _bgView.layer.cornerRadius = 5;

}

- (IBAction)buttonClick:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    [_delegate bandingAlertViewClick:btn.tag];
    [self removeFromSuperview];
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
