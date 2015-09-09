//
//  TopExchangeView.h
//  HaierWine
//
//  Created by david on 14/7/11.
//
//

#import "ITTXibView.h"

@protocol TopExchangeDelegate <NSObject>

-(void)change:(NSInteger)tag;
-(void)changeWithOutAnimation:(NSInteger)tag;

@end

@interface TopExchangeView : ITTXibView

@property(nonatomic,weak)id<TopExchangeDelegate>delegate;

-(void)exchangeToLeft;
-(void)exchangeToRight;
-(void)onlyPicMoveToLeft;
-(void)onlyPicMoveToRight;
-(void)showLeft; 
-(void)showRight;

@end
