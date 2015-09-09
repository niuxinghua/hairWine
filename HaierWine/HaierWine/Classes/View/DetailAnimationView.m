//
//  DetailAnimationView.m
//  HaierWine
//
//  Created by isoftstone on 14-7-8.
//
//

#import "DetailAnimationView.h"

@interface DetailAnimationView()
{
    NSTimer         *_timer;
    int             _t;
    BOOL            _isFirstPic;
    UIImageView     *_animationImageView;
    NSMutableArray  *_animationArray;
    
}
@end

@implementation DetailAnimationView

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
     self.layer.cornerRadius = 25;
    _backgroundImageView1.image = [UIImage imageNamed:@"detail_temperature_image"];
    _backgroundImageView1.frame = CGRectMake(-50, 0, 100, 50);
    _backgroundImageView2.image = [UIImage imageNamed:@"detail_temperature_image"];
    _backgroundImageView2.frame = CGRectMake(-150, 0, 100, 50);

    _foregroundImageView.image = [UIImage imageNamed:@"detail_suitdrink_image"];
    [_animationArray addObject:_backgroundImageView1];
    [_animationArray addObject:_backgroundImageView2];

    _timer = [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(timeing:) userInfo:nil repeats:YES];
}

-(void)timeing:(NSTimer *)timer
{
    _t = _t+2;
    CGRect frame =CGRectMake(-50+_t, 0, 100, 50);
    _animationImageView.frame = frame;
    if (_t == 50)
    {
        _t = 0;
        if(_isFirstPic){
            _animationImageView = [_animationArray objectAtIndex:1];
            _isFirstPic = NO;
        } else{
            _animationImageView = [_animationArray objectAtIndex:0];
            _isFirstPic = YES;
        }
    }

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
