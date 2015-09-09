//
//  ModifyUserProfileRequest.m
//  HaierIceBox
//
//  Created by Jeremy on 14-6-9.
//
//

#import "ModifyUserProfileRequest.h"

@implementation ModifyUserProfileRequest

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
  //  NSLog(@"%@",self.handleredResult);
}

- (ITTParameterEncoding)parmaterEncoding
{
    return ITTJSONParameterEncoding;
}

@end
