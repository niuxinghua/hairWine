//
//  WhiteBoardTableViewCell.h
//  HaierWine
//
//  Created by david on 14/7/29.
//
//

#import <UIKit/UIKit.h>

@interface WhiteBoardTableViewCell : UITableViewCell
@property(nonatomic,strong)IBOutlet UIImageView * colorImageView;
@property(nonatomic,strong)IBOutlet UILabel *colorNameLabel;
@property(nonatomic,strong)IBOutlet UIView  *colorView;
@property(nonatomic,strong)IBOutlet UIView  *colorRectView;
@property(nonatomic,strong)IBOutlet UIView  *animationView;
+(WhiteBoardTableViewCell *)cellFromNib;
@end
