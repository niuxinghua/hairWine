//
//  PasswordManager.h
//  HaierIceBox
//
//  Created by Jeremy on 14-6-8.
//
//

#import <Foundation/Foundation.h>

@interface PasswordManager : NSObject

+ (void)ModifyPasswordByOldPwd:(NSString *)oldPwd newPwd:(NSString *)newPwd completion:(void(^)(BOOL isSuccess, NSString * returnMsg))completion;

+ (void)ResetPasswordByLoginName:(NSString *)loginName newPwd:(NSString *)newPwd transactionId:(NSString *)transactionId completion:(void(^)(BOOL isSuccess, NSString *returnMsg))completion;

@end
