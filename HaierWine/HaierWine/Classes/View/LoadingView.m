//
//  LoadingView.m
//  HaierWine
//
//  Created by 张作伟 on 14-9-11.
//
//

#import "LoadingView.h"

@interface LoadingView ()
{
    IBOutlet UIView       *_bgView;
        
    IBOutlet UIView       *_animationBackground;
    
    IBOutlet ITTImageView *_waveImageViewA1;
    
    IBOutlet ITTImageView *_waveImageViewA2;
    
    IBOutlet ITTImageView *_waveImageViewB1;
    
    IBOutlet ITTImageView *_waveImageViewB2;
    BOOL                  _isFirstPic;
}

@end

@implementation LoadingView

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
    _bgView.layer.cornerRadius = 65/2.0;
    _isFirstPic = YES;
    [self viewAnimation];

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
