//
//  SearchTableViewCell.h
//  HaierWine
//
//  Created by 张作伟 on 14-9-1.
//
//

#import <UIKit/UIKit.h>

@interface SearchTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *Namelabel;
+ (SearchTableViewCell *)cellFromNib;

@end
