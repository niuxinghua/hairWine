//
//  WebViewController.h
//  HaierWine
//
//  Created by 张作伟 on 14-8-20.
//
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController<UIWebViewDelegate>

@property (nonatomic,strong)NSString *titleName;
@property (nonatomic,assign)NSInteger     type;
@end
