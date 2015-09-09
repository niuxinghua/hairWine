//
//  MyLoveWineTableViewCell.h
//  HaierWine
//
//  Created by isoftstone on 14-7-21.
//
//

#import <UIKit/UIKit.h>
#import "ITTImageView.h"
@interface MyLoveWineTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet ITTImageView *wineImageView;
@property (strong, nonatomic) IBOutlet UILabel *wineNameLabel;
@property (strong,nonatomic) IBOutlet UIImageView *editImageView;
@property (strong,nonatomic) IBOutlet UIImageView *editImageViewSelected;
@property(strong,nonatomic)IBOutlet UIImageView *narrowImageView;
+(MyLoveWineTableViewCell *)cellFromNib;
- (void)setChecked:(BOOL)checked;

@end
