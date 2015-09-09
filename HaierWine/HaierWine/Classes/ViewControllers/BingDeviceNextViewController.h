//
//  BingDeviceNextViewController.h
//  HaierWine
//
//  Created by isoftstone on 14-7-28.
//
//

#import <UIKit/UIKit.h>
#import "WineManager.h"
#import "bindingProgressView.h"
#import "CityViewController.h"
#import "DeviceNameViewController.h"
#import "MyAlertView.h"
@interface BingDeviceNextViewController : UIViewController<UITextFieldDelegate,CityListDelegate,UIAlertViewDelegate,WineManagerDelegate,bindingProgressViewDelegate,DeviceNameDelegate,MyAlertViewDelegate>


@end
