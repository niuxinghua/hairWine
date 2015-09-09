//
//  LoginViewController.m
//  登陆
//
//  Created by isoftstone on 14-6-27.
//  Copyright (c) 2014年 isoftstone. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
//#import "ResetPasswordViewController.h"
#import "ChangePasswordViewController.h"
#import "LoginRequest.h"
#import "LoginManager.h"
#import "DemoDataRequest.h"
#import "LoginAnimationView.h"
#import "AppDelegate.h"
#import "MenuViewController.h"
#import "PKRevealController.h"
#import "UserInfoManager.h"
#import "WebViewController.h"
#import "LoginErrorMoreManager.h"
#import "RegisterNextViewController.h"
#import "AuthcodeManager.h"

@interface LoginViewController ()
{
    IBOutlet UITextField   *_userNameTextField;
    IBOutlet UITextField   *_userPasswordTextField;
    IBOutlet UILabel       *_AlertLabel;
    IBOutlet UIView        *_contentView;
    IBOutlet UIButton      *_registerButton;
    IBOutlet UIView        *_backgroundView;
    IBOutlet UIButton      *_isAutoLogin;
    IBOutlet UIButton      *_loginButton;
    IBOutlet UIButton      *_noLoginButton;
    
    UIView                 *_loginStatueBackgroundView;
    BOOL                   _isShowPassword;
    LoginAnimationView     *_loginAnimationView;
    
}
@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
   // [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldViewDidChange1:) name:UITextFieldTextDidChangeNotification object: nil];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBarHidden = YES;
    [_userNameTextField setValue:[UIColor colorWithRed:1 green:1 blue:1 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    [_userPasswordTextField setValue:[UIColor colorWithRed:1 green:1 blue:1 alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
    //[_userNameTextField setValue:@11 forKey:@"limit"];
   // [_userPasswordTextField setValue:@16 forKey:@"limit"];
    _isShowPassword = YES;
    _loginAnimationView = [LoginAnimationView loadFromXib];
    _loginAnimationView.top = 70;
    _loginAnimationView.left = 25;
    [_backgroundView addSubview:_loginAnimationView];
    _loginAnimationView.hidden = YES;
   // DATA_ENV.isAutoLogin = YES;
    if(is4InchScreen()){
        //_registButton.top = 507;
        _registerButton.frame = CGRectMake(58, 508, 205, 40);
        _loginButton.top = 280;
        _noLoginButton.top = 353;
    } else {
        _loginButton.top = 244+88;
        _noLoginButton.top = 299+88;
        _registerButton.frame = CGRectMake(58, 516, 205, 40);
    }
    if (DATA_ENV.isAutoLogin == YES) {
        _isAutoLogin.selected = YES;
    } else {
        _isAutoLogin.selected = NO;

    }
   // NSLog(@"登录名--%@",DATA_ENV.userName);
    if (DATA_ENV.userName.length>0) {
      //  [_userNameTextField becomeFirstResponder];
        _userNameTextField.text = DATA_ENV.userName;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.navigationController.revealController.recognizesPanningOnFrontView = NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.revealController.recognizesPanningOnFrontView = YES;

}

//- (void)textFieldViewDidChange1:(NSNotification *)noti
//{
//    UITextField *textField = (UITextField *)noti.object;
//    if (textField.text.length > 11 && textField.markedTextRange == nil) {
//        textField.text = [textField.text substringWithRange: NSMakeRange(0,11)];
//    }
//}

- (IBAction)tapView:(id)sender
{
    [self hiddenAlertView];
    [_userNameTextField resignFirstResponder];
    [_userPasswordTextField resignFirstResponder];
    [UIView animateWithDuration:0.2 animations:^{
        CGAffineTransform viewTransform = CGAffineTransformMakeTranslation(0,0);
        self.view.transform = viewTransform;
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - loginAndRegister

- (IBAction)login:(id)sender
{
//    NSString *userID = _userNameTextField.text;
//    NSString *userPassword = [_userPasswordTextField.text md5];
    
    if (_userNameTextField.text.length==0||_userNameTextField.text.length<11) {
        [self showAlertWithMessage:@"手机号错误，请重新输入！"];
        return;
    } else if ([self checkPhoneNumber:_userNameTextField.text]){
        [self showAlertWithMessage:@"手机号错误，请重新输入！"];
        return;
    } else if (_userPasswordTextField.text.length==0||_userPasswordTextField.text.length<6) {
        [self showAlertWithMessage:@"密码输入错误，请重新输入！"];
        return;
    } else if ([self checkPassWord:_userPasswordTextField.text]) {
        [self showAlertWithMessage:@"密码输入错误，请重新输入！"];
        return;
    }
    [_contentView removeFromSuperview];
    [_registerButton removeFromSuperview];
    

    _loginAnimationView.hidden = NO;
    DATA_ENV.userName = _userNameTextField.text;
    if (DATA_ENV.isAutoLogin){
        DATA_ENV.userPassword = _userPasswordTextField.text;
    } else {
        DATA_ENV.userPassword = nil;
     //   DATA_ENV.userName = nil;
    }
  //  NSLog(@"自动登录---%@--%@",DATA_ENV.userName,DATA_ENV.userPassword);
    [LoginManager loginRequestWithLoginID:_userNameTextField.text password:_userPasswordTextField.text isAutoLogin:NO completion:^(BOOL isSuccess, NSString *returnMsg) {
        if (isSuccess){
          //  DATA_ENV.isVistor = NO;
//            _loginAnimationView.hidden = YES;
//            [_backgroundView addSubview:_contentView];
//            [_backgroundView addSubview:_registerButton];
#warning isBindingDevice
 //           DATA_ENV.isBindingDevice = YES;
            NSDictionary *userDict = @{@"phoneNumber": DATA_ENV.userName,
                                   @"appId"      : DATA_ENV.userid,
                                   @"type"       : @"ios"};
            [SaveUserInfoRequest requestWithParameters:userDict withIndicatorView:nil withCancelSubject:nil onRequestStart:nil onRequestFinished:^(ITTBaseDataRequest *request) {
                
            } onRequestCanceled:nil onRequestFailed:^(ITTBaseDataRequest *request) {
                
            }];
            if (_isDetailWine) {
                [self performSelector:@selector(goToHomePage) withObject:nil afterDelay:5];
            } else {
                
                [self goToHomePage];
            }
        } else {
            _loginAnimationView.hidden = YES;
           // [_loginAnimationView removeFromSuperview];
            [_backgroundView addSubview:_contentView];
            [_backgroundView addSubview:_registerButton];
            if ([returnMsg isEqualToString:@"22109"]||[returnMsg isEqualToString:@"22820"]) {
                LoginErrorMoreManager *loginErrorManager = [LoginErrorMoreManager sharedLoginErrorMoreManager];
            BOOL ErrorResult = [loginErrorManager judgeByUser: _userNameTextField.text password:_userPasswordTextField.text currDate:[NSDate date]];
                if (ErrorResult) {
                    [self showAlertWithMessage:@"您输入密码次数过多，请2分钟后再试"];

                } else {
                [self showAlertWithMessage:@"手机号或密码错误"];
                }
            } else if ([returnMsg isEqualToString:@"2"]){
            [self showAlertWithMessage:@"网络连接失败，请检查"];
            }if([returnMsg isEqualToString:@"22113"]||[returnMsg isEqualToString:@"22115"]){
                [self showAlertWithMessage:@"帐号未激活"];
                
                [self performSelector:@selector(goActivityView) withObject:nil afterDelay:3];
            }if([returnMsg isEqualToString:@"00011"]){
                [self showAlertWithMessage:@"网络超时"];

            }
            //网络超时00011;
        }
        
    }];

}
- (void)goActivityView
{
    [self hiddenAlertView];
    [AuthcodeManager GetAuthcodeByMobile:_userNameTextField.text validateScene:1 completion:^(BOOL isSuccess, NSString *returnMsg){
//        if (isSuccess) {
////            _transactionId = returnMsg;
////        }else{
////            return ;
//        }
    }];

    RegisterNextViewController *rnv = [[RegisterNextViewController alloc]init];
    rnv.mobile =_userNameTextField.text;
    [self.navigationController pushViewController:rnv animated:YES];
}
//
//#pragma mark - getPersonalRequest
//- (void)getPersonalRequest
//{
//    [UserInfoManager queryUserInfoWhenCompletion:^(BOOL isSuccess, id responseObject) {
//        [self getUserBindingDevice];
//    }];
//}
//
//#pragma mark - getUserBindingDevice
//
//- (void)getUserBindingDevice
//{
//    [UserInfoManager getUserDeviceWhenCompletion:^(BOOL isSuccess, id responseObject) {
//        _loginAnimationView.hidden = YES;
//        [_backgroundView addSubview:_contentView];
//        [_backgroundView addSubview:_registerButton];
//        if(DATA_ENV.device)
//        {
//            uSDKErrorConst error = [[WineManager shareWineManager] startHaierUSDK];
//            
//            if (error == RET_USDK_OK) {
//                [NSThread sleepForTimeInterval:1];
//                NSArray *array = [[uSDKDeviceManager getSingleInstance] getDeviceList:0];
//                NSLog(@"uuuuuu%@",array);
//                for(uSDKDevice *device in array){
//                  //  NSLog(@"%@----%@",device.mac,DATA_ENV.device.deviceMac);
//                    if([device.mac isEqualToString:DATA_ENV.deviceMac])
//                       [[WineManager shareWineManager] SubscribeDeviceWithDeviceMac:DATA_ENV.deviceMac];
//                }
//                
//            }
//            
//        }
//        DATA_ENV.isVistor = NO;
//        [self goToHomePage];
//    }];
//}

- (IBAction)beginEdite:(id)sender {
    [self hiddenAlertView];
}

- (IBAction)finishEdite:(id)sender
{
    [_userPasswordTextField resignFirstResponder];
    [_userNameTextField resignFirstResponder];
    [UIView animateWithDuration:0.3 animations:^{
        CGAffineTransform viewTransform = CGAffineTransformMakeTranslation(0,0);
        self.view.transform = viewTransform;
    } completion:^(BOOL finished) {
        
    }];
}

- (IBAction)userRegister:(id)sender
{
    RegisterViewController *rvc = [[RegisterViewController alloc]init];
//    UINavigationController *nvc = [[UINavigationController alloc]initWithRootViewController:rvc];
//    [self presentViewController:nvc animated:NO completion:^{
//        
//    }];
    [self.navigationController pushViewController:rvc animated:YES];
}

- (IBAction)findPassword:(id)sender
{
    WebViewController *wvc = [[WebViewController alloc]init];
    wvc.titleName = @"重置密码";
    wvc.type = 1;
    [self.navigationController pushViewController:wvc animated:YES];
//    ResetPasswordViewController *resetPasswordViewController = [[ResetPasswordViewController alloc]init];
//    [self.navigationController pushViewController:resetPasswordViewController animated:YES];
    
}

- (IBAction)isShowPassword:(id)sender
{
    UIButton *button = (UIButton *)sender;
    _isShowPassword = !_isShowPassword;
    if (_isShowPassword) {
       // _userPasswordTextField.secureTextEntry = NO;
        DATA_ENV.isAutoLogin = YES;
        _isAutoLogin.selected = YES;
        [button setImage:[UIImage imageNamed:@"show_password_yes.png"] forState:UIControlStateNormal];
        
    } else{
      //  _userPasswordTextField.secureTextEntry = YES;
        DATA_ENV.isAutoLogin = NO;
        _isAutoLogin.selected = NO;
        [button setImage:[UIImage imageNamed:@"show_password_no.png"] forState:UIControlStateNormal];
    }
}

#pragma mark - alertView

- (void)showAlertWithMessage:(NSString *)message
{
    _AlertLabel.text = message;
    [UIView animateWithDuration:0.5 animations:^{
        _AlertLabel.frame = CGRectMake(0, 0, 270, 27);
    } completion:^(BOOL finished) {
        
    }];
}

- (void)hiddenAlertView
{
    [UIView animateWithDuration:0.5 animations:^{
        _AlertLabel.frame = CGRectMake(0, -27, 270, 27);
    } completion:^(BOOL finished) {
        
    }];
}
#pragma mark - visitorBrowse

- (IBAction)visitorBrowse:(id)sender
{
    DATA_ENV.isVistor = YES;
    DATA_ENV.userid = @"0";
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark - goToHomePage

- (void)goToHomePage
{
//    AppDelegate *delegate =  [[UIApplication sharedApplication] delegate];
//    delegate.revealController.modalTransitionStyle = 2;
//    [self presentViewController:delegate.revealController animated:YES completion:^{
//        
//    }];
   // [self.navigationController popViewControllerAnimated:NO];
    [self dismissModalViewControllerAnimated:YES];
    [self performSelector:@selector(viewBack) withObject:nil afterDelay:0.3];

}

- (void)viewBack
{
    [_delegate loginSuccess];

}

#pragma mark - checkPhoneNumInput

- (BOOL)checkPhoneNumber:(NSString *)string
{
    NSCharacterSet *nameCharacters = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    //_abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ@.
    NSRange userNameRange = [string rangeOfCharacterFromSet:nameCharacters];
    NSString *firstNumber = [string substringToIndex:1];
//    NSLog(@"####%@",firstNumber);
    if (userNameRange.location != NSNotFound) {
        // NSLog(@"包含特殊字符");
        return YES;
    } else if (![firstNumber isEqualToString:@"1"]){
        return YES;
    }
    return NO;
}

- (BOOL)checkPassWord:(NSString *)string
{
    NSCharacterSet *nameCharacters = [[NSCharacterSet characterSetWithCharactersInString:@"_abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"] invertedSet];
    
    NSRange userNameRange = [string rangeOfCharacterFromSet:nameCharacters];
    if (userNameRange.location != NSNotFound) {
        // NSLog(@"包含特殊字符");
        return YES;
    }
    return NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
