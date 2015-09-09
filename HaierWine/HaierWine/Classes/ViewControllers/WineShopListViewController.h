//
//  WineShopListViewController.h
//  HaierWine
//
//  Created by 张作伟 on 14-8-12.
//
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface WineShopListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,CLLocationManagerDelegate,UIAlertViewDelegate>

@property (strong, nonatomic) NSString *wineName;
@property (strong, nonatomic) NSString *wineID;

@end
