//
//  LoginRequest.m
//  HaierIceBox
//
//  Created by Jeremy on 14-6-6.
//
//

#import "LoginRequest.h"

@implementation LoginRequest

- (ITTRequestMethod)getRequestMethod
{
    return ITTRequestMethodPost;
}

- (NSString *)getRequestUrl
{
    return [NSString stringWithFormat:@"%@/security/userlogin",SECURITY_LOGIN];
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
