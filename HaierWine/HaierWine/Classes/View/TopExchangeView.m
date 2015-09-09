//
//  TopExchangeView.m
//  HaierWine
//
//  Created by david on 14/7/11.
//
//

#import "TopExchangeView.h"



@implementation TopExchangeView{
    IBOutlet UIImageView    *_imageView;
    IBOutlet UIButton       *_leftBtn;
    IBOutlet UIButton       *_rightBtn;
    IBOutlet UILabel *_leftLabel;
    IBOutlet UILabel *_rightLabel;
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

-(void)awakeFromNib
{
    
}

-(void)animation:(NSInteger)tag{
    if (101 == tag) {
       [UIView animateWithDuration:0.3 animations:^{
           _imageView.frame = CGRectMake(0, 0, 86, 30);
       }];
    }else if (102 == tag){
        [UIView animateWithDuration:0.3 animations:^{
            _imageView.frame = CGRectMake(86, 0, 86, 30);
        }];
    }
}

-(void)noAnimation:(NSInteger)tag{
    if (101 == tag) {
        
            _imageView.frame = CGRectMake(0, 0, 86, 30);
        
    }else if (102 == tag){
        
            _imageView.frame = CGRectMake(86, 0, 86, 30);
        
    }
}

-(void)exchange:(NSInteger)tag animation:(BOOL) hasAnimation
{
//    if (101 == tag) {
//        _leftBtn.selected = YES;
//        _rightBtn.selected = NO;
//        _leftLabel.textColor = [UIColor colorWithRed:90/255.0 green:48/255.0 blue:50/255.0 alpha:1];
//        _rightLabel.textColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.6];
//        
//    }else if (102 == tag){
//        _leftBtn.selected = NO;
//        _rightBtn.selected = YES;
//        _rightLabel.textColor = [UIColor colorWithRed:90/255.0 green:48/255.0 blue:50/255.0 alpha:1];
//        _leftLabel.textColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.6];
//    }
//    [self animation:tag];
    [self exchangeWithOutDelegate:tag animation:hasAnimation];
    if (hasAnimation) {
        [_delegate change:tag];
        
    } else {
    
        [_delegate changeWithOutAnimation:tag];
    }
    
}

//-(void)exchangeWithOutDelegate:(NSInteger)tag{
//    
//    if (101 == tag) {
//        _leftBtn.selected = YES;
//        _rightBtn.selected = NO;
//        _leftLabel.textColor = [UIColor colorWithRed:90/255.0 green:48/255.0 blue:50/255.0 alpha:1];
//        _rightLabel.textColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.6];
//        
//    }else if (102 == tag){
//        _leftBtn.selected = NO;
//        _rightBtn.selected = YES;
//        _rightLabel.textColor = [UIColor colorWithRed:90/255.0 green:48/255.0 blue:50/255.0 alpha:1];
//        _leftLabel.textColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.6];
//    }
//    [self animation:tag];
//}

-(void)exchangeWithOutDelegate:(NSInteger)tag animation:(BOOL) hasAnimation{
    
    if (101 == tag) {
        _leftBtn.selected = YES;
        _rightBtn.selected = NO;
        _leftLabel.textColor = [UIColor colorWithRed:90/255.0 green:48/255.0 blue:50/255.0 alpha:1];
        _rightLabel.textColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.6];
        
    }else if (102 == tag){
        _leftBtn.selected = NO;
        _rightBtn.selected = YES;
        _rightLabel.textColor = [UIColor colorWithRed:90/255.0 green:48/255.0 blue:50/255.0 alpha:1];
        _leftLabel.textColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.6];
    }
    if (hasAnimation) {
        [self animation:tag];
    } else {
        [self noAnimation:tag];
    }
    
}

-(IBAction)btnClick:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    [self exchange:btn.tag animation:YES];
}


-(void)exchangeToLeft
{
    [self exchange:101 animation:YES];
}

-(void)exchangeToRight
{
    [self exchange:102 animation:YES];
}

-(void)onlyPicMoveToLeft{
    
    [self exchangeWithOutDelegate:101 animation:YES];
}
-(void)onlyPicMoveToRight{

    [self exchangeWithOutDelegate:102 animation:YES];
}

-(void)showLeft{
    
    [self exchange:101 animation:NO];
}

-(void)showRight{

    [self exchange:102 animation:NO];
}

@end
