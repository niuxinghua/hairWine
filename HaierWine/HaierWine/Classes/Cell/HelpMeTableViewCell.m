//
//  HelpMeTableViewCell.m
//  HaierWine
//
//  Created by david on 14/8/11.
//
//

#import "HelpMeTableViewCell.h"
#import "ITTXibViewUtils.h"

@implementation HelpMeTableViewCell

- (void)awakeFromNib
{
    // Initialization code
    _numView.layer.cornerRadius = 11;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+(HelpMeTableViewCell *)cellFromNib
{
    
    return [ITTXibViewUtils loadViewFromXibNamed:NSStringFromClass([self class])];
}
-(void)fillCellWithModel:(HelpMeModel *)model andindexPath:(NSIndexPath *)indexPath
{
    
    _numLabel.text = [NSString stringWithFormat:@"%d",indexPath.row + 1];
    _titleLabel.text = model.helpMeName;

}
@end
