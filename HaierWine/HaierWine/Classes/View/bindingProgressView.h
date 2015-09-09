//
//  bindingProgressView.h
//  HaierWine
//
//  Created by 张作伟 on 14-8-6.
//
//

#import "ITTXibView.h"

@protocol bindingProgressViewDelegate <NSObject>

- (void)connectFialure;

@end

@interface bindingProgressView : ITTXibView

@property (assign, nonatomic) id <bindingProgressViewDelegate> delegate;
@property (strong, nonatomic) IBOutlet UILabel *progressCount;
@property (assign, nonatomic) NSInteger   count;
@property (strong, nonatomic) IBOutlet UILabel *progressLabel;

@end
