//
//  AuthcodeManager.h
//  HaierIceBox
//
//  Created by Jeremy on 14-6-9.
//
//

#import <Foundation/Foundation.h>

@interface AuthcodeManager : NSObject

+ (void)GetAuthcodeByMobile:(NSString *)mobile validateScene:(int)scene completion:(void(^)(BOOL isSuccess ,NSString * returnMsg))completion;
+ (void)verifyAuthcodeByMobile:(NSString *)mobile authcode:(NSString *)authcode transactionId:(NSString *)transactionId validateScene:(int)scene completion:(void(^)(BOOL isSuccess, NSString * returnMsg))completion;

@end
