//
//  HelpView2.m
//  HaierWine
//
//  Created by david on 14/8/27.
//
//

#import "HelpView2.h"

@implementation HelpView2

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
-(IBAction)click:(id)sender
{
    if ([_delegate respondsToSelector:@selector(startNow
                                                )]){
        [_delegate performSelector:@selector(startNow) withObject:nil afterDelay:0];
    }
}
@end
