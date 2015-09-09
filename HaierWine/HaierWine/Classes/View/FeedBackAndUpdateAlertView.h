//
//  FeedBackAndUpdateAlertView.h
//  HaierWine
//
//  Created by david on 14/9/11.
//
//

#import "ITTXibView.h"

typedef enum {
    
    FeedBackSuccess = 0,
    FeedBackFailed,
    FeedBackIsEmpty,
    FeedBackIsMore,
    UpdateNotNeed,
    UnBandingSuccess,
    UnconnectWIFI
    
}FeedBackAndUpdateType;

@interface FeedBackAndUpdateAlertView : ITTXibView

@property (nonatomic,assign)FeedBackAndUpdateType type;

@end
