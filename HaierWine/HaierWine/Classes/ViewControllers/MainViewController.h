//
//  MainViewController.h
//  iTotemMinFramework
//
//  Created by  on 12-8-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopExchangeView.h"
#import "UIViewController+CWPopup.h"
#import "iCarousel.h"
#import "TemperatureView.h"
#import "WineManager.h"
#import "LoginManager.h"
#import "ScanningCodeViewController.h"

@interface MainViewController : UIViewController<TopExchangeDelegate,UIScrollViewDelegate,iCarouselDataSource,iCarouselDelegate,temperatureDelegate,WineManagerDelegate,WineManagerDelegate,ScanningCodeDelegate,CommonAlertViewDelegate,LoginDelegate>
@property(nonatomic,assign)BOOL isWineBox;
@property(nonatomic,assign)BOOL isNoShowLogin;
-(void)showTemperature;
@end
