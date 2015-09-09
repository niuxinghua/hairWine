//
//  AppDelegate.h
//  iTotemMinFramework
//
//  Created by  on 12-8-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "mainViewController.h"
#import "FirstHelpViewController.h"
@class PKRevealController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong, readwrite) PKRevealController *revealController;
@property (strong,nonatomic) ITTImageView *splashView;

+ (AppDelegate *)getAppDelegate;

@end
