//
//  WineKindTableViewCell.m
//  HaierWine
//
//  Created by david on 14/7/15.
//
//

#import "WineKindTableViewCell.h"
#import "ITTXibViewUtils.h"

@implementation WineKindTableViewCell

+ (WineKindTableViewCell *)loadCell
{
    return  [ITTXibViewUtils loadViewFromXibNamed:NSStringFromClass([self class])];
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
