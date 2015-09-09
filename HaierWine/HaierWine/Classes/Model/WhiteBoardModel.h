//
//  WhiteBoardModel.h
//  HaierWine
//
//  Created by david on 14/7/28.
//
//

#import "ITTBaseModelObject.h"

@interface WhiteBoardModel : ITTBaseModelObject

@property(nonatomic,strong)NSString *whiteBoardColorName;
@property(nonatomic,strong)NSString *whiteBoardColorid;
@property(nonatomic,strong)NSArray *whiteBoardPlanList;
@property(nonatomic,strong)NSString *whiteBoardColorCode;
@property(nonatomic,strong)NSArray  *whiteBoardTextHeight;
@property(nonatomic)       BOOL      isChecked;
@end


