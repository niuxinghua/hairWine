//
//  WineShopListTableViewCell.m
//  HaierWine
//
//  Created by 张作伟 on 14-8-12.
//
//

#import "WineShopListTableViewCell.h"
#import "ITTXibViewUtils.h"
@implementation WineShopListTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}

+ (WineShopListTableViewCell *)cellFromNib
{
    return [ITTXibViewUtils loadViewFromXibNamed:NSStringFromClass([self class])];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
