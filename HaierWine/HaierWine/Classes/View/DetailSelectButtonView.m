//
//  DetailSelectButtonView.m
//  HaierWine
//
//  Created by isoftstone on 14-7-7.
//
//

#import "DetailSelectButtonView.h"

@interface DetailSelectButtonView()
{
    UIButton            *_currentButton;
    IBOutlet UIButton   *_infoButton;
}
@end

@implementation DetailSelectButtonView

- (void)awakeFromNib
{
    _currentButton = _infoButton;
}

#pragma mark - Button Methods

- (IBAction)baseInfoButton:(id)sender
{
    _currentButton.selected = NO;
    _currentButton = (UIButton *)sender;
    _currentButton.selected = YES;
    [_delegate selectButtonClick:_currentButton.tag];
}


@end
