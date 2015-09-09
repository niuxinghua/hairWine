//
//  WhiteBoardTableViewCell.m
//  HaierWine
//
//  Created by david on 14/7/29.
//
//

#import "WhiteBoardTableViewCell.h"
#import "ITTXibViewUtils.h"

@implementation WhiteBoardTableViewCell

- (void)awakeFromNib
{
    // Initialization code
    _colorView.layer.cornerRadius = 28.5;
    _colorView.layer.shadowOffset = CGSizeMake(10, 10);
    _colorView.layer.shadowRadius = 50;
    _colorImageView.layer.cornerRadius = 28.5;
    _colorImageView.layer.shadowOffset = CGSizeMake(10, 10);
    _colorImageView.layer.shadowRadius = 50;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(WhiteBoardTableViewCell *)cellFromNib
{
    return [ITTXibViewUtils loadViewFromXibNamed:NSStringFromClass([self class])];
}

@end
