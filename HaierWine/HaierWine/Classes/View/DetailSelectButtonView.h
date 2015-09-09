//
//  DetailSelectButtonView.h
//  HaierWine
//
//  Created by isoftstone on 14-7-7.
//
//

#import "ITTXibView.h"

@protocol DetailSelectButtonDelegate<NSObject>

- (void)selectButtonClick:(NSInteger)tag;

@end

@interface DetailSelectButtonView : ITTXibView

@property (weak,nonatomic)id<DetailSelectButtonDelegate> delegate;

@end
