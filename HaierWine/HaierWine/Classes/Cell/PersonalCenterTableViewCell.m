//
//  PersonalCenterTableViewCell.m
//  HaierWine
//
//  Created by isoftstone on 14-7-23.
//
//

#import "PersonalCenterTableViewCell.h"
#import "ITTXibViewUtils.h"
@implementation PersonalCenterTableViewCell
{
    
    IBOutlet UIView *_personPicView;
    
    IBOutlet UIImageView *_ArrowImageView;
}

- (void)awakeFromNib
{
    // Initialization code
    _personPicView.layer.cornerRadius = 25;
    self.selectionStyle = UITableViewCellSelectionStyleGray;
}

- (void)setType:(PersonalCenterCellType)type
{
    _type = type;
    if (_type == PersonalCenterCellTypeImage) {
        _personInfo.hidden = YES;
        _personInfo.left = 107;
        _personPicView.hidden = NO;
    }else if (_type == PersonalCenterCellTypeDefault){
        _personInfo.hidden = NO;
        _personInfo.left = 107;
        _personPicView.hidden = YES;
    } else if (_type == PersonalCenterCellTypeUnselected){
        _personInfo.hidden = NO;
        _personInfo.left = 124;
        _personPicView.hidden = YES;
        _ArrowImageView.hidden = YES;
    }
}

+ (PersonalCenterTableViewCell *)cellFromNib
{
    return [ITTXibViewUtils loadViewFromXibNamed:NSStringFromClass([self class])];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
