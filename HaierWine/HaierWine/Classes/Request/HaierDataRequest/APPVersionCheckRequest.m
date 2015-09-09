//
//  APPVersionCheckRequest.m
//  HaierIceBox
//
//  Created by Jeremy on 14-6-20.
//
//

#import "APPVersionCheckRequest.h"
#import "AppVersionModel.h"
@implementation APPVersionCheckRequest

- (ITTRequestMethod)getRequestMethod
{
    return ITTRequestMethodGet;
}

- (NSString *)getRequestUrl
{
    return [NSString stringWithFormat:@"%@/appVersion/%@/latest",COMMON_SERVER_ADDRESS,APPID];
}

- (void)processResult
{
    [super processResult];
}

- (ITTParameterEncoding)parmaterEncoding
{
    return ITTJSONParameterEncoding;
}

+ (void)appVersionRequestCompletion:(void (^)(BOOL, id))completion
{
    [APPVersionCheckRequest requestWithParameters:nil withRequestUrl:nil withIndicatorView:nil
                                withCancelSubject:nil
                                   onRequestStart:^(ITTBaseDataRequest *request){}
                                onRequestFinished:^(ITTBaseDataRequest *request){
                                 //   NSLog(@"request result--------: %@",request.handleredResult);
                                    if ([[request.handleredResult objectForKey:@"retCode"] isEqualToString:@"00000"]) {
                                        AppVersionModel * versionModel = [[AppVersionModel alloc]init];
                                        versionModel.verion = [request.handleredResult objectForKey:@"version"];
                                        versionModel.verionName = [request.handleredResult objectForKey:@"versionName"];
                                        versionModel.description = [request.handleredResult objectForKey:@"description"];
                                        versionModel.resId = [request.handleredResult objectForKey:@"resId"];
                                        versionModel.status = [[request.handleredResult objectForKey:@"status"] intValue];
                                        versionModel.force = [[request.handleredResult objectForKey:@"force"] boolValue];
                                        completion(YES,versionModel);
                                    }else{
                                        completion(NO,[request.handleredResult objectForKey:@"retInfo"]);
                                    }
                                }
                                onRequestCanceled:^(ITTBaseDataRequest *request){
                                    completion(NO,@"请求取消");
                                }
                                  onRequestFailed:^(ITTBaseDataRequest *request){
                                      completion(NO,@"请求失败");
                                  }];

}



@end
