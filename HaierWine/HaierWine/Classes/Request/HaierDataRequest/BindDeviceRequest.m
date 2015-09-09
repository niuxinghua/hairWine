//
//  BindDeviceRequest.m
//  HaierIceBox
//
//  Created by Jeremy on 14-6-10.
//
//

#import "BindDeviceRequest.h"

@implementation BindDeviceRequest

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
