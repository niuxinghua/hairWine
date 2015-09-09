//
//  ChangePasswordViewController.m
//  登陆
//
//  Created by isoftstone on 14-6-29.
//  Copyright (c) 2014年 isoftstone. All rights reserved.
//

#import "ChangePasswordViewController.h"
//#import "ChangePassword.h"
#import "PasswordManager.h"
@interface ChangePasswordViewController ()
{
    IBOutlet UITextField *_oldPassWordTextField;
    
    IBOutlet UITextField *_newPasswordField;
    
    IBOutlet UITextField *_newPasswordAgainField;
    
    IBOutlet UILabel     *_alertLabel;
    
}
@end

@implementation ChangePasswordViewController

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
   // [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.navigationController.navigationBarHidden = YES;
     [_oldPassWordTextField setValue:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.5] forKeyPath:@"_placeholderLabel.textColor"];
   // [_oldPassWordTextField setValue:@16 forKey:@"limit"];
     [_newPasswordField setValue:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.5] forKeyPath:@"_placeholderLabel.textColor"];
   // [_newPasswordField setValue:@16 forKey:@"limit"];

     [_newPasswordAgainField setValue:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.5] forKeyPath:@"_placeholderLabel.textColor"];
  //  [_newPasswordAgainField setValue:@16 forKey:@"limit"];

    _alertLabel.hidden = YES;
}

#pragma mark - navigationButton

- (IBAction)backClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - changPassword
- (IBAction)confirm:(id)sender
{
    if (_oldPassWordTextField.text.length == 0) {
        [self showAlertWithMessage:@"当前所用密码不能为空"];
        return;

    }else if (_oldPassWordTextField.text.length<6 || _oldPassWordTextField.text.length>32)
    {
        // [UIAlertView popupAlertByDelegate:nil title:@"提示" message:@"您输入的密码应为6~32位，请重新输入"];
        [self showAlertWithMessage:@"当前所用密码错误"];
        return ;
    }else if (_newPasswordField.text == 0){
        // [UIAlertView popupAlertByDelegate:nil title:@"提示" message:@"您输入的密码应为6~32位，请重新输入"];
        [self showAlertWithMessage:@"新密码不能为空"];
        return ;
    } else if (_newPasswordField.text.length<6 || _newPasswordField.text.length>32)
    {
       // [UIAlertView popupAlertByDelegate:nil title:@"提示" message:@"您输入的密码应为6~32位，请重新输入"];
        [self showAlertWithMessage:@"新密码错误"];
        return ;
    }
    else if ([self checkPassWord:_newPasswordField.text]){
       // [UIAlertView popupAlertByDelegate:nil title:@"提示" message:@"您输入的密码包含特殊字符，请重新输入"];
        [self showAlertWithMessage:@"新密码错误"];
        return ;
    } else if (![_newPasswordField.text isEqualToString:_newPasswordAgainField.text]){
       // [UIAlertView popupAlertByDelegate:nil title:@"提示" message:@"您两次输入的密码不相同，请重新输入"];
        [self showAlertWithMessage:@"两次密码不一致"];
        return ;
    }

    
    [PasswordManager ModifyPasswordByOldPwd:_oldPassWordTextField.text newPwd:_newPasswordAgainField.text completion:^(BOOL isSuccess, NSString *returnMsg) {
        if (isSuccess)
        {
            //[UIAlertView popupAlertByDelegate:nil title:@"提示" message:@"修改密码成功"];
            [self showAlertWithMessage:@"修改密码成功"];
        }else {
           // [UIAlertView popupAlertByDelegate:nil title:@"提示" message:returnMsg];
            [self showAlertWithMessage:returnMsg];
        }
    }];
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

#pragma mark - textFieldDelegate

- (IBAction)beginEdite:(id)sender
{
    _alertLabel.hidden = YES;
    UITextField *textField = (UITextField*)sender;
    if (textField.tag == 1) {
        if (!is4InchScreen()) {
            [UIView animateWithDuration:0.2 animations:^{
                CGAffineTransform viewTransform = CGAffineTransformMakeTranslation(0,-20);
                self.view.transform = viewTransform;
            } completion:^(BOOL finished) {
                
            }];
        }
    }
    
}

- (IBAction)finishEdit:(id)sender
{
    
    [(UITextField*)sender resignFirstResponder];
    [UIView animateWithDuration:0.2 animations:^{
        CGAffineTransform viewTransform = CGAffineTransformMakeTranslation(0,0);
        self.view.transform = viewTransform;
    } completion:^(BOOL finished) {
        
    }];
}

- (IBAction)tapView:(id)sender
{
    [_oldPassWordTextField resignFirstResponder];
    
    [_newPasswordField resignFirstResponder];
    
    [_newPasswordAgainField resignFirstResponder];
    [UIView animateWithDuration:0.2 animations:^{
        CGAffineTransform viewTransform = CGAffineTransformMakeTranslation(0,0);
        self.view.transform = viewTransform;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)showAlertWithMessage:(NSString *)message
{
    _alertLabel.text = message;
    _alertLabel.hidden = NO;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
