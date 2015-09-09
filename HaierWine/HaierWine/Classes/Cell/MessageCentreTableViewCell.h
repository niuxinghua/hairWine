//
//  MessageCentreTableViewCell.h
//  HaierWine
//
//  Created by david on 14/8/13.
//
//

#import <UIKit/UIKit.h>

@interface MessageCentreTableViewCell : UITableViewCell
@property(nonatomic,strong)IBOutlet UILabel *upLineLabel;
@property(nonatomic,strong)IBOutlet UIImageView *pointNewsImageVeiw;//普通推送消息 1
@property(nonatomic,strong)IBOutlet UIImageView *pointAlertImageView;//警告消息 0
@property(nonatomic,strong)IBOutlet UIImageView *pointAdImageView;//警告已读消息 2
@property(nonatomic,strong)IBOutlet UIImageView *newsReadedImageView;//普通推送消息已读消息 3

@property(nonatomic,strong)IBOutlet UIImageView *narrowImageView;
@property(nonatomic,strong)IBOutlet UILabel *downLineLabel;
@property(nonatomic,strong)IBOutlet UIImageView *editImageView;
@property(nonatomic,strong)IBOutlet UIImageView *editSelectedImageView;
@property(nonatomic,strong)IBOutlet UILabel *contentLabel;
@property(nonatomic,strong)IBOutlet UILabel *dateLabel;
+(MessageCentreTableViewCell *)cellFromNib;
@end
