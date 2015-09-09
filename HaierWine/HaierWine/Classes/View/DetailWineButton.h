//
//  DetailWineButton.h
//  HaierWine
//
//  Created by isoftstone on 14-7-7.
//
//

#import "ITTXibView.h"

@protocol DetailWineButtonDelegate <NSObject>

- (void)detailWineButtonClickWithTag:(NSInteger)tag;

@end

@interface DetailWineButton : ITTXibView
@property (strong, nonatomic) IBOutlet UILabel *detailButtonLabel;
@property (strong, nonatomic) IBOutlet UIButton *buttonTitle;
@property (assign, nonatomic) id <DetailWineButtonDelegate> delegate;

- (void)setLeft:(CGFloat)left andTop:(CGFloat)top withLabel:(NSString *)text andBtnImage:(UIImage*)image withTag:(NSInteger)tag ClickBlock:(void(^)(void))buttonClick;

@end
