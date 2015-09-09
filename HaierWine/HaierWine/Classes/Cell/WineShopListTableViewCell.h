//
//  WineShopListTableViewCell.h
//  HaierWine
//
//  Created by 张作伟 on 14-8-12.
//
//

#import <UIKit/UIKit.h>

@interface WineShopListTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *lookLabel;
@property (strong, nonatomic) IBOutlet UILabel *wineShopName;
@property (strong, nonatomic) IBOutlet UILabel *winePrice;
@property (strong, nonatomic) IBOutlet UILabel *winepriceDtail;


+ (WineShopListTableViewCell *)cellFromNib;

@end
