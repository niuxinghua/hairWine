//
//  ExperienceViewController.h
//  HaierWine
//
//  Created by david on 14/7/31.
//
//

#import <UIKit/UIKit.h>

@interface ExperienceViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,ITTPullTableViewDelegate>

@property (nonatomic,assign) BOOL isHomePage;

@end
