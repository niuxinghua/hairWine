//
//  RegisterRequest.m
//  HaierWine
//
//  Created by isoftstone on 14-7-3.
//
//

#import "RegisterRequest.h"

@implementation RegisterRequest

- (ITTRequestMethod)getRequestMethod
{
    return ITTRequestMethodPost;
}

- (NSString *)getRequestUrl
{
    return [NSString stringWithFormat:@"%@/users/register",COMMON_SERVER_ADDRESS];
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
