//
//  ControlWineAlertView.m
//  HaierWine
//
//  Created by 张作伟 on 14-8-31.
//
//

#import "ControlWineAlertView.h"

@implementation ControlWineAlertView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (IBAction)buttonClick:(id)sender
{
    //[UIView animateWithDuration:0.5 animations:^{
       // self.hidden = YES;
     //   self.alpha = 0;
   // } completion:^(BOOL finished) {
        [self removeFromSuperview];
   // }];
}

@end
