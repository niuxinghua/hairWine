//
//  bindingProgressView.m
//  HaierWine
//
//  Created by 张作伟 on 14-8-6.
//
//

#import "bindingProgressView.h"
#import "ITTImageView.h"
@interface bindingProgressView ()
{
    
    IBOutlet UIView       *_bgView;
    
    IBOutlet UILabel      *_countLabel;
    
    IBOutlet UIView       *_animationBackground;
    
    IBOutlet ITTImageView *_waveImageViewA1;
    
    IBOutlet ITTImageView *_waveImageViewA2;
    
    IBOutlet ITTImageView *_waveImageViewB1;
    
    IBOutlet ITTImageView *_waveImageViewB2;
    BOOL                  _isFirstPic;
    NSTimer               *_timer;
    
}

@end

@implementation bindingProgressView

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
    _animationBackground.layer.cornerRadius = 65/2.0;
    _isFirstPic = YES;
    [self viewAnimation];
    _count = 60;
  //  _timer = [NSTimer timerWithTimeInterval:1.0f target:self selector:@selector(timing:) userInfo:nil repeats:YES];
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timing:) userInfo:nil repeats:YES];
    _bgView.layer.cornerRadius = 5;
}

- (void)timing:(NSTimer *)t
{
    _count -- ;
    _progressCount.text = [NSString stringWithFormat:@"%d",_count];
    if (_count == 0 && self.hidden == NO ) {
        self.hidden = YES;
        if ([_delegate respondsToSelector:@selector(connectFialure)]) {
            [_delegate connectFialure];
        }
      //  [t invalidate];
    }
}

- (void)setCount:(NSInteger)count
{
    _count = count;
   // [_timer fire];
    _progressCount.text = [NSString stringWithFormat:@"%d",_count];
    
}
- (void)viewAnimation
{
    
    [UIView animateWithDuration:7.5f delay:0 options:UIViewAnimationOptionCurveLinear  animations:^{
        CGFloat left = _waveImageViewA1.left;
        left = left+130;
        _waveImageViewA1.left = left;
        _waveImageViewB1.left = left;
        
        left = _waveImageViewA2.left;
        left = left+130;
        _waveImageViewA2.left =left;
        _waveImageViewB2.left = left;
    } completion:^(BOOL finished) {
        if (finished) {
            if(_isFirstPic){
                CGFloat left = -130;
                _waveImageViewA1.left = left;
                _waveImageViewB1.left = left;
                _isFirstPic = NO;
            } else{
                CGFloat left = -130;
                _waveImageViewA2.left = left;
                _waveImageViewB2.left = left;
                _isFirstPic = YES;
            }
            [self viewAnimation];
        }
        
    }];
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
