//
//  WineShopDetailViewController.h
//  HaierWine
//
//  Created by 张作伟 on 14-8-12.
//
//

#import <UIKit/UIKit.h>

@interface WineShopDetailViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)NSString *shopId;
@end
