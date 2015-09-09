//
//  RenameDeviceRequest.m
//  HaierIceBox
//
//  Created by Jeremy on 14-6-10.
//
//

#import "RenameDeviceRequest.h"

@implementation RenameDeviceRequest

- (ITTRequestMethod)getRequestMethod
{
    return ITTRequestMethodPut;
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
