//
//  UpdateAlertView.h
//  HaierWine
//
//  Created by david on 14/8/29.
//
//

#import "ITTXibView.h"
@protocol UpdateAlertViewDelegate <NSObject>

- (void)UpdateAlertViewClickedWithTag:(NSInteger)tag;

@end
@interface UpdateAlertView : ITTXibView
@property (nonatomic,assign)id<UpdateAlertViewDelegate> delegate;
@property(nonatomic,strong)IBOutlet UILabel *textLabel;
@end
