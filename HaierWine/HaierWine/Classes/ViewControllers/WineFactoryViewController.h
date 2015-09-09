//
//  WineFactoryViewController.h
//  HaierWine
//
//  Created by isoftstone on 14-7-14.
//
//

#import <UIKit/UIKit.h>

@interface WineFactoryViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property (nonatomic,strong) NSString *type;
//0 名酒庄 1 品牌会
@property (nonatomic,strong) NSString *wineFactoryID;
@property (nonatomic,strong) NSString *factoryName;

@end
