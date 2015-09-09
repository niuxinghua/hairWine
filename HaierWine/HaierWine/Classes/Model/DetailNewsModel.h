//
//  DetailNewsModel.h
//  HaierWine
//
//  Created by david on 14/9/5.
//
//

#import "ITTBaseModelObject.h"

@interface DetailNewsModel : ITTBaseModelObject
@property(nonatomic,strong)NSArray *newsPicArr;
@property(nonatomic,strong)NSString *newsTitle;
@property(nonatomic,strong)NSString *newsDate;
@property(nonatomic,strong)NSString *newsContent;
@property(nonatomic,strong)NSString *newsSource;
@end
