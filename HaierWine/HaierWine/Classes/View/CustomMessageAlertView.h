//
//  CustomMessageAlertView.h
//  HaierWine
//
//  Created by david on 14/8/29.
//
//

#import "ITTXibView.h"

@protocol CustomMessageAlertViewDelegate <NSObject>

- (void)customMessageAlertViewClickedWithTag:(NSInteger)tag;

@end

@interface CustomMessageAlertView : ITTXibView

@property (nonatomic,assign)id<CustomMessageAlertViewDelegate> delegate;
@property(nonatomic,strong)IBOutlet UILabel *textLabel;
@property(nonatomic,strong)IBOutlet UIImageView *redImageView;
@property(nonatomic,strong)IBOutlet UIImageView *grayImageView;
@end
