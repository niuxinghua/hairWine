//
//  HelpMeDetailViewController.h
//  HaierWine
//
//  Created by david on 14/8/14.
//
//

#import <UIKit/UIKit.h>
#import "ITTImageView.h"
@interface HelpMeDetailViewController : UIViewController
@property(nonatomic,strong)IBOutlet ITTImageView *imageView;
@property(nonatomic,strong)IBOutlet UILabel *titleLabel;
@property(nonatomic,strong)IBOutlet UILabel *contentLabel;
@property(nonatomic,strong)NSString *titleString;
@property(nonatomic,strong)NSString *contentString;
@property(nonatomic,strong)NSString *contentImage;


@end
