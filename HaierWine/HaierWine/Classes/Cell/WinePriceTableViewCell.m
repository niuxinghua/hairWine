//
//  WinePriceTableViewCell.m
//  HaierWine
//
//  Created by isoftstone on 14-7-14.
//
//

#import "WinePriceTableViewCell.h"
#import "ITTXibViewUtils.h"
@implementation WinePriceTableViewCell

- (void)awakeFromNib
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

+(WinePriceTableViewCell *)cellFromNib
{
    return [ITTXibViewUtils loadViewFromXibNamed:NSStringFromClass([self class])];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
