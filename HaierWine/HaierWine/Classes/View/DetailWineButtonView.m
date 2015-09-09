//
//  DetailWineButtonView.m
//  HaierWine
//
//  Created by isoftstone on 14-7-7.
//
//

#import "DetailWineButtonView.h"
#import "DetailWineButton.h"
@implementation DetailWineButtonView

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
    [super awakeFromNib];
    NSArray *titleArray = @[@"年份",@"品种",@"酒精度",@"等级",@"净含量",@"适应场合"];
    for(int i = 0;i <2;i++)
        for(int j = 0;j <3;j++)
        {
            CGFloat left = 13+(102*j);
            CGFloat top = 153*i;
            NSString *title = [titleArray objectAtIndex:i*3+j];
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"detail_wineInfo_image%d",i*3+j+1]];
            DetailWineButton *btn = [DetailWineButton loadFromXib];
            btn.delegate = self;
            [btn setLeft:left andTop:top withLabel:title andBtnImage:image withTag:i*3+j ClickBlock:^{
                
            }];
            [self addSubview:btn];
        }
}

-(void)setTitleArray:(NSArray *)titleArray
{
    NSInteger index = 0;
    NSInteger levelSwitch = [[titleArray lastObject] integerValue];
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[DetailWineButton class]]) {
            DetailWineButton *detailWineButton = (DetailWineButton *)view;
            detailWineButton.detailButtonLabel.text = [titleArray objectAtIndex:index];
           // detailWineButton.buttonTitle.titleLabel.textAlignment = NSTextAlignmentCenter;
           // detailWineButton.buttonTitle.titleLabel.text = [titleArray objectAtIndex:index];
           // [detailWineButton.buttonTitle setTitle:[titleArray objectAtIndex:index] forState:UIControlStateNormal];
                if (index == 3) {
                    if (levelSwitch == 2) {
                        [detailWineButton.buttonTitle setBackgroundImage:[UIImage imageNamed:@"detail_level_image"] forState:UIControlStateNormal];
                       // detailWineButton.buttonTitle.enabled = NO;
                    } else {
                                              [detailWineButton.buttonTitle setBackgroundImage:[UIImage imageNamed:@"detail_wineInfo_image4"] forState:UIControlStateNormal];
                      //  detailWineButton.buttonTitle.enabled = YES;

                    }
            } else if (index == 2){
                //detailWineButton.buttonTitle.titleLabel.text = [NSString stringWithFormat:@"%@°",detailWineButton.buttonTitle.titleLabel.text];
              //  detailWineButton.detailButtonLabel.text = [NSString stringWithFormat:@"%@",detailWineButton.detailButtonLabel.text];
                NSMutableString *str = [[NSMutableString alloc]initWithString:detailWineButton.detailButtonLabel.text];
                [str appendString:@"%"];
                detailWineButton.detailButtonLabel.text  = str;
            } else if (index == 4) {
               // detailWineButton.buttonTitle.titleLabel.text = [NSString stringWithFormat:@"%@ml",detailWineButton.buttonTitle.titleLabel.text];
                detailWineButton.detailButtonLabel.text = [NSString stringWithFormat:@"%@ml",detailWineButton.detailButtonLabel.text];
            } else if (1 == index) {
                if (detailWineButton.detailButtonLabel.text.length > 4) {
                    detailWineButton.detailButtonLabel.text = [detailWineButton.detailButtonLabel.text substringToIndex:3];
                }
                
            }
          //  NSLog(@"%@++++%@",detailWineButton.buttonTitle,[titleArray objectAtIndex:index]);
            index ++;
        }
    }
}

#pragma mark - DetailWineButtonDelegate

- (void)detailWineButtonClickWithTag:(NSInteger)tag
{
    [_delegate PopViewButtonSelextedWithTag:tag];
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
