//
//  NewsViewController.h
//  HaierWine
//
//  Created by david on 14/7/23.
//
//

#import <UIKit/UIKit.h>

@interface NewsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,ITTPullTableViewDelegate>

@property (nonatomic,assign) BOOL isHomePage;

@end
