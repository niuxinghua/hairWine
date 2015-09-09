//
//  SettingTableViewCell.m
//  HaierWine
//
//  Created by isoftstone on 14-7-14.
//
//

#import "SettingTableViewCell.h"
#import "ITTXibViewUtils.h"
@interface SettingTableViewCell ()
{
    
//    IBOutlet UIImageView *_newVersionImageVIew;
    IBOutlet UISwitch *_soundSwitch;
    IBOutlet UIImageView *_arrowImageView;
 //   IBOutlet UILabel *_newVersionLabel;
    IBOutlet UIView *_settingSeparateView;
    __weak IBOutlet UIView *_line;
    
    
}

@end
@implementation SettingTableViewCell

- (void)awakeFromNib
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    if (isIOS7()) {
        _soundSwitch.left = 251;
    } else {
        _soundSwitch.left = 230;
    }
    _soundSwitch.on=![DATA_ENV.voiceOn boolValue];
}

-(void)setHasLine:(BOOL)hasLine
{
    _line.hidden = hasLine?NO:YES;
}

+ (SettingTableViewCell *)cellFromNib
{
    return [ITTXibViewUtils loadViewFromXibNamed:NSStringFromClass([self class])];
}
- (void)setType:(SettingCellType)type
{
    _type = type;
    if (_type == SettingCellTypeSwitch) {
        _soundSwitch.hidden = NO;
        _arrowImageView.hidden = YES;
        _updateVersionImageVIew.hidden = YES;
        _updateVersionLabel.hidden = YES;
        //_settingBgView.hidden = YES;
self.contentView.backgroundColor = [UIColor whiteColor];

    } else if (_type == SettingCellTypeNewVersion){
        _updateVersionImageVIew.hidden = YES;
        _updateVersionLabel.hidden = YES;
        _soundSwitch.hidden = YES;
        _arrowImageView.hidden = NO;
        self.contentView.backgroundColor = [UIColor whiteColor];
       // _settingBgView.hidden = YES;

    } else if (_type == SettingCellTypeText){
        _updateVersionImageVIew.hidden = YES;
        _updateVersionLabel.hidden = YES;
        _soundSwitch.hidden = YES;
        _arrowImageView.hidden = NO;
        self.contentView.backgroundColor = [UIColor whiteColor];
       // _settingBgView.hidden = YES;

    } else if(_type == SettingCellTypeGray)
    {
        //_settingBgView.hidden = NO;
        _updateVersionImageVIew.hidden = YES;
        _updateVersionLabel.hidden = YES;
        _soundSwitch.hidden = YES;
        _arrowImageView.hidden = YES;
        self.contentView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
      //  _settingBgView.hidden = YES;

        
    }
        
    
}
#pragma mark -switch
- (IBAction)switchChange:(id)sender
{
    UISwitch *voiceSwith = (UISwitch *)sender;
    DATA_ENV.voiceOn = [NSString stringWithFormat:@"%d",!voiceSwith.isOn];
   // NSLog(@"voiceSwith%d",voiceSwith.isOn);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
