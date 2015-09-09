//
//  NextSearchWineViewController.h
//  HaierWine
//
//  Created by isoftstone on 14-7-26.
//
//

#import <UIKit/UIKit.h>
#import "DeleteAlertView.h"


@interface NextSearchWineViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,DeleteAlertViewDelegate>

@property (nonatomic,strong) NSString *wineNameDefault;
@property (nonatomic,assign) BOOL     isShowKeyboard;

@end
