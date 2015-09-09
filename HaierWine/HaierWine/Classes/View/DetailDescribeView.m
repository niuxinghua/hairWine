//
//  DetailDescribeView.m
//  HaierWine
//
//  Created by isoftstone on 14-7-7.
//
//

#import "DetailDescribeView.h"

@implementation DetailDescribeView
{
    IBOutlet UILabel      *_wineNameLabel;
    IBOutlet UIImageView  *_overImageVIew;
    IBOutlet UILabel      *_wineContentLabel;
    IBOutlet UIButton     *_moreButton;
    
    
}

- (void)setWineName:(NSString *)wineName
{
    _wineNameLabel.text = wineName;
    _moreButton.selected = NO;
}

- (void)setWineDescribe:(NSString *)wineDescribe
{
    _wineContentLabel.text = [NSString stringWithFormat:@"       %@",wineDescribe];
    _moreButton.hidden = NO;//9.22

    CGFloat labelHeight = [UILabel layoutLabelHeightText:_wineContentLabel.text font:[UIFont systemFontOfSize:16] width:275];
    if (labelHeight < 64) {


        _moreButton.hidden = YES;
        [_wineContentLabel setFrame:CGRectMake(24, 90, 270, labelHeight+5)];
        self.height = self.height +labelHeight-62;
        
    }
    
}

#pragma mark - increaseLabel

- (IBAction)sizeLabel:(id)sender
{
   // UIButton *btn = (UIButton *)sender;
    _moreButton.selected = !_moreButton.selected;
    if (_moreButton.selected) {
        CGFloat labelHeight = [UILabel layoutLabelHeightText:_wineContentLabel.text font:[UIFont systemFontOfSize:16] width:275];
        if (labelHeight < 62) {
            return;
        }
        [_wineContentLabel setFrame:CGRectMake(21, 90, 275, labelHeight+5)];
        self.height = self.height +labelHeight-62+5;
    } else
    {
        _wineContentLabel.height = 62;
        self.height = 208;
    }
    [_delegate refreshUI:self.height];
}

@end
