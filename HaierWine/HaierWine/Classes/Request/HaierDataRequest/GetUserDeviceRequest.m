//
//  GetUserDeviceRequest.m
//  HaierIceBox
//
//  Created by Jeremy on 14-6-10.
//
//

#import "GetUserDeviceRequest.h"

@implementation GetUserDeviceRequest

- (ITTRequestMethod)getRequestMethod
{
    return ITTRequestMethodGet;
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
