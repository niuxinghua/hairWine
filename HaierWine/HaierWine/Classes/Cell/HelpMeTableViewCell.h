//
//  HelpMeTableViewCell.h
//  HaierWine
//
//  Created by david on 14/8/11.
//
//

#import <UIKit/UIKit.h>
#import "HelpMeModel.h"
@interface HelpMeTableViewCell : UITableViewCell
@property (nonatomic,strong)IBOutlet UILabel *numLabel;
@property (nonatomic,strong)IBOutlet UIView *numView;
@property (nonatomic,strong)IBOutlet UILabel *titleLabel;
+(HelpMeTableViewCell *)cellFromNib;
-(void)fillCellWithModel:(HelpMeModel *)model andindexPath:(NSIndexPath *)indexPath;
@end
