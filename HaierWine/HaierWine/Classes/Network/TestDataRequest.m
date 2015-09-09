//
//  TestDataRequest.m
//  iTotemMinFramework
//
//  Created by Sword Zhou on 7/17/13.
//
//

#import "TestDataRequest.h"

@implementation TestDataRequest

- (ITTRequestMethod)getRequestMethod
{
    return ITTRequestMethodPost;
}

- (NSString*)getRequestUrl
{
    return @"http://www.raywenderlich.com/downloads/weather_sample/weather.php";
    //    return @"http://172.16.10.198/newspaper/admin/index.php?m=api&c=news&a=huajian";
    //    return @"http://172.16.10.90/search.php";
}

- (void)processResult
{
    [super processResult];
}
@end
