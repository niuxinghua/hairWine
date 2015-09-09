//
//  MessageCentreViewController.h
//  HaierWine
//
//  Created by david on 14/8/11.
//
//

#import <UIKit/UIKit.h>
#import "MessageCentreTableViewCell.h"
#import "DeleteAlertView.h"
@interface MessageCentreViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate,DeleteAlertViewDelegate>
@property (nonatomic,assign) BOOL isDetail;

@end
