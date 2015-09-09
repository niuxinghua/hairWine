//
//  UserInfoManager.m
//  HaierIceBox
//
//  Created by Jeremy on 14-6-9.
//
//

#import "UserInfoManager.h"
#import "ModifyUserProfileRequest.h"
#import "NSJSONSerialization+ITTAdditions.h"
#import "QueryUserInfoRequest.h"
#import "BindDeviceRequest.h"
#import "UnbindDeviceRequest.h"
#import "RenameDeviceRequest.h"
#import "QueryDeviceInfoRequest.h"
#import "UploadAvatarDataRequest.h"
#import "UploadAvatarRequest.h"
#import "PersonInfoManager.h"
#import "PersonalCenterViewController.h"

@implementation UserInfoManager
void (^_completion)(BOOL isSuccess, NSString * returnMsg);

+ (void)modifyUserInfoByProfile:(NSDictionary *)profile completion:(void (^)(BOOL, NSString *))completion
{
    NSString * requestUrl = [NSString stringWithFormat:@"%@/users/%@/profile",COMMON_SERVER_ADDRESS,DATA_ENV.userid];
   // NSLog(@"----------%@",requestUrl);
    NSString * jsonString = [NSJSONSerialization jsonStringFromDictionary:profile];
    NSDictionary * parameters = @{@"body":jsonString};
  //  NSLog(@"parameters: %@",parameters);
    [ModifyUserProfileRequest requestWithParameters:parameters withRequestUrl:requestUrl withIndicatorView:nil
                                withCancelSubject:nil
                                   onRequestStart:^(ITTBaseDataRequest *request){}
                                onRequestFinished:^(ITTBaseDataRequest *request)
    {
                                //    NSLog(@"----%@",request.handleredResult);
                                    if ([[request.handleredResult objectForKey:@"retCode"] isEqualToString:@"00000"]) {
                                        if (completion) {
                                            completion(TRUE,[request.handleredResult objectForKey:@"retInfo"]);
                                        }
                                    }else{
                                        if (completion) {
                                            completion(FALSE,[request.handleredResult objectForKey:@"retInfo"]);
                                           // NSLog(@"%@",[request.handleredResult objectForKey:@"retInfo"]);
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
                                        //  NSLog(@"88888%@",request.handleredResult);
                                          completion(FALSE,nil);
                                      }
                                  }];


}

+ (void)queryUserInfoWhenCompletion:(void (^)(BOOL, id))completion
{
   // NSString * requestUrl = [NSString stringWithFormat:@"%@/users/%@?accType=99&idType=0",COMMON_SERVER_ADDRESS,SAVEUSERDATA.userid];
    NSString * requestUrl = [NSString stringWithFormat:@"%@/users/%@?accType=0&idType=0",COMMON_SERVER_ADDRESS,DATA_ENV.userid];//100013957366154016
   // NSLog(@"SAVEUSERDATA.userid--%@",SAVEUSERDATA.userid);
    
    [QueryUserInfoRequest requestWithParameters:nil withRequestUrl:requestUrl withIndicatorView:nil
                              withCancelSubject:nil
                                 onRequestStart:^(ITTBaseDataRequest *request){}
                                    onRequestFinished:^(ITTBaseDataRequest *request){
                                      //  NSLog(@"user result-----------:%@",request.handleredResult);
                                        if ([[request.handleredResult objectForKey:@"retCode"] isEqualToString:@"00000"]) {
                                            if (completion) {
                                                completion(TRUE,[request.handleredResult objectForKey:@"user"]);
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

+ (void)uploadAvatarByAvatarData:(NSData *)avatarData ext:(NSString *)ext showView:(UIView *)showView completion:(void (^)(BOOL, id))completion
{
    _completion = completion;
    NSDictionary * params = @{@"userId": DATA_ENV.userid,
                              @"type":@"avatar",
                              @"ext":ext,
                              };

    NSString * jsonString = [NSJSONSerialization jsonStringFromDictionary:params];
   // NSLog(@"jsonString -------:%@",jsonString);
    NSDictionary * parameters = @{@"body": jsonString,
                                  };
    
    [UploadAvatarRequest requestWithParameters:parameters withRequestUrl:nil withIndicatorView:showView
                                  withCancelSubject:nil
                                     onRequestStart:^(ITTBaseDataRequest *request){}
                                  onRequestFinished:^(ITTBaseDataRequest *request)
    {
        
       // NSLog(@"获取二进制头像URL失败--原因%@",request.handleredResult);
                                      if ([[request.handleredResult objectForKey:@"retCode"] isEqualToString:@"00000"]) {
                                          // 上传二进制头像数据
                                          NSMutableString * uri = [NSMutableString stringWithString:[request.handleredResult objectForKey:@"uri"]];
                                        //  NSLog(@"上传二进制头像数据-%@,--%@",uri,avatarData);
                                          [UserInfoManager uploadAvatarDataBy:avatarData withURL:uri completion:nil];
                                         
//                                         // [self  modifyUserAvatarUrl:uri];
//                                          if (completion) {
//                                             completion(true,uri);
//                                         }
                                      }else{
                                          if (_completion) {
                                              _completion(FALSE,[request.handleredResult objectForKey:@"retInfo"]);
                                          }
                                      }
                                  }
                                  onRequestCanceled:^(ITTBaseDataRequest *request){
                                      if (_completion) {
                                          _completion(FALSE,@"请求取消");
                                      }
                                  }
                                    onRequestFailed:^(ITTBaseDataRequest *request){
                                        if (_completion) {
                                            _completion(FALSE,nil);
                                        }
                                    }];

}
+(void)modifyUserAvatarUrl:(NSString * )avatarUrl
{
//    if (![NSString isVaildString:avatarUrl]) {
//        return;
//    }
    
     UserProfileModel * model = [[PersonInfoManager sharedPersonInfoManager] getUserProfile];
    NSString * nickName = model.nickName ? model.nickName : @"";
    NSDictionary * profileDict = @{@"nikeName": nickName,
                                   @"avatarUrl":avatarUrl};
    NSDictionary * userProfile = @{@"userProfile": profileDict};
    [self modifyUserInfoByProfile:userProfile completion:^(BOOL isSuccess, NSString *returnMsg) {
        if (isSuccess) {
            
                  }else{
          //  [UIAlertView popupAlertByDelegate:nil title:@"提示" message:returnMsg];
        }
    }];
    
}
+ (void)uploadAvatarDataBy:(NSData *)headData withURL:(NSString *)requestURL  completion:(void (^)(BOOL, id))completion
{
   // NSInputStream * avatarStream = [NSInputStream inputStreamWithData:headData];
  //  NSLog(@"request url :%@",requestURL);
    NSDictionary * parameters  = @{@"avatar": headData
                                   };
    
    [UploadAvatarDataRequest requestWithParameters:parameters withRequestUrl:requestURL withIndicatorView:nil
                                 withCancelSubject:nil onRequestStart:^(ITTBaseDataRequest *request){}onRequestFinished:^(ITTBaseDataRequest *request){
                                    // NSLog(@"request result:%@",request.handleredResult);
                                    // [self  modifyUserAvatarUrl:requestURL];
//                                     [[PersonalCenterViewController getPersonalCenterViewController] isUploadAvatarByAvatarDataSccess:YES];
                                         if (_completion) {
                                             _completion(true,requestURL);
                                         }

                                    
                                    }
                                    onRequestCanceled:^(ITTBaseDataRequest *request){
//                                               [[PersonalCenterViewController getPersonalCenterViewController] isUploadAvatarByAvatarDataSccess:NO];
                                        if (_completion) {
                                            _completion(false,nil);
                                        }

                                    }
                                   onRequestFailed:^(ITTBaseDataRequest *request){
//                                              [[PersonalCenterViewController getPersonalCenterViewController] isUploadAvatarByAvatarDataSccess:NO];
                                    //   [[NSNotificationCenter defaultCenter] postNotificationName:@"HEADIMAGE_SUCCESS" object:nil userInfo:nil];
                                       if (_completion) {
                                           _completion(true,requestURL);
                                       }
//                                       if (completion) {
//                                           completion(false,nil);
//                                       }

                                   }];
   // NSLog(@"sdfadsf");
}


+ (void)getUserDeviceWhenCompletion:(void (^)(BOOL, id))completion
{
    NSDate * nowDate = [NSDate date];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"yyyyMMddhhmmss";
    NSString * dateString = [dateFormatter stringFromDate:nowDate];
    
    NSString * sequenceidStr = [NSString stringWithFormat:@"%@000001",dateString];
    
    NSString * requestUrl = [NSString stringWithFormat:@"%@/users/%@/devices?sequenceId=%@&typeIdentifier=%@",COMMON_SERVER_ADDRESS,DATA_ENV.userid,sequenceidStr,TYPE_INDITIFIER];
    
    [QueryUserInfoRequest requestWithParameters:nil withRequestUrl:requestUrl withIndicatorView:nil
                              withCancelSubject:nil
                                 onRequestStart:^(ITTBaseDataRequest *request){}
                              onRequestFinished:^(ITTBaseDataRequest *request){
                                 // NSLog(@"get devices result :%@",request.handleredResult[@"retInfo"]);

                                  if ([[request.handleredResult objectForKey:@"retCode"] isEqualToString:@"00000"]) {
                                      if (completion) {
                                          completion(TRUE,[request.handleredResult objectForKey:@"devices"]);
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

+ (void)bindDeviceByDevice:(NSDictionary *)deviceDict completion:(void (^)(BOOL, id))completion
{
    
    NSString * requestUrl = [NSString stringWithFormat:@"%@/users/%@/devices",COMMON_SERVER_ADDRESS,DATA_ENV.userid];
    NSString * jsonString = [NSJSONSerialization jsonStringFromDictionary:deviceDict];
    NSDictionary * parameters = @{@"body": jsonString};
   // NSLog(@"parameters---%@",parameters);
    [BindDeviceRequest requestWithParameters:parameters withRequestUrl:requestUrl withIndicatorView:nil
                              withCancelSubject:nil
                                 onRequestStart:^(ITTBaseDataRequest *request){}
                              onRequestFinished:^(ITTBaseDataRequest *request){
                               //   NSLog(@"bindDeive result------------ :%@",request.handleredResult[@"retInfo"]);

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
                               //     NSLog(@"请求失败");
                                    if (completion) {
                                        completion(FALSE,@"请求失败");
                                    }
                                }];

}

+ (void)unbindDeviceByUserIds:(NSArray *)userIdArray completion:(void (^)(BOOL, id))completion
{
    
   // NSLog(@"9999999%@",DATA_ENV.device.deviceMac);
   // DATA_ENV.device.deviceMac = @"sdf";
    NSDate * nowDate = [NSDate date];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"yyyyMMddhhmmss";
    NSString * dateString = [dateFormatter stringFromDate:nowDate];
    
    NSString * sequenceidStr = [NSString stringWithFormat:@"%@000001",dateString];

    NSMutableString * deviceidStr = [NSMutableString stringWithString:DATA_ENV.deviceMac];
    [deviceidStr replaceOccurrencesOfString:@":" withString:@"" options:1 range:NSMakeRange(0, deviceidStr.length)];
    
   // NSString * userIds = [userIdArray firstObject];
   // NSString * requestUrl = [NSString stringWithFormat:@"%@/users/%@/devices/%@?sequenceId=%@&userIds=%@",COMMON_SERVER_ADDRESS,SAVEUSERDATA.userid,deviceidStr,sequenceidStr,userIds];
    NSString * requestUrl = [NSString stringWithFormat:@"%@/users/%@/devices/%@?sequenceId=%@&userIds=%@",COMMON_SERVER_ADDRESS,DATA_ENV.userid,deviceidStr,sequenceidStr,DATA_ENV.userid];
    
    
    [UnbindDeviceRequest requestWithParameters:nil withRequestUrl:requestUrl withIndicatorView:nil
                           withCancelSubject:nil
                              onRequestStart:^(ITTBaseDataRequest *request){}
                           onRequestFinished:^(ITTBaseDataRequest *request){
                              // NSLog(@"解绑bindDeive result------------ :%@",request.handleredResult);
                               
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

+ (void)renameDeiveByNewname:(NSString *)newname completion:(void (^)(BOOL, id))completion
{
    NSDate * nowDate = [NSDate date];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"yyyyMMddhhmmss";
    NSString * dateString = [dateFormatter stringFromDate:nowDate];
    
    NSString * sequenceidStr = [NSString stringWithFormat:@"%@000001",dateString];
    
//    NSString * deviceid = [DATA_ENV.deviceId stringByReplacingOccurrencesOfString:@":" withString:@""];
//    NSLog(@"deviceid-----------%@",deviceid);
   // NSString * requestUrl = [NSString stringWithFormat:@"%@/users/%@/devices/%@/name",COMMON_SERVER_ADDRESS,SAVEUSERDATA.userid,SAVEUSERDATA.deviceId];
    NSString * requestUrl = [NSString stringWithFormat:@"%@/users/%@/devices/%@/name",COMMON_SERVER_ADDRESS,DATA_ENV.userid,DATA_ENV.deviceMac];
   // NSLog(@"newname--%@",requestUrl);
    NSDictionary * params = @{@"name": newname,
                              @"sequenceId":sequenceidStr};
    NSString * jsonString = [NSJSONSerialization jsonStringFromDictionary:params];
    
    NSDictionary * parameters = @{@"body": jsonString};
    
    [RenameDeviceRequest requestWithParameters:parameters withRequestUrl:requestUrl withIndicatorView:nil
                           withCancelSubject:nil
                              onRequestStart:^(ITTBaseDataRequest *request){}
                           onRequestFinished:^(ITTBaseDataRequest *request){
                              // NSLog(@"重命名bindDeive result------------ :%@",request.handleredResult);
                               
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

+ (void)queryDeviceInfoWhenCompletion:(void (^)(BOOL, id))completion
{
    NSString * requestUrl = [NSString stringWithFormat:@"%@/devices/%@",COMMON_SERVER_ADDRESS,DATA_ENV.deviceId];
    [QueryDeviceInfoRequest requestWithParameters:nil withRequestUrl:requestUrl withIndicatorView:nil
                             withCancelSubject:nil
                                onRequestStart:^(ITTBaseDataRequest *request){}
                             onRequestFinished:^(ITTBaseDataRequest *request){
//                                 NSLog(@"DeiveInfo result------------ :%@",request.handleredResult);
                                 
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
