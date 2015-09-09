//
//  VegetableView.h
//  HaierWine
//
//  Created by isoftstone on 14-7-10.
//
//

#import "ITTXibView.h"

@protocol VegetableViewDelegate <NSObject>

- (void)refreshVegetableView:(CGFloat)addHeight;

@end

@interface VegetableView : ITTXibView
@property(nonatomic,weak)id <VegetableViewDelegate> delegate;
- (void)layoutOriginViewWithArray:(NSArray *)data andTitle:(NSString *)title;
@end
