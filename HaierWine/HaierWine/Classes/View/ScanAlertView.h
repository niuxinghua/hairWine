//
//  ScanAlertView.h
//  HaierWine
//
//  Created by david on 14/9/10.
//
//

#import "ITTXibView.h"

typedef enum {
    
    ScanAlertTypeFromHomePage = 0,
    ScanAlertTypeFromControlWine
    
}ScanAlertType;

@protocol ScanAlertViewDelegate <NSObject>

- (void)ScanAlertViewClickedWithTag:(NSInteger)tag;

@end

@interface ScanAlertView : ITTXibView

@property (nonatomic,assign)ScanAlertType type;
@property (nonatomic,assign)id<ScanAlertViewDelegate> delegate;

@end
