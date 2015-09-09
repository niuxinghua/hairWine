//
//  CityViewController.h
//  HaierWine
//
//  Created by david on 14/8/8.
//
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@protocol CityListDelegate <NSObject>

- (void)selectedCity:(NSString *)cityName;

@end

@interface CityViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate,UIAlertViewDelegate>
@property (nonatomic,strong) id<CityListDelegate> delegate;
@property (nonatomic,strong) NSString *city;
@end
