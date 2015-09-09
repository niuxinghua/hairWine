//
//  InitNetworkView.h
//  HaierIceBox
//
//  Created by Jeremy on 14-5-27.
//
//

#import "ITTXibView.h"

@interface InitNetworkView : ITTXibView

@property (weak, nonatomic) IBOutlet UIButton *nextStepBtn;

- (void)setFrame:(CGRect)frame is4inch:(BOOL)is4inch clickHereBlock:(void(^)(void))clickHereBlock nextStepBlock:(void(^)(void))nextStepBlock;

@end
