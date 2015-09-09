//
//  GetAuchcodeRequest.m
//  HaierIceBox
//
//  Created by Jeremy on 14-6-9.
//
//

#import "GetAuchcodeRequest.h"

@implementation GetAuchcodeRequest

- (ITTRequestMethod)getRequestMethod
{
    return ITTRequestMethodPost;
}

- (NSString *)getRequestUrl
{
    return [NSString stringWithFormat:@"%@/uvcs",COMMON_SERVER_ADDRESS];
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
