//
//  PasswordManager.m
//  HaierIceBox
//
//  Created by Jeremy on 14-6-8.
//
//

#import "PasswordManager.h"
#import "ChangePwdRequest.h"
#import "ResetPwdRequest.h"
@implementation PasswordManager

+ (void)ModifyPasswordByOldPwd:(NSString *)oldPwd newPwd:(NSString *)newPwd completion:(void (^)(BOOL, NSString *))completion
{
    NSString * requestUrl = [NSString stringWithFormat:@"%@/users/%@/changePwd",COMMON_SERVER_ADDRESS,DATA_ENV.userid];
    
    NSDictionary * params = @{@"newPassword": newPwd,
                              @"oldPassword":oldPwd
                              };
    NSString * jsonString = [NSJSONSerialization jsonStringFromDictionary:params];
    NSDictionary * parameters = @{@"body": jsonString};
    
    [ChangePwdRequest requestWithParameters:parameters withRequestUrl:requestUrl withIndicatorView:nil
                          withCancelSubject:nil onRequestStart:^(ITTBaseDataRequest *request){}onRequestFinished:^(ITTBaseDataRequest *request){
                              if ([[request.handleredResult objectForKey:@"retCode"] isEqualToString:@"00000"]) {
                                  if (completion) {
                                      completion(TRUE,[request.handleredResult objectForKey:@"retInfo"]);
                                  }
                              }else{
                                  if (completion) {
                                      completion(FALSE,[request.handleredResult objectForKey:@"retInfo"]);
                                  }
                              }

                            }
                                onRequestCanceled:^(ITTBaseDataRequest *request){
                                    if (completion) {
                                        completion(FALSE,@"请求取消");
                                    }
                                }
                                    onRequestFailed:^(ITTBaseDataRequest *request){
                                        if (completion) {
                                            completion(FALSE,@"请求失败");
                                        }
                                    }];

}

+ (void)ResetPasswordByLoginName:(NSString *)loginName newPwd:(NSString *)newPwd transactionId:(NSString *)transactionId completion:(void (^)(BOOL, NSString *))completion
{
    NSString * requestUrl = [NSString stringWithFormat:@"%@/users/%@/resetPwd",COMMON_SERVER_ADDRESS,loginName];
    NSDictionary * params = @{
                              @"accType":[NSNumber numberWithInt:0],
                              @"newPassword":newPwd,
                              @"transactionId":transactionId,
                              };
    NSString * jsonString = [NSJSONSerialization jsonStringFromDictionary:params];
  //  NSLog(@"jsonString:%@",jsonString);
    NSDictionary * parameters = @{@"body": jsonString};
    
    [ResetPwdRequest requestWithParameters:parameters withRequestUrl:requestUrl withIndicatorView:nil
                          withCancelSubject:nil onRequestStart:^(ITTBaseDataRequest *request){}onRequestFinished:^(ITTBaseDataRequest *request){
                              if ([[request.handleredResult objectForKey:@"retCode"] isEqualToString:@"00000"]) {
                                  if (completion) {
                                      completion(TRUE,[request.handleredResult objectForKey:@"retInfo"]);
                                  }
                              }else{
                                  if (completion) {
                                      completion(FALSE,[request.handleredResult objectForKey:@"retInfo"]);
                                  }
                              }
                              
                          }
                          onRequestCanceled:^(ITTBaseDataRequest *request){
                              if (completion) {
                                  completion(FALSE,@"请求取消");
                              }
                          }
                            onRequestFailed:^(ITTBaseDataRequest *request){
                                if (completion) {
                                    completion(FALSE,@"请求失败");
                                }
                            }];

}

@end
