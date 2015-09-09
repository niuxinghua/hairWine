//
//  HaierBaseDataRequest.m
//  HaierIceBox
//
//  Created by Mao on 14-6-25.
//
//

#import "HaierBaseDataRequest.h"
#import "AppDelegate.h"
//#import "APService.h"
#import "LoginViewController.h"
#import "PersonInfoManager.h"
#import "PasswordPreventMoreManager.h"
@implementation HaierBaseDataRequest

- (void)processResult
{
    NSString * errCode =[self.handleredResult objectForKey:@"retCode"];
    NSString * message= [self.handleredResult objectForKey:@"retInfo"];
    if ([errCode intValue]==21018) {
        UIViewController * vc =APPDELEGATE.window.rootViewController ;
        if ([vc isKindOfClass:[UINavigationController class]]) {
            UINavigationController *nav = (UINavigationController *)APPDELEGATE.window.rootViewController;
            ITTDINFO(@"%@", nav.topViewController);
            if ([nav.topViewController isKindOfClass:[LoginViewController class]]) {
                return;
            }else {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
              //  [alertView show];
             //   [self clearUserInfo];
            //    APPDELEGATE.window.rootViewController= [APPDELEGATE getLoginVC];
                return;
            }
        }else{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
          //  [alertView show];
          //  [self clearUserInfo];
         //   APPDELEGATE.window.rootViewController= [APPDELEGATE getLoginVC];
            return;
        }

    }else{
        [super processResult];
    }
  
}
-(void) clearUserInfo
{
    //清除用户个人信息
     [[PersonInfoManager sharedPersonInfoManager] cleanPersonInfo];    //清除本地冰箱卫士设备信息
 //   [[FridgeInofManager sharedFridgeInofManager] cleanFridgeInfo];
    //清除记住密码
    DATA_ENV.isMemory = NO;
    //清除绑定状态
  //  DATA_ENV.isBindingDevice = NO;
    // 清除本地登陆状态
    DATA_ENV.isLocalOnline = NO;
    // 清除version信息
    DATA_ENV.hasNewVersion = NO;
    // 清除密码防刷缓存
   // [PASSWOR_MANAGER clearCache];
    //清除用户id userId
    
    [[ITTDataCacheManager sharedManager] removeObjectInCacheByKey:KEY_CACHE_USER_ID];
    //清除用户token accessToken
    [[ITTDataCacheManager sharedManager] removeObjectInCacheByKey:KEY_CACHE_USER_ACCESSTOKEN];
    //清除设备id deviceId
    [[ITTDataCacheManager sharedManager] removeObjectInCacheByKey:KEY_CACHE_DEVICE_ID];
    //清除本地版本verion
    //                 [[ITTDataCacheManager sharedManager] removeObjectInCacheByKey:KEY_CACHE_VERSION_MODEL];
    //置空推送alias
  //  [APService setAlias:@"" callbackSelector:nil object:nil];
    //置空推送的tags
  //  [APService setTags:[NSSet set] callbackSelector:nil object:nil];
}
@end
