//
//  SettingTableViewCell.h
//  HaierWine
//
//  Created by isoftstone on 14-7-14.
//
//

#import <UIKit/UIKit.h>

typedef enum {
    SettingCellTypeDefault = 0,
    SettingCellTypeText,
    SettingCellTypeSwitch,
    SettingCellTypeNewVersion,
    SettingCellTypeGray
    
}SettingCellType;

@interface SettingTableViewCell : UITableViewCell

@property (assign, nonatomic) BOOL hasLine;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (assign, nonatomic) SettingCellType type;
@property (strong, nonatomic) IBOutlet UIView *celllineView;
@property (strong, nonatomic) IBOutlet UILabel *updateVersionLabel;
@property (strong, nonatomic) IBOutlet UIImageView *updateVersionImageVIew;
+ (SettingTableViewCell *)cellFromNib;
@end
