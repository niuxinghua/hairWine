//
//  RegisterManager.h
//  HaierWine
//
//  Created by isoftstone on 14-7-3.
//
//

#import <Foundation/Foundation.h>

@interface RegisterManager : NSObject

+ (void)registerRequestWithMobile:(NSString *)mobile password:(NSString *)password completion:(void(^)(BOOL isSuccess,NSString * returnCode,NSString * returnMsg))completion;
@end
