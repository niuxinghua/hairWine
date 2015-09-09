//
//  DetailViewController.h
//  HaierWine
//
//  Created by david on 14/7/23.
//
//

#import <UIKit/UIKit.h>

typedef enum {

    NewsDetailType = 0,
    ProfessionalDetailType,
    ExperienceDetailType,
    MessageDetailType
    
}DetailType;

@interface DetailViewController : UIViewController<UIScrollViewDelegate>
@property(nonatomic,assign)DetailType type;
@property(nonatomic,strong)NSString *newsId;
@end
