//
//  DetailWineButtonView.h
//  HaierWine
//
//  Created by isoftstone on 14-7-7.
//
//

#import "ITTXibView.h"
#import "DetailWineButton.h"

@protocol DetailWineButtonViewDelegate <NSObject>

- (void) PopViewButtonSelextedWithTag:(NSInteger)tag;

@end

@interface DetailWineButtonView : ITTXibView<DetailWineButtonDelegate>
@property(nonatomic,assign) id <DetailWineButtonViewDelegate> delegate;
@property(nonatomic,strong) NSArray *titleArray;
@end
