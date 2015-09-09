//
//  UnbindDeviceRequest.m
//  HaierIceBox
//
//  Created by Jeremy on 14-6-10.
//
//

#import "UnbindDeviceRequest.h"

@implementation UnbindDeviceRequest

- (ITTRequestMethod)getRequestMethod
{
    return ITTRequestMethodDelete;
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
