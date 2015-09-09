//
//  FirstHelpViewController.h
//  HaierWine
//
//  Created by david on 14/8/5.
//
//

#import <UIKit/UIKit.h>

@protocol FirstHelpViewControllerDelegate <NSObject>

- (void)didClickNowButton;

@end

@interface FirstHelpViewController : UIViewController<UIScrollViewDelegate>

@property(nonatomic,assign)id<FirstHelpViewControllerDelegate> delegate;

@end
