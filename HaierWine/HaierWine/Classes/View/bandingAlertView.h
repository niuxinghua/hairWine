//
//  bandingAlertView.h
//  HaierWine
//
//  Created by 张作伟 on 14-9-14.
//
//

#import "ITTXibView.h"

@protocol bandingAlertViewDelegate <NSObject>

- (void)bandingAlertViewClick:(NSInteger)tag;

@end

@interface bandingAlertView : ITTXibView

@property (nonatomic,assign) id <bandingAlertViewDelegate> delegate;

@end
