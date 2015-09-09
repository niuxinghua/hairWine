//
//  VerifyAuthcodeRequest.m
//  HaierIceBox
//
//  Created by Jeremy on 14-6-9.
//
//

#import "VerifyAuthcodeRequest.h"

@implementation VerifyAuthcodeRequest

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
