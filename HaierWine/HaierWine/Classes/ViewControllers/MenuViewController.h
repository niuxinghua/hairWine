//
//  MenuViewController.h
//  HaierWine
//
//  Created by leon on 14-6-26.
//
//

#import <UIKit/UIKit.h>
#import "CommomAlertView.h"
#import "LoginViewController.h"
#import "MainViewController.h"
@protocol MenuViewControllerDelegate <NSObject>

- (void)menuButtonClick:(NSInteger)tag;

@end

@interface MenuViewController : UIViewController<CommonAlertViewDelegate,LoginDelegate>

@property (nonatomic,assign)id<MenuViewControllerDelegate> delegate;
@property (nonatomic,strong)MainViewController *mainViewController;
+ (MenuViewController *)getMenuViewController;
- (void)showHomeViewControllerWith:(BOOL)left;
- (void)showDetailMessageController;

@end
