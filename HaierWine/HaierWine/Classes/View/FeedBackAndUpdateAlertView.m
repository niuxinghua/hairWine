//
//  FeedBackAndUpdateAlertView.m
//  HaierWine
//
//  Created by david on 14/9/11.
//
//

#import "FeedBackAndUpdateAlertView.h"

@implementation FeedBackAndUpdateAlertView{
    
    IBOutlet UIView *_alertBgView;
    IBOutlet UILabel  *_textLabel;
    IBOutlet UIButton *_button;
    
}

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
    _alertBgView.layer.cornerRadius = 5;
    UIControl *control = [[UIControl alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    [control addTarget:self action:@selector(controlClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:control];
}
- (void)controlClick
{
    [self removeFromSuperview];
}
- (IBAction)buttonClicked:(id)sender
{
   // self.hidden = YES;
    [self removeFromSuperview];
}


-(void)setType:(FeedBackAndUpdateType)type{

    _type = type;
    if (_type == FeedBackSuccess) {
        
        _textLabel.text = @"提交成功";
        [_button setTitle:@"确定" forState:UIControlStateNormal];
        
    } else if (_type == FeedBackFailed){
    
        _textLabel.text = @"提交失败";
        [_button setTitle:@"确定" forState:UIControlStateNormal];
        
    } else if (_type == UpdateNotNeed){
        
        _textLabel.text = @"当前已是最新版本";
        [_button setTitle:@"知道了" forState:UIControlStateNormal];
        
    } else if (_type == FeedBackIsEmpty){
    
        _textLabel.text = @"输入不能为空";
        [_button setTitle:@"确定" forState:UIControlStateNormal];
    } else if (_type == UnBandingSuccess){
        _textLabel.text = @"解绑成功";
        [_button setTitle:@"知道了" forState:UIControlStateNormal];

    } else if (_type == FeedBackIsMore) {
        _textLabel.text = @"输入不能超过140个字";
        [_button setTitle:@"确定" forState:UIControlStateNormal];

    } else if (_type == UnconnectWIFI) {
        _textLabel.text = @"没有连接到网络,设置连接网络后请重试";
        [_button setTitle:@"知道了" forState:UIControlStateNormal];
    }
}

@end
