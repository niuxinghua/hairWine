//
//  LinkNetworkView.h
//  HaierIceBox
//
//  Created by Jeremy on 14-5-27.
//
//

#import "ITTXibView.h"

@interface LinkNetworkView : ITTXibView

@property (weak, nonatomic) IBOutlet UILabel *networkName;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextfield;
@property (weak, nonatomic) IBOutlet UILabel *pwdErrorLabel;
@property (weak, nonatomic) IBOutlet UIButton *showPwdBtn;

- (void)setFrame:(CGRect)frame lastStepBlock:(void(^)(void))lastStepBlock linkBlock:(void(^)(void))linkBlock;

@end
