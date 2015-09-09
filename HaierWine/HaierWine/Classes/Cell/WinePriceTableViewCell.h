//
//  WinePriceTableViewCell.h
//  HaierWine
//
//  Created by isoftstone on 14-7-14.
//
//

#import <UIKit/UIKit.h>

@interface WinePriceTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *wineNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *winePriceLabel;

+(WinePriceTableViewCell *)cellFromNib;

@end
