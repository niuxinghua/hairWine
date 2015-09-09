//
//  MyAlertView.h
//  HaierWine
//
//  Created by 张作伟 on 14-8-5.
//
//

#import <UIKit/UIKit.h>

@protocol MyAlertViewDelegate <NSObject>

- (void)myAlertViewClickedWithTag:(NSInteger)tag;

@end

@interface MyAlertView : ITTXibView

@property (nonatomic,assign)id<MyAlertViewDelegate> delegate;

@property (strong, nonatomic) IBOutlet UILabel *meassage;

@property (strong, nonatomic) IBOutlet UILabel *titleMessage;

@end
