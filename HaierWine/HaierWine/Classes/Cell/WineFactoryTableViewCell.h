//
//  WineFactoryTableViewCell.h
//  HaierWine
//
//  Created by 张作伟 on 14-8-13.
//
//

#import <UIKit/UIKit.h>
#import "ITTImageView.h"
@interface WineFactoryTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet ITTImageView *winePicURL;

@property (strong, nonatomic) IBOutlet UILabel *wineName;

@property (strong, nonatomic) IBOutlet UILabel *winePrice;

+ (WineFactoryTableViewCell *)cellFromNib;

@end
