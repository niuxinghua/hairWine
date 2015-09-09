//
//  BrandTableViewCell.m
//  HaierWine
//
//  Created by david on 14/7/14.
//
//

#import "BrandTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "ITTXibViewUtils.h"


@implementation BrandTableViewCell{
    IBOutlet ITTImageView *_brandImageurlImageView;//图片
    IBOutlet UILabel        *_brandNameLabel;//品牌名称
    IBOutlet UILabel        *_brandLevelLable;//未用
    IBOutlet ITTImageView    *_brandLevelImageView;//等级图标
    IBOutlet ITTImageView    *_flagImageView;//国旗
    IBOutlet UILabel        *_brandAddressLabel;//国家
    IBOutlet UILabel        *_brandRegionLabel;//产区
    IBOutlet UILabel        *_brandRegionStaticLabel;
}

- (void)awakeFromNib
{
    // Initialization code
}

+(BrandTableViewCell *)cellFromNib
{
    return [ITTXibViewUtils loadViewFromXibNamed:NSStringFromClass([self class])];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)fillCellWithModel:(BrandModel *)model
{
    
    [_brandImageurlImageView loadImage:model.brandImageurl placeHolder:[UIImage imageNamed:@"200x200"]];
    _brandNameLabel.text = model.brandName;
    _brandAddressLabel.text = model.brandCountry;
    _brandRegionLabel.text = model.brandCity;
    [_flagImageView loadImage:model.brandCountry_img];
  //  [_flagImageView loadImage:model.brandCountry_img placeHolder:[UIImage imageNamed:@"famousPark_flag.png"]];
    [_brandLevelImageView loadImage:model.brandLevel_img];
    if ([model.brandLevel_img isEqualToString:@""]) {
        
        _brandNameLabel.top = 25;
        _flagImageView.top = 60;
        _brandAddressLabel.top = 60;
        _brandRegionStaticLabel.top = 92;
        _brandRegionLabel.top = 92;
        
    } else {
        
        _brandNameLabel.top = 15;
        _flagImageView.top = 76;
        _brandAddressLabel.top = 76;
        _brandRegionStaticLabel.top = 102;
        _brandRegionLabel.top = 102;
        
    }
    
    
}
@end
