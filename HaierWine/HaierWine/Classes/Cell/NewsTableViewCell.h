//
//  NewsTableViewCell.h
//  HaierWine
//
//  Created by david on 14/7/23.
//
//

#import <UIKit/UIKit.h>
#import "NewsModel.h"
@interface NewsTableViewCell : UITableViewCell
@property(nonatomic,strong)IBOutlet UILabel *newsTitleLabel;
@property(nonatomic,strong)IBOutlet UILabel *newsDateLabel;
@property(nonatomic,strong)IBOutlet ITTImageView *newsImageView;
-(void)fillCellWithModel:(NewsModel *)model;
+(NewsTableViewCell *)cellFromNib;

@end
