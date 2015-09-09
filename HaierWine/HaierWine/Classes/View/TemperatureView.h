//
//  TemperatureView.h
//  HaierWine
//
//  Created by david on 14/7/15.
//
//

#import "ITTXibView.h"

@protocol temperatureDelegate <NSObject>

-(void)complite:(NSInteger)degree:(BOOL)isSure;
-(void)suitableTemperature:(NSString *)str andWindKind:(NSString*)wineKind;

@end

@interface TemperatureView : ITTXibView<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,weak)id<temperatureDelegate>delegate;


@end
