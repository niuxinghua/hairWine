//
//  FamousParkWineTableViewCell.h
//  HaierWine
//
//  Created by david on 14/7/14.
//
//

#import <UIKit/UIKit.h>
#import "FamousParkWineModel.h"
@interface FamousParkWineTableViewCell : UITableViewCell

-(void)fillCellWithModel:(FamousParkWineModel *)model;
+(FamousParkWineTableViewCell *)cellFromNib;
@end
