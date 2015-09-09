//
//  DeviceNameViewController.m
//  HaierWine
//
//  Created by 张作伟 on 14-8-11.
//
//

#import "DeviceNameViewController.h"
#import "UserInfoManager.h"

@interface DeviceNameViewController ()
{
    
    IBOutlet UITextField *_deviceNameTextField;
}

@end

@implementation DeviceNameViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
 //       [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldViewDidChange:) name:UITextFieldTextDidChangeNotification object: nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _deviceNameTextField.text = _deviceName;
    [_deviceNameTextField becomeFirstResponder];
  //  [_deviceNameTextField setValue:@8 forKey:@"limit"];
}

#pragma mark - backButton

- (IBAction)backButtonClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - submitDeviceName

- (IBAction)submit:(id)sender
{    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimedString = [_deviceNameTextField.text stringByTrimmingCharactersInSet:set];
    [_deviceNameTextField resignFirstResponder];
    if (trimedString.length == 0){
        DeleteAlertView *alert = [DeleteAlertView loadFromXib];
        alert.frame = CGRectMake(0, 0, 320, self.view.bounds.size.height);
        alert.type = DeleteAlertViewTypeNameEmpty;
        alert.delegate = self;
        [self.view addSubview:alert];
    } else {
        
        if (_isModefyName) {
            LoadingView *loadingView = [LoadingView loadFromXib];
            if (isIOS7()) {
                
                loadingView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
            } else {
                
                loadingView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
            }
            
            // loadingView.frame = CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height);
            [self.view addSubview:loadingView];
            
            [UserInfoManager renameDeiveByNewname:_deviceNameTextField.text completion:^(BOOL isSuccess, id responseObject) {
                [self.navigationController popViewControllerAnimated:YES];
                [_delegate modifyDeviceName:_deviceNameTextField.text];
                DATA_ENV.deviceName = _deviceNameTextField.text;
                [loadingView removeFromSuperview];
            }];
            
        } else {
            [self.navigationController popViewControllerAnimated:YES];
            [_delegate modifyDeviceName:_deviceNameTextField.text];
            
        }
    }
}

- (void)DeleteAlertViewClickedWithTag:(NSInteger)tag withType:(DeleteAlertViewType)type
{
    if (type == DeleteAlertViewTypeNameEmpty) {
        if (tag == 0) {
            [_deviceNameTextField becomeFirstResponder];
            _deviceNameTextField.text = _deviceName;
          //  [self.navigationController popViewControllerAnimated:YES];
        } else {
            [_deviceNameTextField becomeFirstResponder];
            return;
        }
    }
}

#pragma mark - UITextFieldDelegate

//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
//    NSMutableString *str = [[NSMutableString alloc]initWithString:textField.text];
//    [str appendString:string];
//    if (str.length > 8) {
//        textField.text = [str substringToIndex:7];
//    }
//
//    return YES;
//}
//- (void)textFieldViewDidChange:(NSNotification *)noti
//{
//    UITextField *textField = [noti object];
//    //d  UITextField *textField = [noti object][@"UITextField"];
//    //    NSInteger  characterCount;
//    //
//    //    if (textField.tag == 0) {
//    //        characterCount = 11;
//    //    } else {
//    //        characterCount = 16;
//    //    }
//    if (textField.text.length > 8 && textField.markedTextRange == nil) {
//        textField.text = [textField.text substringWithRange: NSMakeRange(0,8)];
//    }
//    
//    //   NSLog(@"%@",noti);
//}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_deviceNameTextField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
