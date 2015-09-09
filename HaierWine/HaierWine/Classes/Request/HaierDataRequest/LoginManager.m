//
//  LoginManager.m
//  HaierIceBox
//
//  Created by Jeremy on 14-6-6.
//
//

#import "LoginManager.h"
#import "LoginRequest.h"
#import "LogoutRequest.h"
#import "NSJSONSerialization+ITTAdditions.h"
#import "UserInfoManager.h"
#import "WineManager.h"
@implementation LoginManager
void (^_completion)(BOOL isSuccess,NSString * returnMsg);
+ (void)loginRequestWithLoginID:(NSString *)loginid password:(NSString *)password isAutoLogin:(BOOL)autoLogin completion:(requestSuccess)completion;
{
   // SAVEUSERDATA.accessToken = @"";
    _completion = completion;
    NSDate * nowDate = [NSDate date];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"yyyyMMddhhmmss";
    NSString * dateString = [dateFormatter stringFromDate:nowDate];

    NSString * sequenceidStr = [NSString stringWithFormat:@"%@000001",dateString];
 //   NSLog(@"sequenceid=---------:%@",sequenceidStr);
    NSDictionary * params = @{@"loginId":loginid,
                              @"password":password,
                              @"accType":[NSNumber numberWithInt:0],
                              @"loginType":@"1",
//                              @"thirdpartyAppId":@"",
//                              @"thirdpatryAccessToken":@"",
                              @"sequenceId":sequenceidStr
                              };
    NSString * jsonString = [NSJSONSerialization jsonStringFromDictionary:params];
    //NSLog(@"jsonString:%@",jsonString);
    NSDictionary * parameters = @{@"body": jsonString};
    [LoginRequest requestWithParameters:parameters withRequestUrl:nil
                      withIndicatorView:nil withCancelSubject:nil onRequestStart:^(ITTBaseDataRequest *request){} onRequestFinished:^(ITTBaseDataRequest *request){
                       //   NSLog(@"result--------------:%@",request.handleredResult);
                          if ([[request.handleredResult objectForKey:@"retCode"] isEqualToString:@"00000"]) {
                              DATA_ENV.isLocalOnline = YES;
                           //   if (!autoLogin)
                            //  {
                                  DATA_ENV.userid = [request.handleredResult objectForKey:@"userId"];
                                  NSDictionary * profileDict = @{@"addres": @"cityName"
                                                                 
                                                                 };
                                  NSDictionary * userProfile = @{@"userProfile": profileDict};
                                  [UserInfoManager modifyUserInfoByProfile:userProfile completion:^(BOOL isSuccess, NSString *returnMsg) {
                                      //  NSLog(@"####%@",returnMsg);小张
                                      [self getPersonalRequestCompletion:^(BOOL isSuccess, NSString *returnMsg) {
                                          
                                      }];
                                      [self getBoxWineRequestCompletion:^(BOOL isSuccess, NSString *returnMsg) {
                                          
                                      }];
                                  }];

                          }else{
                              if (_completion) {
                                  _completion(FALSE,request.handleredResult[@"retCode"]);
                              }
                          }
                      } onRequestCanceled:^(ITTBaseDataRequest *request){
                          if (_completion) {
                              _completion(FALSE,nil);
                          }
                      } onRequestFailed:^(ITTBaseDataRequest *request){
                        if (_completion) {
                              _completion(FALSE,@"2");
                          }
                      }];
}


#pragma mark - Request
+ (void)getPersonalRequestCompletion:(requestSuccess)completion
{
    [UserInfoManager queryUserInfoWhenCompletion:^(BOOL isSuccess, id responseObject) {
        [self getUserBindingDeviceCompletion:^(BOOL isSuccess, NSString *returnMsg) {
            
        }];
    }];
}

+ (void)getUserBindingDeviceCompletion:(requestSuccess)completion
{
    [UserInfoManager getUserDeviceWhenCompletion:^(BOOL isSuccess, id responseObject) {
        
        if(DATA_ENV.deviceMac.length != 0)
        {
            [[WineManager shareWineManager] remoteLoginWithAccessToken:DATA_ENV.accessToken];
        }
        if (DATA_ENV.isVistor) {
            if(_completion){
                _completion(TRUE,@"登陆UHOME平台成功");
            }
            DATA_ENV.isVistor = NO;
        }
    }];
}

+ (void)getBoxWineRequestCompletion:(requestSuccess)completion
{
    NSDictionary *dict = @{@"appId": DATA_ENV.userid};
    [QueryWineRequest requestWithParameters:dict withIndicatorView:nil withCancelSubject:nil onRequestStart:nil onRequestFinished:^(ITTBaseDataRequest *request) {
        if ([request.handleredResult[@"result"] isEqualToString:@"1"]) {
            DATA_ENV.wineName = nil;
            DATA_ENV.wineID = nil;
            return ;
        }
        NSString *type = request.handleredResult[@"data"][@"type"];
        if ([type isEqualToString:@"0"]) {
        NSString *wineId = request.handleredResult[@"data"][@"id"];
        DATA_ENV.wineID = wineId;
        NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
        [parameters setValue:wineId forKey:@"id"];
        [parameters setValue:DATA_ENV.userid forKeyPath:@"appId"];
        [boxWineRequest requestWithParameters:parameters withIndicatorView:nil withCancelSubject:nil onRequestStart:nil onRequestFinished:^(ITTBaseDataRequest *request) {
            if ([request.handleredResult[@"result"] isEqualToString:@"0"]) {
                DATA_ENV.wineName = [request.handleredResult[@"data"][@"images"] firstObject][@"gname"];
              //  NSLog(@"****%@", DATA_ENV.wineName);
                DATA_ENV.wineType = request.handleredResult[@"data"][@"goods_type"];
                NSDictionary *dict = @{@"type": @"0"};
                [[NSNotificationCenter defaultCenter] postNotificationName:@"CHANGEWINENAME" object:nil userInfo:dict];
               // NSLog(@"航时刻都放假了--%@--%@",DATA_ENV.wineName,DATA_ENV.wineType);
            }
            
        } onRequestCanceled:nil onRequestFailed:^(ITTBaseDataRequest *request) {
            
        }];
        } else {
            DATA_ENV.wineID = nil;
            NSString *wineType = request.handleredResult[@"data"][@"id"];
            NSDictionary *dict = @{@"type": wineType};
            [[NSNotificationCenter defaultCenter] postNotificationName:@"CHANGEWINENAME" object:nil userInfo:dict];
        }
    } onRequestCanceled:nil onRequestFailed:^(ITTBaseDataRequest *request) {
        
    }];
}

+ (void)logoutRequestWhenCompletion:(void (^)(BOOL, NSString *))completion
{
  //  NSLog(@"用户ID====%@",SAVEUSERDATA.userid);
    NSDate * nowDate = [NSDate date];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"yyyyMMddhhmmss";
    NSString * dateString = [dateFormatter stringFromDate:nowDate];
    
    NSString * sequenceidStr = [NSString stringWithFormat:@"%@000001",dateString];
    NSDictionary * params = @{
                              @"sequenceId":sequenceidStr
                              };
    NSString * jsonString = [NSJSONSerialization jsonStringFromDictionary:params];
   // NSLog(@"jsonString:%@",jsonString);
    NSDictionary * parameters = @{@"body": jsonString};
    [LogoutRequest requestWithParameters:parameters withRequestUrl:nil
                       withIndicatorView:nil withCancelSubject:nil onRequestStart:^(ITTBaseDataRequest *request){} onRequestFinished:^(ITTBaseDataRequest *request){
                        //   NSLog(@"----%@",request.handleredResult[@"retInfo"]);
                                if ([[request.handleredResult objectForKey:@"retCode"] isEqualToString:@"00000"]) {
                                    DATA_ENV.isBindingDevice = NO;
                                    DATA_ENV.isLocalOnline = NO;
                               //     DATA_ENV.deviceMac = nil;
                                    DATA_ENV.person = nil;
                                        if (completion) {
                                            completion(TRUE,@"退出成功");
                                   
                                        }
                                }else{
                                    if (completion) {
                                        completion(FALSE,[request.handleredResult objectForKey:@"retInfo"]);
                                    }
                                }
                       } onRequestCanceled:^(ITTBaseDataRequest *request){
                           if (completion) {
                               completion(FALSE,nil);
                           }
                       } onRequestFailed:^(ITTBaseDataRequest *request){
                           if (completion) {
                               completion(FALSE,@"服务器没有响应");
                           }
                       }];


}

#pragma mark - APServer setTags Callback
- (void)aliasCallback:(int)iResCode alias:(NSString *)alias
{
    if (iResCode == 0) {
      //  NSLog(@"设置Jpush alias成功! alias为:%@",alias);
    }else{
       // NSLog(@"设置Jpush alias失败!");
    }
}



@end
