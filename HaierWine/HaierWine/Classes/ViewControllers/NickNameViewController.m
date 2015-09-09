//
//  NickNameViewController.m
//  HaierWine
//
//  Created by isoftstone on 14-7-24.
//
//

#import "NickNameViewController.h"
#import "UILabel+ITTAdditions.h"

@interface NickNameViewController ()
{
    
    IBOutlet UITextField *_nickNameTextField;
    NSInteger             _textLength;
    
}

@end

@implementation NickNameViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
 //   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldViewDidChange1:) name:UITextFieldTextDidChangeNotification object: nil];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _nickNameTextField.text = _nickName;
    [_nickNameTextField becomeFirstResponder];
  //  [_nickNameTextField setValue:@8 forKey:@"limit"];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - navButton

- (IBAction)backButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)submitButton:(id)sender
{
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimedString = [_nickNameTextField.text stringByTrimmingCharactersInSet:set];
    if (trimedString.length == 0) {
        [UIAlertView popupAlertByDelegate:nil title:nil message:@"昵称不能为空"];
        return;
    }
    NSDictionary * profileDict = @{@"nickName": _nickNameTextField.text,

                                   };
    NSDictionary * userProfile = @{@"userProfile": profileDict};
    [UserInfoManager modifyUserInfoByProfile:userProfile completion:^(BOOL isSuccess, NSString *returnMsg) {
      //  NSLog(@"####%@",returnMsg);
        [self.navigationController popViewControllerAnimated:YES];
        
    }];
    
}

//- (void)textFieldViewDidChange:(NSNotification *)noti
//{
//    UITextField *textField = [noti object];
//    //d  UITextField *textField = [noti object][@"UITextField"];
//    if (textField.text.length > 8) {
//        textField.text = [textField.text substringWithRange: NSMakeRange(0,8)];
//    }
//    
//   // NSLog(@"%@",njoti);
//}

//#pragma mark - UITextFieldDelegate
//
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
//     //CGFloat size = [UILabel layoutLabelWidthWithText:textField.text font:[UIFont systemFontOfSize:16] height:30];
//    NSMutableString *str = [[NSMutableString alloc]initWithString:textField.text];
//    [str appendString:string];
//    if (str.length > 8) {
//        textField.text = [str substringToIndex:7];
//    }
//    return YES;
//}
//- (void)textFieldViewDidChange1:(NSNotification *)noti
//{
//    UITextField *textField = (UITextField *)noti.object;
//    if (textField.text.length > 8 && textField.markedTextRange == nil) {
//        textField.text = [textField.text substringWithRange: NSMakeRange(0,8)];
//    }
//}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_nickNameTextField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
