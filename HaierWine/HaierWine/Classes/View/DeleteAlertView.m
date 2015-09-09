//
//  DeleteAlertView.m
//  HaierWine
//
//  Created by david on 14/9/11.
//
//

#import "DeleteAlertView.h"

@implementation DeleteAlertView{
    
    IBOutlet UIButton *_confirmButton;
    IBOutlet UIView   *_alertBgView;
    IBOutlet UILabel  *_textLabel;
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
}

- (IBAction)buttonClicked:(id)sender
{
    UIButton *btn = (UIButton *)sender;
   // self.hidden = YES;
    [self removeFromSuperview];
    [_delegate DeleteAlertViewClickedWithTag:btn.tag withType:_type];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
- (void)setType:(DeleteAlertViewType)type{
    _type = type;
    if (_type == DeleteAlertViewTypeNoSelected) {
        
        _textLabel.text = @"请选择您要删除的酒品";
        
    }else if (_type == DeleteAlertViewTypeAskSure){
    
        _textLabel.text = @"确定要删除？";
        
    } else if (_type == DeleteAlertViewTypeMessage){
        
        _textLabel.text = @"请选择您要删除的消息";
        
    }
    else if (_type == DeleteAlertViewTypeUnbanding){
        
        _textLabel.text = @"解绑失败";
        [_confirmButton setTitle:@"重试" forState:UIControlStateNormal];
    } else if (_type == DeleteAlertViewTypeSearchHistory){
        _textLabel.text = @"确定要清空搜索历史记录";
    } else if (_type == DeleteAlertViewTypeNameEmpty) {
        _textLabel.text = @"名字不能为空";
    } else if (_type == DeleteAlertViewTypeWine){
        _textLabel.text = @"是否删除酒柜中的酒品?";
    } else if (_type == DeleteAlertViewTypeUnbandingFirst){
        _textLabel.text = @"解除绑定设备后,将不能使用控酒功能,若想继续使用,需要重新绑定设备。";
        [_confirmButton setTitle:@"解绑设备" forState:UIControlStateNormal];

    } else if (_type == DeleteAlertViewTypeWineFail) {
        _textLabel.text = @"删除失败";
    }
    
}
@end
