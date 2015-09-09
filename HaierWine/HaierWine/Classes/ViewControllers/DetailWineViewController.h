//
//  DetailWineViewController.h
//  HaierWine
//
//  Created by isoftstone on 14-7-7.
//
//

#import <UIKit/UIKit.h>
#import "DetailSelectButtonView.h"
#import "UIViewController+CWPopup.h"
#import "DetailWinePicVIew.h"
#import "DetailDescribeView.h"
#import "VegetableView.h"
#import "OriginView.h"
#import "bandingAlertView.h"
#import "DetailWineButtonView.h"
@interface DetailWineViewController : UIViewController<DetailSelectButtonDelegate,UIAlertViewDelegate,DetailDescribeViewDelegate,UITextViewDelegate,VegetableViewDelegate,CommonAlertViewDelegate,LoginDelegate,OriginDelegate,bandingAlertViewDelegate,DetailWineButtonViewDelegate>

@property (strong,nonatomic)NSString *wineName;
@property (strong,nonatomic)NSString *wineID;
@property (assign,nonatomic)BOOL     isScan;
@end
