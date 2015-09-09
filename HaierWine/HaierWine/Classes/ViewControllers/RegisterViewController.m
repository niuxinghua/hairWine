//
//  RegisterViewController.m
//  登陆
//
//  Created by isoftstone on 14-6-27.
//  Copyright (c) 2014年 isoftstone. All rights reserved.
//

#import "RegisterViewController.h"
#import "ServiceAgreementViewController.h"
#import "RegisterViewController.h"
#import "RegisterManager.h"
#import "AuthcodeManager.h"
#import "BindDeviceRequest.h"
#import "RegisterNextViewController.h"
@interface RegisterViewController ()
{

    IBOutlet UIView      *_registerBgView;
    IBOutlet UIButton    *_registerButton;
    IBOutlet UITextField *_userPhoneNumber;
    
    IBOutlet UITextField *_password;
    
    IBOutlet UITextField *_confimNumber;
    
    IBOutlet UILabel     *_alertLabel;
    BOOL                 _getActivationCode;
    BOOL                 _agreeServiceItems;
    NSInteger            _timeCount;
    NSString             *_textFieldText;
}
@end

@implementation RegisterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
  //  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldViewDidChange:) name:UITextFieldTextDidChangeNotification object: nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationController.navigationBarHidden = YES;
    _getActivationCode = NO;
    _agreeServiceItems = YES;
    
    [_userPhoneNumber setValue:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.5] forKeyPath:@"_placeholderLabel.textColor"];
   // [_userPhoneNumber setValue:@11 forKey:@"limit"];
    [_password setValue:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.5] forKeyPath:@"_placeholderLabel.textColor"];
   // [_password setValue:@16 forKey:@"limit"];

    [_confimNumber setValue:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.5] forKeyPath:@"_placeholderLabel.textColor"];
   // [_confimNumber setValue:@16 forKey:@"limit"];

   // NSLog(@"registerBgView%f---%f",_registerBgView.top,_registerButton.top);
//    [_userPhoneNumber setValue:@11 forKey:@"limit"];
//    [_password setValue:@16 forKey:@"limit"];
//    [_confimNumber setValue:@16 forKey:@"limit"];

    if(is4InchScreen()){
        //_registButton.top = 507;
        _registerButton.top = 280;
        _registerBgView.top = 69;
    } else {
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
            _registerBgView.top = 69-44;
            _registerButton.top = 244+88;

        } else {
        _registerBgView.top = 69-24;
        _registerButton.top = 244+88;
        }
    }
   // _alertLabel.hidden = YES;
}

//- (void)viewDidAppear:(BOOL)animated
//{
//    _alertLabel.hidden = YES;
//}

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

#pragma mark - userAction

- (IBAction)backButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)userRegister:(id)sender
{
    //NSLog(@"加密数据--%@",[@"1234" MD5Hash]);
    if ([self checkString]) {
        LoadingView *loadingView = [LoadingView loadFromXib];
        if (isIOS7()) {
            
            loadingView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
        } else {
            
            loadingView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
        }

      //  loadingView.frame = CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height);
        
        [self.view addSubview:loadingView];
        [RegisterManager registerRequestWithMobile:_userPhoneNumber.text password:_password.text completion:^(BOOL isSuccess,NSString * returnCode ,NSString * returnMsg){
            [loadingView removeFromSuperview];
            // _nextBtn.enabled = YES;
            if (isSuccess) {
                RegisterNextViewController * registerNextVC = [[RegisterNextViewController alloc]initWithNibName:@"RegisterNextViewController" bundle:nil];
                registerNextVC.mobile = _userPhoneNumber.text;
                registerNextVC.password = _password.text;
                [self.navigationController pushViewController:registerNextVC animated:YES];
            }else{
                
                if (returnMsg) {
                    //[UIAlertView popupAlertByDelegate:nil title:@"提示" message:returnMsg cancel:@"确定" others:nil];
                    [self showAlertWithMessage:returnMsg];
                }
                if ([returnCode isEqualToString:@"1"]) {
                    [self showAlertWithMessage:@"网络连接失败"];

                    //                [_mobileStatusImage setImage:[UIImage imageNamed:@"input_no"] forState:UIControlStateNormal];
                    //                [_mobileStatusImage setImageEdgeInsets:ImageEdgeInsets_NO];
                    //                _mobileErrorLabel.text = returnMsg;
                    //                _mobileErrorLabel.textColor = [UIColor redColor];
                    //                _isMobileOk = NO;
                    //                [self judgeRegisterCompleteBtnBackground];
                }
                return ;
            }
        }];
        
    }
}

#pragma mark - textFieldDelegate
- (IBAction)editBegin:(id)sender
{
//    [UIView animateWithDuration:0.3 animations:^{
//        CGAffineTransform viewTransform = CGAffineTransformMakeTranslation(0, -100);
//        self.view.transform = viewTransform;
//    } completion:^(BOOL finished) {
//        
//    }];
    //_alertLabel.hidden = YES;
    _textFieldText = nil;
    [self hiddenAlertView];
}

//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
//    NSLog(@"textField-%@-%@",textField.text,string);
//    NSInteger  characterCount;
//    if (textField.tag == 0) {
//        characterCount = 11;
//    } else {
//        characterCount = 16;
//    }
//    NSMutableString *str = [[NSMutableString alloc]initWithString:textField.text];
//    if (str.length < characterCount) {
//        [str appendString:string];
//    }
//    if (textField.text.length==characterCount) {
//       // textField.text = textField.text;
//        return NO;
//    }
//    
//
////    if (str.length > characterCount) {
////        textField.text = [str substringToIndex:characterCount-1];
////    }
//
//    return YES;
//}

//- (void)textFieldViewDidChange:(NSNotification *)noti
//{
//    UITextField *textField = [noti object];
//  //d  UITextField *textField = [noti object][@"UITextField"];
//    NSInteger  characterCount;
//
//    if (textField.tag == 0) {
//        characterCount = 11;
//    } else {
//        characterCount = 16;
//    }
//    if (textField.text.length > characterCount && textField.markedTextRange == nil) {
//        textField.text = [textField.text substringWithRange: NSMakeRange(0,characterCount)];
//    }
//
// //   NSLog(@"%@",noti);
//}
- (IBAction)finishEdit:(id)sender
{
    [(UITextField*)sender resignFirstResponder];
    [UIView animateWithDuration:0.2 animations:^{
        CGAffineTransform viewTransform = CGAffineTransformMakeTranslation(0,0);
        self.view.transform = viewTransform;
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - The use of the service agreement

- (IBAction)agreeHaierItem:(id)sender
{
    UIButton *button = (UIButton *)sender;
    _agreeServiceItems = !_agreeServiceItems;
    if (_agreeServiceItems) {
        [button setImage:[UIImage imageNamed:@"show_password_yes.png"] forState:UIControlStateNormal];
        
    } else{
        [button setImage:[UIImage imageNamed:@"show_password_no.png"] forState:UIControlStateNormal];
    }
    
}

- (IBAction)servieItems:(id)sender
{
    ServiceAgreementViewController *svc = [[ServiceAgreementViewController alloc]initWithNibName:@"ServiceAgreementViewController" bundle:nil];
    [self.navigationController pushViewController:svc animated:YES];
}

#pragma mark - textViewResignFirstResponder

- (IBAction)tapView:(id)sender
{
    [_userPhoneNumber resignFirstResponder];
    [_password resignFirstResponder];
    [_confimNumber resignFirstResponder];
    [self hiddenAlertView];
//    [UIView animateWithDuration:0.2 animations:^{
//        CGAffineTransform viewTransform = CGAffineTransformMakeTranslation(0,0);
//        self.view.transform = viewTransform;
//    } completion:^(BOOL finished) {
//        
//    }];
}

- (BOOL)checkString
{
    if (_userPhoneNumber.text.length == 0) {
        [self showAlertWithMessage:@"手机号错误，请重新输入！"];
        return NO;
    } else if ([self checkPhoneNumInput:_userPhoneNumber.text]){
       // [UIAlertView popupAlertByDelegate:nil title:@"提示" message:@"请输入正确的手机号"];
        [self showAlertWithMessage:@"手机号错误，请重新输入！"];
        return NO;
    } else if (_password.text.length == 0){
        [self showAlertWithMessage:@"密码输入错误，请重新输入！"];
        return NO;
    }
    else if (_password.text.length<6 || _password.text.length>16)
    {
       // [UIAlertView popupAlertByDelegate:nil title:@"提示" message:@"您输入的密码应为6~32位，请重新输入"];
        [self showAlertWithMessage:@"密码输入错误，请重新输入！"];
        return NO;
    } else if ([self checkPassWord:_password.text]){
       // [UIAlertView popupAlertByDelegate:nil title:@"提示" message:@"您输入的密码包含特殊字符，请重新输入"];
        [self showAlertWithMessage:@"密码输入错误，请重新输入！"];
        return NO;
    } else if (_confimNumber.text.length == 0){
        [self showAlertWithMessage:@"密码输入错误，请重新输入！"];
        return NO;
    }
    else if (![_password.text isEqualToString:_confimNumber.text]){
        //[UIAlertView popupAlertByDelegate:nil title:@"提示" message:@"您两次输入的密码不相同，请重新输入"];
        [self showAlertWithMessage:@"两次密码不一致，请重新输入！"];
        return NO;
    } else if (_agreeServiceItems==NO) {
        [self showAlertWithMessage:@"请阅读服务协议并同意"];
        return NO;
    }
    return YES;
}


- (BOOL)checkPhoneNumInput:(NSString *)number
{
//    /**
//     * 手机号码
//     * 移动：134[0-8],135,136,137,138,139,150,151,152,157,158,159,182,183,143,187,188
//     * 联通：130,131,132,152,155,156,185,186,145
//     * 电信：133,1349,153,180,189,181,182
//     */
//    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[0-9])\\d{8}$";
//    
//    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[0127-9]|8[2378]|47)\\d)\\d{7}$";
//    
//    NSString * CU = @"^1(3[0-2]|5[256]|8[56]|45)\\d{8}$";
//    
//    NSString * CT = @"^1((33|53|8[0129])[0-9]|349)\\d{7}$";
//    
//    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
//    
//    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
//    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
//    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
//    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
//    BOOL res1 = [regextestmobile evaluateWithObject:number];
//    BOOL res2 = [regextestcm evaluateWithObject:number];
//    BOOL res3 = [regextestcu evaluateWithObject:number];
//    BOOL res4 = [regextestct evaluateWithObject:number];
//    
//    if (res1 || res2 || res3 || res4 )
//    {
//        
//        return YES;
//    }
//    else
//    {
//        return NO;
//    }
    NSCharacterSet *nameCharacters = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    //_abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ@.
    NSRange userNameRange = [number rangeOfCharacterFromSet:nameCharacters];
    NSString *firstNumber = [number substringToIndex:1];
  //  NSLog(@"####%@",firstNumber);
    if (userNameRange.location != NSNotFound) {
        // NSLog(@"包含特殊字符");
        return YES;
    } else if (![firstNumber isEqualToString:@"1"]){
        return YES;
    }
    return NO;

}

//- (void)showAlertWithMessage:(NSString *)message
//{
//   // _alertLabel.text = message;
//   // _alertLabel.hidden = NO;
//    [self showAlertWithMessage:message];
//}

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
