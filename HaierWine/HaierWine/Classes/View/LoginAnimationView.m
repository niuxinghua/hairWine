//
//  LoginAnimationView.m
//  HaierWine
//
//  Created by isoftstone on 14-7-11.
//
//

#import "LoginAnimationView.h"
#import "ITTImageView.h"
@interface LoginAnimationView ()
{
    IBOutlet ITTImageView *_waveImageViewA1;
    
    IBOutlet ITTImageView *_waveImageViewA2;
    
    IBOutlet ITTImageView *_waveImageViewB1;
    
    IBOutlet ITTImageView *_waveImageViewB2;
    
    IBOutlet UIView      *_waveView;
    BOOL                 _isFirstPic;
}

@end
@implementation LoginAnimationView

- (void)awakeFromNib
{
    _waveView.layer.cornerRadius = 65/2;
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

@end
