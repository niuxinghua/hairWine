//
//  AuthcodeManager.m
//  HaierIceBox
//
//  Created by Jeremy on 14-6-9.
//
//

#import "AuthcodeManager.h"
#import "GetAuchcodeRequest.h"
#import "VerifyAuthcodeRequest.h"
#import "NSJSONSerialization+ITTAdditions.h"

@implementation AuthcodeManager

+ (void)GetAuthcodeByMobile:(NSString *)mobile validateScene:(int)scene completion:(void (^)(BOOL, NSString *))completion
{
    NSDictionary * params = @{@"loginName":mobile,
                              @"validateType":@"1",
                              @"validateScene":[NSString stringWithFormat:@"%i",scene],
                              @"sendTo":mobile,
                              @"accType":[NSNumber numberWithInt:0]
                              };
//        NSDictionary * params = @{@"loginName":@"15937529734",
//                                 @"validateType":@"1",
//                                  @"validateScene":[NSString stringWithFormat:@"%i",scene],
//                                @"sendTo":@"18311028159",
//                                 @"accType":[NSNumber numberWithInt:99]
//                                  };
    NSString * jsonString = [NSJSONSerialization jsonStringFromDictionary:params];
  //  NSLog(@"jsonstring-------:%@",jsonString);
    NSDictionary * parameters = @{@"body":jsonString};
    [GetAuchcodeRequest requestWithParameters:parameters withRequestUrl:nil withIndicatorView:nil
                            withCancelSubject:nil onRequestStart:^(ITTBaseDataRequest *request){} onRequestFinished:^(ITTBaseDataRequest *request){
                                if ([[request.handleredResult objectForKey:@"retCode"] isEqualToString:@"00000"]) {
                                    if (completion) {
                                        completion(TRUE,[request.handleredResult objectForKey:@"transactionId"]);
                                    }
                                }else{
                                    if (completion) {
                                        completion(FALSE,[request.handleredResult objectForKey:@"retInfo"]);
                                    }
                                }                              }
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

+ (void)verifyAuthcodeByMobile:(NSString *)mobile authcode:(NSString *)authcode transactionId:(NSString *)transactionId validateScene:(int)scene completion:(void (^)(BOOL, NSString *))completion
{
    
    NSString * requestUrl = [NSString stringWithFormat:@"%@/uvcs/%@/verify",COMMON_SERVER_ADDRESS,authcode];
    NSDictionary * params = @{@"loginName":mobile,
                              @"validateType":@"1",
                              @"validateScene":[NSString stringWithFormat:@"%i",scene],
                              @"accType":[NSNumber numberWithInt:0],
                              @"transactionId":transactionId
                              };
    NSString * jsonString = [NSJSONSerialization jsonStringFromDictionary:params];
  //  NSLog(@"jsonString:%@",jsonString);
    NSDictionary * parameters = @{@"body":jsonString};
    [VerifyAuthcodeRequest requestWithParameters:parameters withRequestUrl:requestUrl withIndicatorView:nil
                            withCancelSubject:nil onRequestStart:^(ITTBaseDataRequest *request){} onRequestFinished:^(ITTBaseDataRequest *request){
                               // NSLog(@"result :%@",request.handleredResult);
                                if ([[request.handleredResult objectForKey:@"retCode"] isEqualToString:@"00000"]) {
                                    if (completion) {
                                        completion(TRUE,[request.handleredResult objectForKey:@"retInfo"]);
                                    }
                                }else if ([[request.handleredResult objectForKey:@"retCode"] isEqualToString:@"22100"]){
                                    if (completion) {
                                        completion(FALSE,@"验证码错误");
                                    }
                                } 
                                else{
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
