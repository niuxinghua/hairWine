//
//  TemperatureTableViewCell.h
//  HaierWine
//
//  Created by david on 14/7/15.
//
//

#import <UIKit/UIKit.h>

@interface TemperatureTableViewCell : UITableViewCell
@property(nonatomic,strong)IBOutlet UILabel *comsumerLabel;

@property(nonatomic,strong)IBOutlet UILabel *shakeLabel;
+ (TemperatureTableViewCell *)loadCell;
@end
