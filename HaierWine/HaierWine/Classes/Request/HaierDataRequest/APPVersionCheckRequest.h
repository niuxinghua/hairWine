//
//  APPVersionCheckRequest.h
//  HaierIceBox
//
//  Created by Jeremy on 14-6-20.
//
//

#import "HaierBaseDataRequest.h"

@interface APPVersionCheckRequest : HaierBaseDataRequest

+ (void)appVersionRequestCompletion:(void(^)(BOOL isSuccess, id responseObject))completion;

@end
