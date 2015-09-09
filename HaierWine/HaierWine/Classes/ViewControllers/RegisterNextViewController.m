//
//  RegisterNextViewController.m
//  haierwine--接口测试
//
//  Created by isoftstone on 14-7-4.
//  Copyright (c) 2014年 isoftstone. All rights reserved.
//

#import "RegisterNextViewController.h"
#import "AuthcodeManager.h"
#import "LoginManager.h"
//#import "UserInfoManager.h"
//#import "PersonInfoManager"
@interface RegisterNextViewController ()
{
    IBOutlet UIButton    *_EnterButton;
    IBOutlet UIButton    *_authcodeButton;
    IBOutlet UITextField *_authcodeTextField;
    IBOutlet UILabel     *_alertLabel;
    NSString             *_transactionId;
    NSTimer              *_timer;
    BOOL                  _getcodeEnable;
    int                   _counter;
}
@end

@implementation RegisterNextViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _counter = 60;
    [self initTimerAndFire];
    [_authcodeTextField setValue:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.5] forKeyPath:@"_placeholderLabel.textColor"];
    if(is4InchScreen()){
        //_registButton.top = 507;
        _EnterButton.top = 280;
       // _registerBgView.top = 69;
    } else {
       // _registerBgView.top = 69-44;
        
        _EnterButton.top = 244+88;
    }

}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if ([_timer isValid]) {
        [_timer invalidate];
    }
}
- (void)initTimerAndFire
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(againGetAuthcode) userInfo:nil repeats:YES];
    [_timer fire];
    _getcodeEnable = NO;
    _authcodeButton.enabled = NO;
}

#pragma mark - alertView

- (void)showAlertWithMessage:(NSString *)message
{
    _alertLabel.text = message;
    [UIView animateWithDuration:0.5 animations:^{
        _alertLabel.frame = CGRectMake(0, 0, 270, 27);
    } completion:^(BOOL finished) {
        
    }];
}

- (void)hiddenAlertView
{
    [UIView animateWithDuration:0.5 animations:^{
        _alertLabel.frame = CGRectMake(0, -27, 270, 27);
    } completion:^(BOOL finished) {
        
    }];
}

- (void)againGetAuthcode
{
    --_counter;
    if (_counter == 0) {
        [_timer invalidate];
        _counter = 60;
        _authcodeButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_authcodeButton setTitle:@"获取激活码" forState:UIControlStateNormal];
        //_authcodeButton.titleLabel.text = @"获取激活码";
        _getcodeEnable = YES;
        _authcodeButton.enabled = YES;
        return;
    }
   // _authcodeButton.contentEdgeInsets = UIEdgeInsetsMake(0, -5, 0, -5);
    [_authcodeButton setTitle:[NSString stringWithFormat:@"%d秒倒计时",_counter] forState:UIControlStateDisabled];
  //  _authcodeButton.titleLabel.text = [NSString stringWithFormat:@"%d秒倒计时",_counter];
    _authcodeButton.titleLabel.textAlignment = NSTextAlignmentCenter;
}
#pragma mark - navigationBar

- (IBAction)backButtonClick:(id)sender
{
    if ([_timer isValid]) {
        [_timer invalidate];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - userAction

- (IBAction)getActivityCode:(id)sender
{
    if (_getcodeEnable) {
        [self initTimerAndFire];
        
        [AuthcodeManager GetAuthcodeByMobile:_mobile validateScene:1 completion:^(BOOL isSuccess, NSString *returnMsg){
            if (isSuccess) {
                _transactionId = returnMsg;
                //发送成功以后激活码短信已发送至手机,请查收
                //[UIAlertView popupAlertByDelegate:nil title:@"提示" message:@"激活码短信已发送至手机,请查收" cancel:@"确定" others:nil];
                [self showAlertWithMessage:@"激活码短信已发送至手机,请查收"];
                
            }else{
                //[UIAlertView popupAlertByDelegate:nil title:@"提示" message:returnMsg cancel:@"确定" others:nil];
                [self showAlertWithMessage:returnMsg];
                return ;
            }
        }];
    }

}

- (IBAction)registerCompletion:(id)sender
{
   //  [self.navigationController popToRootViewControllerAnimated:YES];
    if (_transactionId==nil||_transactionId.length == 0) {
        _transactionId = @"";
    }
    [AuthcodeManager verifyAuthcodeByMobile:_mobile authcode:_authcodeTextField.text transactionId:_transactionId validateScene:1 completion:^(BOOL isSuccess, NSString *returnMsg) {
        if (isSuccess) {
            //[UIAlertView popupAlertByDelegate:nil title:nil message:@"注册成功"];
            [self showAlertWithMessage:@"注册成功"];
  //          [NSThread sleepForTimeInterval:2];
            [self.navigationController popToRootViewControllerAnimated:YES];

        } else {
           // [UIAlertView popupAlertByDelegate:nil title:@"提示" message:returnMsg cancel:@"确定" others:nil];
            [self showAlertWithMessage:@"激活码错误"];
        }
        
    }];
    
}

- (void)cacheAccount
{
    NSDictionary * dict = @{@"account":_mobile,@"password":_password};
    UserModel * userModel = [[UserModel alloc]initWithDataDic:dict];
    [[UserManager sharedUserManager] addUser:userModel];
#warning - 保存登录状态
    DATA_ENV.isLocalOnline = YES;
    
}

#pragma mark - textFieldDelegate
- (IBAction)finishEdit:(id)sender
{
    [_authcodeTextField resignFirstResponder];
    [self hiddenAlertView];
}

#pragma mark - tapView

- (IBAction)tapView:(id)sender
{
    [_authcodeTextField resignFirstResponder];
    [self hiddenAlertView];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
