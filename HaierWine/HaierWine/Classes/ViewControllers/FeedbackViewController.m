//
//  FeedbackViewController.m
//  HaierWine
//
//  Created by isoftstone on 14-7-6.
//
//

#import "FeedbackViewController.h"
#import "AppDelegate.h"
@interface FeedbackViewController ()
{
    
    IBOutlet UITextView *_feedbackTextView;
    
}
@end

@implementation FeedbackViewController

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
    _feedbackTextView.delegate = self;
    _feedbackTextView.layer.borderWidth = 1;
    _feedbackTextView.layer.borderColor = UIColor.lightGrayColor.CGColor;
    
    //添加收键盘按钮
    UIToolbar * topView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    [topView setBarStyle:UIBarStyleDefault];
    UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(dismissKeyBoard)];
    
    
    NSArray * buttonsArray = [NSArray arrayWithObjects:btnSpace,doneButton,nil];
    
    [topView setItems:buttonsArray];
    [_feedbackTextView setInputAccessoryView:topView];

}

-(void)dismissKeyBoard
{
    [_feedbackTextView resignFirstResponder];
}

#pragma mark - textViewDelete

- (IBAction)backButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(BOOL) isEmpty:(NSString *) str {
    
    if (!str) {
        return true;
    } else {
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        NSString *trimedString = [str stringByTrimmingCharactersInSet:set];
        
        if ([trimedString length] == 0) {
            return true;
        } else {
            return false;
        }
    }
}

-(IBAction)commite:(id)sender
{
    [self textViewDidBeginEditing:_feedbackTextView];
    
    if ([self isEmpty:_feedbackTextView.text]) {
        
    //    [UIAlertView popupAlertByDelegate:self title:@"提示" message:@"输入不能为空"];
        
        FeedBackAndUpdateAlertView *alertView = [FeedBackAndUpdateAlertView loadFromXib];
        alertView.frame = CGRectMake(0, 0, 320, self.view.bounds.size.height);
        alertView.type = FeedBackIsEmpty;
        [self.view addSubview:alertView];
        
    } else if (_feedbackTextView.text.length>140) {
        FeedBackAndUpdateAlertView *alertView = [FeedBackAndUpdateAlertView loadFromXib];
        alertView.frame = CGRectMake(0, 0, 320, self.view.bounds.size.height);
        alertView.type = FeedBackIsMore;
        [self.view addSubview:alertView];
    }else {
        
    [_feedbackTextView resignFirstResponder];
    [self feedBackRequest:_feedbackTextView.text];
        
    }

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - textViewdelegate

-(void)textViewDidBeginEditing:(UITextView *)textView
{

    if ([textView.text hasPrefix:@"亲，告诉我们"]) {
        textView.text = @"";
    }
}
#pragma mark - AFBase64EncodedStringFromString

static NSString * AFBase64EncodedStringFromString(NSString *string) {
    NSData *data = [NSData dataWithBytes:[string UTF8String] length:[string lengthOfBytesUsingEncoding:NSUTF8StringEncoding]];
    NSUInteger length = [data length];
    NSMutableData *mutableData = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    
    uint8_t *input = (uint8_t *)[data bytes];
    uint8_t *output = (uint8_t *)[mutableData mutableBytes];
    
    for (NSUInteger i = 0; i < length; i += 3) {
        NSUInteger value = 0;
        for (NSUInteger j = i; j < (i + 3); j++) {
            value <<= 8;
            if (j < length) {
                value |= (0xFF & input[j]);
            }
        }
        
        static uint8_t const kAFBase64EncodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
        
        NSUInteger idx = (i / 3) * 4;
        output[idx + 0] = kAFBase64EncodingTable[(value >> 18) & 0x3F];
        output[idx + 1] = kAFBase64EncodingTable[(value >> 12) & 0x3F];
        output[idx + 2] = (i + 1) < length ? kAFBase64EncodingTable[(value >> 6)  & 0x3F] : '=';
        output[idx + 3] = (i + 2) < length ? kAFBase64EncodingTable[(value >> 0)  & 0x3F] : '=';
    }
    
    return [[NSString alloc] initWithData:mutableData encoding:NSASCIIStringEncoding];
}

#pragma mark - request method
-(void)feedBackRequest:(NSString *)str
{
    
    LoadingView *loadingView = [LoadingView loadFromXib];
    if (isIOS7()) {
        
        loadingView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    } else {
        
        loadingView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    }

  //  loadingView.frame = CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height);
    
    [self.view addSubview:loadingView];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    
  //  NSMutableString *mutStr =[AFBase64EncodedStringFromString(_feedbackTextView.text) mutableCopy];
    
    NSString *Contentstr = [AFBase64EncodedStringFromString(_feedbackTextView.text) stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    
//    [mutStr replaceOccurrencesOfString:@"+" withString:@"%2B" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [mutStr length])];
    [dic setValue:Contentstr forKey:@"content"];
    [dic setValue:[AFBase64EncodedStringFromString(@"令狐冲") stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]forKey:@"subject"];
    [dic setValue:@"ios" forKey:@"type"];
    [dic setValue:[AFBase64EncodedStringFromString(DATA_ENV.person.userBase.mobile) stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forKey:@"userName"];
 //   NSLog(@"%@",DATA_ENV.person.userBase.mobile);
    [UserFeedbackRequest requestWithParameters:dic withIndicatorView:nil withCancelSubject:nil onRequestStart:nil onRequestFinished:^(ITTBaseDataRequest *request) {
        
        [loadingView removeFromSuperview];
        if ([request.handleredResult[@"result"] isEqualToString:@"0"]) {
            [self.navigationController popViewControllerAnimated:YES];
         //   [UIAlertView popupAlertByDelegate:nil title:@"提示" message:@"提交成功"];
          
            FeedBackAndUpdateAlertView *alertView = [FeedBackAndUpdateAlertView loadFromXib];
            alertView.frame = CGRectMake(0, 0, 320, [AppDelegate getAppDelegate].window.bounds.size.height);
            alertView.type = FeedBackSuccess;
            [[AppDelegate getAppDelegate].window addSubview:alertView];
           
        } else {
        
        //    [UIAlertView popupAlertByDelegate:self title:@"提示" message:@"提交失败"];
            
            FeedBackAndUpdateAlertView *alertView = [FeedBackAndUpdateAlertView loadFromXib];
            alertView.frame = CGRectMake(0, 0, 320, self.view.bounds.size.height);
            alertView.type = FeedBackFailed;
            [self.view addSubview:alertView];
        }
        
    } onRequestCanceled:nil onRequestFailed:^(ITTBaseDataRequest *request) {
        
        [loadingView removeFromSuperview];
     //   [UIAlertView popupAlertByDelegate:self title:@"提示" message:@"提交失败"];
        FeedBackAndUpdateAlertView *alertView = [FeedBackAndUpdateAlertView loadFromXib];
        alertView.frame = CGRectMake(0, 0, 320, self.view.bounds.size.height);
        alertView.type = FeedBackFailed;
        [self.view addSubview:alertView];
        
    }];
}

- (IBAction)weiboCLick:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://weibo.com/yeegt"]];
}


@end
