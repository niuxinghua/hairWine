//
//  InitNetworkView.m
//  HaierIceBox
//
//  Created by Jeremy on 14-5-27.
//
//


#import "InitNetworkView.h"

@interface InitNetworkView()

@property (weak, nonatomic) IBOutlet UIImageView *wifiImageView;
@property (weak, nonatomic) IBOutlet UIButton *clickHereBtn;

@property (strong, nonatomic) void(^clickHereBlock)(void);
@property (strong, nonatomic) void(^nextStepBlock)(void);
@end


@implementation InitNetworkView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setFrame:(CGRect)frame is4inch:(BOOL)is4inch clickHereBlock:(void(^)(void))clickHereBlock nextStepBlock:(void(^)(void))nextStepBlock
{
    [self setFrame:frame];
    
    if (is4inch) {
        self.nextStepBtn.top = self.height - _nextStepBtn.height - 75;
    }
    _clickHereBlock = clickHereBlock;
    _nextStepBlock = nextStepBlock;
}

- (IBAction)clickedForHelp:(id)sender {
    _clickHereBlock();
}

- (IBAction)toNextStepClicked:(id)sender {
    _nextStepBlock();
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
