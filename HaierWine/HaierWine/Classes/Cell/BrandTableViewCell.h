//
//  BrandTableViewCell.h
//  HaierWine
//
//  Created by david on 14/7/14.
//
//

#import <UIKit/UIKit.h>
#import "BrandModel.h"
@interface BrandTableViewCell : UITableViewCell
-(void)fillCellWithModel:(BrandModel *)model;
+(BrandTableViewCell *)cellFromNib;

@end
