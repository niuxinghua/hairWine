//
//  LoginViewController.h
//  登陆
//
//  Created by isoftstone on 14-6-27.
//  Copyright (c) 2014年 isoftstone. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoginDelegate <NSObject>

- (void)loginSuccess;

@end


@interface LoginViewController : UIViewController
@property (nonatomic,assign)id <LoginDelegate> delegate;
@property (nonatomic,assign) BOOL isDetailWine;
@end
