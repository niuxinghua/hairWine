//
//  NewsModel.h
//  HaierWine
//
//  Created by david on 14/7/23.
//
//

#import "ITTBaseModelObject.h"

@interface NewsModel : ITTBaseModelObject
@property(nonatomic,strong)NSString *newsId;
@property(nonatomic,strong)NSString *newsTitle;
@property(nonatomic,strong)NSString *newsDate;
@property(nonatomic,strong)NSString *newsPic;
@property(nonatomic,assign)BOOL     isChecked;
@end
