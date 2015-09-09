//
//  FamousParkWineTableViewCell.m
//  HaierWine
//
//  Created by david on 14/7/14.
//
//

#import "FamousParkWineTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "ITTXibViewUtils.h"

@implementation FamousParkWineTableViewCell{
    
    IBOutlet ITTImageView   *_parkImageurlImageView;//图片
    IBOutlet UILabel        *_parkNameLabel;//酒庄名
    IBOutlet UILabel        *_parkLevelLable;//产区
    IBOutlet UILabel        *_parkAddressLabel;//国家
    IBOutlet UILabel        *_typeLabel;//类型
    IBOutlet ITTImageView    *_flagImageView;//国旗
    
}

+(FamousParkWineTableViewCell *)cellFromNib
{
    return [ITTXibViewUtils loadViewFromXibNamed:NSStringFromClass([self class])];
}
-(void)fillCellWithModel:(FamousParkWineModel *)model
{
    
    [_parkImageurlImageView loadImage:model.parkImageurl placeHolder:[UIImage imageNamed:@"200x200"]];
    _parkNameLabel.text = model.parkName;
    _parkLevelLable.text = model.parkAddress;
    _parkAddressLabel.text = model.parkContry;
    _typeLabel.text = model.parkType;
    [_flagImageView loadImage:model.parkContry_img];
   // [_flagImageView loadImage:model.parkContry_img placeHolder:[UIImage imageNamed:@"famousPark_flag.png"]];
    
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
