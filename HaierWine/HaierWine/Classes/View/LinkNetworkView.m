//
//  LinkNetworkView.m
//  HaierIceBox
//
//  Created by Jeremy on 14-5-27.
//
//

#import "LinkNetworkView.h"
//#import "EASYLINK.h"
#import "Reachability.h"
@interface LinkNetworkView()<UITextFieldDelegate>
{
    BOOL    _isShowPwd;
    BOOL    _isKeyboardAppeared;
    NSTimeInterval  _lastDate;
}


@property (weak, nonatomic) IBOutlet UIButton *lastStepBtn;
@property (weak, nonatomic) IBOutlet UIButton *linkBtn;
@property (strong, nonatomic) void(^linkBlock)(void);
@property (strong, nonatomic) void(^lastStepBlock)(void);
@end


@implementation LinkNetworkView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stopEasylinkConfigure) name:NOTIFICATION_CONFIFURE_FAILURE object:nil];
            }
    return self;
}

- (void)awakeFromNib
{
    _isShowPwd = NO;
    
    _isKeyboardAppeared = NO;
//    if (!APPDELEGATE.easyLink_config) {
//       APPDELEGATE.easyLink_config = [[EASYLINK alloc] init];
//    }
    _passwordTextfield.delegate = self;
   // _networkName.text=[EASYLINK ssidForConnectedNetwork];
    UIControl * keyboardCtrl = [[UIControl alloc]initWithFrame:self.bounds];
    [keyboardCtrl addTarget:self action:@selector(hidenKeyboard) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:keyboardCtrl];
    [self sendSubviewToBack:keyboardCtrl];
    
    [self currentNetWorkState];
}

-(void)currentNetWorkState
{
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(wifiStatusChanged:) name:kReachabilityChangedNotification object:nil];
    Reachability*  wifiReachability = [Reachability reachabilityForLocalWiFi];  //监测Wi-Fi连接状态
	[wifiReachability startNotifier];
    NetworkStatus netStatus = [wifiReachability currentReachabilityStatus];
    if ( netStatus != ReachableViaWiFi) {// No activity if no wifi
      [UIAlertView popupAlertByDelegate:nil title:nil message:@"继续操作需要打开手机WIFI网络" cancel:@"好" others:nil];
    }
}

- (void)setFrame:(CGRect)frame lastStepBlock:(void (^)(void))lastStepBlock linkBlock:(void (^)(void))linkBlock
{
    self.frame = frame;
    _lastStepBlock = lastStepBlock;
    _linkBlock = linkBlock;
    
    if (is4InchScreen()) {
        _linkBtn.top = self.height - _linkBtn.height - 75;
        _lastStepBtn.top = self.height - _lastStepBtn.height - 75;
    }
}

- (IBAction)showPwdClicked:(id)sender {
    _isShowPwd = !_isShowPwd;
    if (_isShowPwd) {
        [_showPwdBtn setImage:[UIImage imageNamed:@"show_pwd_yes"] forState:UIControlStateNormal];
    }else{
        [_showPwdBtn setImage:[UIImage imageNamed:@"show_pwd_no"] forState:UIControlStateNormal];
    }
    [self controlPwdShowStatus];
}

- (void)controlPwdShowStatus
{
    if (_isShowPwd) {
        _passwordTextfield.secureTextEntry = NO;
    }else{
        _passwordTextfield.secureTextEntry = YES;
    }
}

- (IBAction)lastStepClicked:(id)sender {
    NSTimeInterval  cureentdate = [[NSDate date]timeIntervalSince1970];
    if (cureentdate- _lastDate <1000) {
        return;
    }
    _lastDate = cureentdate;
    
    _lastStepBlock();
   // [APPDELEGATE.easyLink_config stopTransmitting];
    
}

- (IBAction)linkNetworkClicked:(id)sender {
    NSTimeInterval  cureentdate = [[NSDate date]timeIntervalSince1970];
    if (cureentdate- _lastDate <1000) {
        return;
    }
      _lastDate = cureentdate;
    
    Reachability*  wifiReachability = [Reachability reachabilityForLocalWiFi];  //监测Wi-Fi连接状态
	[wifiReachability startNotifier];
    NetworkStatus netStatus = [wifiReachability currentReachabilityStatus];
    if ( netStatus != ReachableViaWiFi) {// No activity if no wifi
       [UIAlertView popupAlertByDelegate:nil title:nil message:@"继续操作需要打开手机WIFI网络" cancel:@"好" others:nil];
    }else{
        _linkBlock();
      //  [APPDELEGATE.easyLink_config prepareEasyLinkV2:_networkName.text password:_passwordTextfield.text info:nil];
      //  [APPDELEGATE.easyLink_config transmitSettings];
    }
}


#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (!is4InchScreen()) {
        [UIView animateWithDuration:0.25 animations:^(void){
            self.top -= 60;
        } completion:^(BOOL finished){
            _isKeyboardAppeared = YES;
        }];
    }else{
        _isKeyboardAppeared = YES;
    }
        return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self hidenKeyboard];
    return YES;
}

-(void)hidenKeyboard
{
    if (_isKeyboardAppeared == YES) {
        [_passwordTextfield resignFirstResponder];
        if (!is4InchScreen()) {
            [UIView animateWithDuration:0.25 animations:^(void){
                self.top += 60;
            } completion:^(BOOL finished){
                _isKeyboardAppeared = NO;
            }];
        }else{
            _isKeyboardAppeared = NO;
        }
    }
}


- (void)wifiStatusChanged:(NSNotification*)notification{
    NSLog(@"%s", __func__);
    Reachability *verifyConnection = [notification object];
    NSAssert(verifyConnection != NULL, @"currentNetworkStatus called with NULL verifyConnection Object");
    NetworkStatus netStatus = [verifyConnection currentReachabilityStatus];
    if ( netStatus != ReachableViaWiFi ){
        // The operation couldn’t be completed. No route to host
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"Wifi Not available. Please check your wifi connection" delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
//        [alertView show];
        _networkName.text = @"";
        _passwordTextfield.text = @"";
    }else {
   //     _networkName.text = [EASYLINK ssidForConnectedNetwork];
        
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
