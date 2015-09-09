//
//  PersonalCenterTableViewCell.h
//  HaierWine
//
//  Created by isoftstone on 14-7-23.
//
//

#import <UIKit/UIKit.h>
#import "ITTImageView.h"
typedef enum {
    PersonalCenterCellTypeDefault = 0,
    PersonalCenterCellTypeImage,
    PersonalCenterCellTypeUnselected,
}PersonalCenterCellType;

@interface PersonalCenterTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *itemName;
@property (strong, nonatomic) IBOutlet ITTImageView *personImageView;
@property (strong, nonatomic) IBOutlet UILabel *personInfo;
@property (assign, nonatomic) PersonalCenterCellType type;
+ (PersonalCenterTableViewCell *)cellFromNib;
@end
