//
//  DeviceNameViewController.h
//  HaierWine
//
//  Created by 张作伟 on 14-8-11.
//
//

#import <UIKit/UIKit.h>
#import "DeleteAlertView.h"

@protocol DeviceNameDelegate <NSObject>

- (void)modifyDeviceName:(NSString *)deviceName;

@end

@interface DeviceNameViewController : UIViewController<UITextFieldDelegate,DeleteAlertViewDelegate>

@property (nonatomic,assign) id<DeviceNameDelegate> delegate;
@property (nonatomic,strong) NSString *deviceName;
@property (nonatomic,assign) BOOL  isModefyName;
@end
