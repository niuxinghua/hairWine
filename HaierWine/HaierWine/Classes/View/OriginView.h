//
//  OriginView.h
//  HaierWine
//
//  Created by david on 14/7/9.
//
//

#import "ITTXibView.h"

@protocol OriginDelegate <NSObject>

-(void)largeImage:(NSInteger)tag;

@end

@interface OriginView : ITTXibView

@property(nonatomic,weak)id <OriginDelegate> delegate;

- (void)layoutOriginViewWithArray:(NSArray *)data;

@end
