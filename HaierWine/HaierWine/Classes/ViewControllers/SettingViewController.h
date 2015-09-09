//
//  SettingViewController.h
//  HaierWine
//
//  Created by isoftstone on 14-7-14.
//
//

#import <UIKit/UIKit.h>
#import "UpdateAlertView.h"
#import "LoginManager.h"
#import "FeedBackAndUpdateAlertView.h"
@protocol SettingViewControllerDelegate <NSObject>

- (void)showHomeViewController;

@end

@interface SettingViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate,UpdateAlertViewDelegate,CommonAlertViewDelegate,LoginDelegate>

@property (nonatomic ,assign) id<SettingViewControllerDelegate>delegate;

@end
