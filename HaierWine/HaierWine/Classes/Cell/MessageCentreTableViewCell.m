//
//  MessageCentreTableViewCell.m
//  HaierWine
//
//  Created by david on 14/8/13.
//
//

#import "MessageCentreTableViewCell.h"
#import "ITTXibViewUtils.h"

@implementation MessageCentreTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+(MessageCentreTableViewCell *)cellFromNib
{
    return [ITTXibViewUtils loadViewFromXibNamed:NSStringFromClass([self class])];
}
@end
