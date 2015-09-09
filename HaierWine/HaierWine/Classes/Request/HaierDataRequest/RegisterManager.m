//
//  RegisterManager.m
//  HaierWine
//
//  Created by isoftstone on 14-7-3.
//
//

#import "RegisterManager.h"
#import "ITTObjectSingleton.h"
#import "RegisterRequest.h"

@implementation RegisterManager

ITTOBJECT_SINGLETON_BOILERPLATE(RegisterManager, sharedRegisterManager)

+ (void)registerRequestWithMobile:(NSString *)mobile password:(NSString *)password completion:(void (^)(BOOL, NSString *,NSString *))completion
{
    NSMutableDictionary * userDict = [NSMutableDictionary dictionary];
    
    NSMutableDictionary * userBasicDict = [NSMutableDictionary dictionary];
    [userBasicDict setValue:@"" forKey:@"loginName"
     ];
    //    [userBasicDict setValue:@"" forKey:@"email"];
    [userBasicDict setValue:mobile forKey:@"mobile"];
    [userBasicDict setValue:[NSNumber numberWithInt:0] forKey:@"accType"];
    
    NSMutableDictionary * userProfileDict = [NSMutableDictionary dictionary];
    [userProfileDict setValue:mobile forKey:@"nickName"];
    [userProfileDict setValue:@"" forKey:@"avatarUrl"];
    
    [userDict setValue:userBasicDict forKey:@"userBase"];
    [userDict setValue:userProfileDict forKey:@"userProfile"];
    
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setValue:password forKey:@"password"];
    [params setValue:userDict forKey:@"user"];
    
   // NSLog(@"body json:%@",[NSJSONSerialization jsonStringFromDictionary:params]);
    
    NSDictionary * parameters = @{@"body": [NSJSONSerialization jsonStringFromDictionary:params]};
   // NSLog(@"注册------%@",parameters);
    [RegisterRequest requestWithParameters:parameters withRequestUrl:nil
                         withIndicatorView:nil withCancelSubject:nil onRequestStart:^(ITTBaseDataRequest *request){
                         } onRequestFinished:^(ITTBaseDataRequest *request){
                             if ([[request.handleredResult objectForKey:@"retCode"] isEqual:@"00000"]) {
                                 if (completion) {
                                     completion(TRUE,[request.handleredResult objectForKey:@"retCode"],[request.handleredResult objectForKey:@"retInfo"]);
                                 }
                             }else if ([[request.handleredResult objectForKey:@"retCode"] isEqual:@"22115"] ){
                                 if (completion) {
                                     completion(FALSE,@"22115",@"帐号已存在，请直接登录！");
                                 }
                             }else{
                                 if (completion) {
                                     completion(FALSE,[request.handleredResult objectForKey:@"retCode"],[request.handleredResult objectForKey:@"retInfo"]);
                                 }
                             }
                         } onRequestCanceled:^(ITTBaseDataRequest *request){
                             if (completion) {
                                 completion(FALSE,nil,nil);
                             }
                         } onRequestFailed:^(ITTBaseDataRequest *request){
                           //  [UIAlertView popupAlertByDelegate:nil title:@"提示" message:@"网络连接失败"];
                             if (completion) {
                                 completion(FALSE,@"1",nil);
                             }
                         }];
    
}

@end
