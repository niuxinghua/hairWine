//
//  WineFactoryTableViewCell.m
//  HaierWine
//
//  Created by 张作伟 on 14-8-13.
//
//

#import "WineFactoryTableViewCell.h"
#import "ITTXibViewUtils.h"
@implementation WineFactoryTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}

+ (WineFactoryTableViewCell *)cellFromNib
{
    return [ITTXibViewUtils loadViewFromXibNamed:NSStringFromClass([self class])];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
