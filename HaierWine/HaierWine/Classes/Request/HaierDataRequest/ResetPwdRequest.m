//
//  ResetPwdRequest.m
//  HaierIceBox
//
//  Created by Jeremy on 14-6-8.
//
//

#import "ResetPwdRequest.h"

@implementation ResetPwdRequest

- (ITTRequestMethod)getRequestMethod
{
    return ITTRequestMethodPost;
}

- (NSString *)getRequestUrl
{
    return Nil;
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
