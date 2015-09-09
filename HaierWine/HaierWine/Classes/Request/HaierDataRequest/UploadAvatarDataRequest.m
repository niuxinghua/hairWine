//
//  UploadAvatarDataRequest.m
//  HaierIceBox
//
//  Created by Jeremy on 14-6-21.
//
//

#import "UploadAvatarDataRequest.h"

@implementation UploadAvatarDataRequest

- (ITTRequestMethod)getRequestMethod
{
    return ITTRequestMethodPut;
}

- (NSString *)getRequestUrl
{
    return nil;
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
