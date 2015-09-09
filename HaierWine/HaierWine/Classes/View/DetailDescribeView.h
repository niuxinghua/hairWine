//
//  DetailDescribeView.h
//  HaierWine
//
//  Created by isoftstone on 14-7-7.
//
//

#import "ITTXibView.h"

@protocol DetailDescribeViewDelegate <NSObject>

- (void)refreshUI:(CGFloat)addHeight;

@end

@interface DetailDescribeView : ITTXibView

@property (strong,nonatomic)NSString *wineName;
@property (strong,nonatomic)NSString *wineDescribe;
@property (strong,nonatomic)id <DetailDescribeViewDelegate> delegate;
@end
