//
//  MyFavouriteWineTableViewCell.m
//  HaierWine
//
//  Created by david on 14/7/10.
//
//

#import "MyFavouriteWineTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation MyFavouriteWineTableViewCell{

    IBOutlet UIImageView *_winePicImageView;
    IBOutlet UILabel *_wineNameLabel;
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

- (void)fillCellWithModel:(MyFavouriteWineModel *)model{
    [_winePicImageView setImageWithURL:[NSURL URLWithString:model.winePic]];
    _wineNameLabel.text = model.wineName;
}

@end
