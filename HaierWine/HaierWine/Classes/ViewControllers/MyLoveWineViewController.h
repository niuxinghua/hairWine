//
//  MyLoveWineViewController.h
//  HaierWine
//
//  Created by isoftstone on 14-7-21.
//
//

#import <UIKit/UIKit.h>
#import "MyLoveWine.h"
#import "DeleteAlertView.h"

@interface MyLoveWineViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate,ITTPullTableViewDelegate,DeleteAlertViewDelegate>

@property(nonatomic,strong)NSString *navTitle;
@property(nonatomic,strong)NSString *imageName;
@property(nonatomic,strong)NSString *text;
@property(nonatomic,strong)NSString *type;
//1 用户浏览 2我的爱酒
@end
