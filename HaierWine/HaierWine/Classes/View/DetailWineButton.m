//
//  DetailWineButton.m
//  HaierWine
//
//  Created by isoftstone on 14-7-7.
//
//

#import "DetailWineButton.h"

@implementation DetailWineButton
{
    
    IBOutlet UILabel *_detailButtonLabel;
    
    IBOutlet UIButton *_detailWineButton;
    
    IBOutlet UILabel *_detailWineLabel;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)awakeFromNib
{
    
}

-(void)setLeft:(CGFloat)left andTop:(CGFloat)top withLabel:(NSString *)text andBtnImage:(UIImage*)image withTag:(NSInteger)tag ClickBlock:(void (^)(void))buttonClick
{
    self.top = top;
    self.left = left;
    _detailWineLabel.text = text;
    _detailWineButton.tag = tag;
   // [_detailWineButton setBackgroundImage:image forState:UIControlStateNormal];
   // [_detailWineButton setBackgroundImage:image forState:UIControlStateDisabled];
   if (tag !=1 && tag !=3)
   {
       [_detailWineButton setBackgroundImage:image forState:UIControlStateDisabled];
       _detailWineButton.enabled = NO;
   } else {
       
       [_detailWineButton setBackgroundImage:image forState:UIControlStateNormal];
   }
}

- (IBAction)detailBtnClick:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    [_delegate detailWineButtonClickWithTag:btn.tag];
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
