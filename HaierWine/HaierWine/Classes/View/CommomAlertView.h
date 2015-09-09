//
//  CommomAlertView.h
//  HaierWine
//
//  Created by david on 14/8/29.
//
//

#import "ITTXibView.h"
#import "LoginViewController.h"

@protocol CommonAlertViewDelegate <NSObject>

- (void)CommonAlertViewClickedWithTag:(NSInteger)tag;

@end

@interface CommomAlertView : ITTXibView<LoginDelegate>
@property (nonatomic,assign)id<CommonAlertViewDelegate> delegate;
@property(nonatomic,strong)IBOutlet UILabel *textLabel;

+ (void)popAlertInViewController:(id)viewController isMenuController:(BOOL)isOrNo andAlertMessage:(NSString *)message;

@end
