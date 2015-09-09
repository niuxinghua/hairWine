//
//  UploadAvatarRequest.m
//  HaierIceBox
//
//  Created by Jeremy on 14-6-13.
//
//

#import "UploadAvatarRequest.h"

@implementation UploadAvatarRequest

- (ITTRequestMethod)getRequestMethod
{
    return ITTRequestMethodPost;
}

- (NSString *)getRequestUrl
{
    return [NSString stringWithFormat:@"%@/resources/assignUri",COMMON_SERVER_ADDRESS];
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
