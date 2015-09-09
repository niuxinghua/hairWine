//
//  PersonalCenterViewController.h
//  HaierWine
//
//  Created by isoftstone on 14-7-23.
//
//

#import <UIKit/UIKit.h>
#import "CityViewController.h"
@interface PersonalCenterViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,CityListDelegate>
@property (nonatomic,strong) PersonalCenterViewController *personalCenterViewController;
+(PersonalCenterViewController *)getPersonalCenterViewController;
- (void)isUploadAvatarByAvatarDataSccess:(BOOL)isOrNo;
@end
