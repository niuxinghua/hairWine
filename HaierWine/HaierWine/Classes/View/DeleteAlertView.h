//
//  DeleteAlertView.h
//  HaierWine
//
//  Created by david on 14/9/11.
//
//

#import "ITTXibView.h"

typedef enum {
    
    DeleteAlertViewTypeNoSelected = 0,
    DeleteAlertViewTypeAskSure,
    DeleteAlertViewTypeMessage,
    DeleteAlertViewTypeUnbandingFirst,
    DeleteAlertViewTypeUnbanding,
    DeleteAlertViewTypeSearchHistory,
    DeleteAlertViewTypeNameEmpty,
    DeleteAlertViewTypeWine,
    DeleteAlertViewTypeWineFail,
    
}DeleteAlertViewType;

@protocol DeleteAlertViewDelegate <NSObject>

- (void)DeleteAlertViewClickedWithTag:(NSInteger)tag withType:(DeleteAlertViewType)type;

@end

@interface DeleteAlertView : ITTXibView

@property (nonatomic,assign)DeleteAlertViewType type;
@property (nonatomic,assign)id<DeleteAlertViewDelegate> delegate;

@end
