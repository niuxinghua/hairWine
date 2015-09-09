//
//  QueryDeviceInfoRequest.m
//  HaierIceBox
//
//  Created by Jeremy on 14-6-10.
//
//

#import "QueryDeviceInfoRequest.h"

@implementation QueryDeviceInfoRequest

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
