//
//  QueryUserInfoRequest.m
//  HaierIceBox
//
//  Created by Jeremy on 14-6-10.
//
//

#import "QueryUserInfoRequest.h"
#import "Personal.h"
#import "WineDevice.h"
@implementation QueryUserInfoRequest

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
   // NSLog(@"绑定的设备------%@",self.handleredResult);
    if (![self.handleredResult[@"retCode"] isEqualToString:@"00000"]) {
        DATA_ENV.deviceMac = nil;
        return;
    }
    //  NSLog(@"%@",self.handleredResult[@"retInfo"]);
    if ([self isSuccess]) {
        NSDictionary *user = self.handleredResult[@"user"];        
        if (user != nil) {
            //    NSLog(@"%@",user[@"userProfile"]);
            UserBase *userBase = [[UserBase alloc]initWithDataDic:user[@"userBase"]];
            UserProfile *userProfile = [[UserProfile alloc]initWithDataDic:user[@"userProfile"]];
            //     NSLog(@"%@8888888888",userProfile.nickName);
            Personal *person = [[Personal alloc]init];
            person.userBase = userBase;
            person.userProfile = userProfile;
            DATA_ENV.userNickName = userProfile.nickName;
            DATA_ENV.userAvatarUrl = userProfile.avatarUrl;
            DATA_ENV.person = person;
          //  NSLog(@"nickName--%@",DATA_ENV.person.userProfile.nickName);x
          //  NSLog(@"avatarUrl--%@",DATA_ENV.userAvatarUrl);
        }else {
            if (![self.handleredResult[@"retCode"] isEqualToString:@"00000"]) {
                return;
            }
            NSArray *devices = self.handleredResult[@"devices"];
            if (devices.count == 0) {
                DATA_ENV.isBindingDevice = NO;
                DATA_ENV.deviceMac = nil;
                return;
            }
            for (NSDictionary *dict in devices) {
                if ([dict[@"type"][@"type"] isEqualToString:DEVICE_TYPE]) {
                    DATA_ENV.isBindingDevice = YES;
                    WineDevice *device = [[WineDevice alloc]init];
                    device.deviceMac = dict[@"mac"];
                    device.eProtocolVer = dict[@"version"][@"eProtocolVer"];
                    device.deviceName = dict[@"name"];
                    device.deviceLocation = dict[@"location"];
                    device.deviceType = dict[@"type"][@"type"];
                    device.typeIdentifier = dict[@"type"][@"typeIdentifier"];
                    device.smartLinkPlatform = dict[@"version"][@"smartlink"][@"smartLinkPlatform"];
                    device.smartLinkSoftwareVersion = dict[@"version"][@"smartlink"][@"smartLinkSoftwareVersion"];
                  //  NSLog(@"deviceMac-%@",device.deviceMac);
                    DATA_ENV.deviceMac = device.deviceMac;
                    DATA_ENV.deviceName = device.deviceName;
                  //  NSLog(@"DATA_ENV.deviceMac-%@",DATA_ENV.deviceMac);

                    DATA_ENV.device = device;
                } else {
                    DATA_ENV.isBindingDevice = NO;
                    DATA_ENV.deviceMac = nil;

                }
            }
            
            
        }
    }
  //  DATA_ENV.isBindingDevice = YES;

}

- (ITTParameterEncoding)parmaterEncoding
{
    return ITTJSONParameterEncoding;
}

@end
