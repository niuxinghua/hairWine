//
//  SearchTableViewCell.m
//  HaierWine
//
//  Created by 张作伟 on 14-9-1.
//
//

#import "SearchTableViewCell.h"
#import "ITTXibViewUtils.h"

@implementation SearchTableViewCell

- (void)awakeFromNib
{
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleGray;
}

+ (SearchTableViewCell *)cellFromNib
{
    return [ITTXibViewUtils loadViewFromXibNamed:NSStringFromClass([self class])];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
