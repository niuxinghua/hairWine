//
//  WineKindTableViewCell.h
//  HaierWine
//
//  Created by david on 14/7/15.
//
//

#import <UIKit/UIKit.h>

@interface WineKindTableViewCell : UITableViewCell
@property(nonatomic,strong)IBOutlet UILabel *customLabel;

+ (WineKindTableViewCell *)loadCell;
@end
