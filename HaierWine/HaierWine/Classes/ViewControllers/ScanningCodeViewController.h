//
//  ScanningCodeViewController.h
//  LingZhi
//
//  Created by boguoc on 14-2-27.
//
//

#import <UIKit/UIKit.h>
#import "ZXingObjC.h"
#import "ScanAlertView.h"
@protocol ScanningCodeDelegate <NSObject>

- (void)showWineControl;

@end

@interface ScanningCodeViewController : UIViewController<ZXCaptureDelegate,UIAlertViewDelegate,ScanAlertViewDelegate>
@property(nonatomic,weak) id<ScanningCodeDelegate> delegate;
@property(nonatomic,strong) NSString *formWhere;
//0 首页进入 1控酒页面进入

@end
