//
//  LogoutRequest.m
//  HaierIceBox
//
//  Created by Jeremy on 14-6-6.
//
//

#import "LogoutRequest.h"

@implementation LogoutRequest

- (ITTRequestMethod)getRequestMethod
{
    return ITTRequestMethodPost;
}

- (NSString *)getRequestUrl
{
    //return  @"http://103.8.220.165:60000/miniwine/m/casClient/logout";
    return [NSString stringWithFormat:@"%@/security/userlogout",SECURITY_LOGIN];
}

- (void)processResult
{
    [super processResult];
}

- (ITTParameterEncoding)parmaterEncoding
{
    return ITTJSONParameterEncoding;
}

@end
