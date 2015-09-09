//
//  AppDelegate.m
//  iTotemMinFramework
//
//  Created by  on 12-8-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <uSDKFramework/uSDKDeviceManager.h>
#import <uSDKFramework/uSDKManager.h>
#import <uSDKFramework/uSDKDevice.h>
#import <uSDKFramework/uSDKNotificationCenter.h>
#import "AppDelegate.h"
#import "MenuViewController.h"
#import "PKRevealController.h"
#import "HaierSDK.h"
#import "LoginViewController.h"
#import "BindDeviceRequest.h"
#import "WineManager.h"
#import "BaseNavigationController.h"
#import "UIImageView+WebCache.h"
#import "PushMessage.h"
#import "CustomMessageAlertView.h"
#import "WineShop.h"
#import "ASIHTTPRequest.h"
#import "HaierDataCacheManager.h"
#import "LoginManager.h"
#import "Reachability.h"

@interface AppDelegate ()<ASIHTTPRequestDelegate,ITTImageViewDelegate,FirstHelpViewControllerDelegate>
{
}

@end

@implementation AppDelegate
{
    NSTimer *_timer;
    NSString *_picName;
    NSString *_pushMessage;
}
static AppDelegate *_appDelegate;

+ (AppDelegate *)getAppDelegate
{
    return _appDelegate;
}

- (void)imageViewDidLoaded:(ITTImageView *)imageView image:(UIImage*)image
{
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
//    NSString *str = @"mmnull";
//     NSRange range = NSMakeRange(str.length-4, 4);
//    str = [str substringWithRange:range];
    
      //[self getDevieTime];
    // [SavePushMassage shareSavePushMassage ] addPushMessage:nil
    //[[UIApplication sharedApplication] setApplicationIconBadgeNumber:1];
    // [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    //  NSLog(@"*******%@",launchOptions);
    //  NSString *str = [NSString stringWithFormat:@"%@",launchOptions];
    // [UIAlertView popupAlertByDelegate:nil title:nil message:str];
    //   [[UIApplication sharedApplication] cancelAllLocalNotifications];
    // NSMutableArray *pushArray = [[NSMutableArray alloc]initWithArray:DATA_ENV.pushMessageArray];
    //    WineShop *shop = [[WineShop alloc]init];
    //    shop.winePrice = @"9";
    //    NSArray *array = @[shop];
    //    [[HaierDataCacheManager sharedManager] addData:array WithKey:@"array"];
    //
    //    NSLog(@"缓存-%@",[[HaierDataCacheManager sharedManager] getDataForKey:@"array"] );
    //    [[HaierDataCacheManager sharedManager] addDetailKey:@"12"];
    //    NSLog(@"%@",[[HaierDataCacheManager sharedManager] getDataWithKey:@"HaierDetail"]);
    
    if (launchOptions != nil){
        if(DATA_ENV.pushMessageArray == nil){
            NSMutableArray *array = [[NSMutableArray alloc]init];
            DATA_ENV.pushMessageArray = array;
        }
        NSMutableArray *pushArray = [[NSMutableArray alloc]initWithArray:DATA_ENV.pushMessageArray];
        NSDictionary *dict = launchOptions[@"UIApplicationLaunchOptionsRemoteNotificationKey"][@"aps"];
        PushMessage *pushMessage = [[PushMessage alloc]initWithDataDic:dict];
        pushMessage.type = @"1";
        pushMessage.messageTime = [self getDevieTime];
        [pushArray addObject:pushMessage];
        DATA_ENV.pushMessageArray = pushArray;
    }
    _appDelegate = self;
    
    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor blackColor];
    MainViewController *maiViewController = [[MainViewController alloc]init];
    maiViewController.isNoShowLogin = YES;
    // maiViewController.isWineBox = NO;
    //   MyViewController *myViewController = [[MyViewController alloc]init];
    BaseNavigationController *frontViewController = [[BaseNavigationController alloc] initWithRootViewController:maiViewController];
    frontViewController.hidesBottomBarWhenPushed = YES;
    frontViewController.navigationBarHidden = YES;
    
    MenuViewController *leftViewController = [[MenuViewController alloc] init];
    leftViewController.mainViewController = maiViewController;
    // leftViewController.delegate = maiViewController
    self.revealController = [PKRevealController revealControllerWithFrontViewController:frontViewController
                                                                     leftViewController:leftViewController
                                                                                options:nil];
    //    LoginViewController *lvc = [[LoginViewController alloc]init];
    //    UINavigationController *nvc = [[UINavigationController alloc]initWithRootViewController:lvc];
    if (isIOS7()) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    } else {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    }
    //  OneViewController *one = [[OneViewController alloc]init];
    
    
//    self.window.rootViewController = self.revealController;
    //开机帮助
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]){
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
        //        NSLog(@"第一次启动");
        DATA_ENV.isAutoLogin = YES;
        FirstHelpViewController *helpVc = [[FirstHelpViewController alloc]init];
        helpVc.delegate = self;
        self.window.rootViewController = helpVc;
        [self getPicURLRequest];
        // [self startLogoRequest];
        [self.window makeKeyAndVisible];
    } else {
        Reachability *r = [Reachability reachabilityWithHostName:@"www.baidu.com"];
        if ([r currentReachabilityStatus] == NotReachable) {
            self.window.rootViewController = self.revealController;
            [self.window makeKeyAndVisible];
        } else {
            NSString *flashImageUrl = [[NSUserDefaults standardUserDefaults] objectForKey:@"flash_pic_m"];
            if (flashImageUrl.length > 0) {
                [self addPic];
            } else {
                self.window.rootViewController = self.revealController;
                [self.window makeKeyAndVisible];
            }
        }

        [self getPicURLRequest];
    }

    //消息推送支持的类型
    UIRemoteNotificationType types =
    (UIRemoteNotificationTypeBadge
     |UIRemoteNotificationTypeSound
     |UIRemoteNotificationTypeAlert);
    //注册消息推送
    [[UIApplication sharedApplication]registerForRemoteNotificationTypes:types];
    
    return YES;
}

-(void)clickNow
{
    self.window.rootViewController = self.revealController;
}

#pragma mark - startLogoRequest method

- (void)addPic
{
    //    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    if (is4InchScreen()) {
       // _picName = @"flash_pic";
        if ([[NSUserDefaults standardUserDefaults]objectForKey:@"flash_pic"]==nil) {
            self.window.rootViewController = self.revealController;
            [self.window makeKeyAndVisible];
            return;
        } else {
            _picName = [[NSUserDefaults standardUserDefaults]objectForKey:@"flash_pic"];
        }
    } else {
       // _picName = @"flash_pic_m";
        if ([[NSUserDefaults standardUserDefaults]objectForKey:@"flash_pic_m"]==nil) {
            self.window.rootViewController = self.revealController;
            [self.window makeKeyAndVisible];
            return;
        } else {
            _picName = [[NSUserDefaults standardUserDefaults]objectForKey:@"flash_pic"];
        }

        
    }
    //    NSString *picPath = [docDir stringByAppendingPathComponent:_picName]; //获取路径
    //
    //    if ([[NSFileManager defaultManager] fileExistsAtPath:picPath]) {
    //
    //        //存在图片的时候直接读取
    //
    //        NSData *data = [NSData dataWithContentsOfFile:picPath];
    _splashView = [[ITTImageView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [_splashView loadImage:_picName];
    _splashView.delegate = self;
    //        _splashView.userInteractionEnabled = YES;
    //        _splashView.image = [UIImage imageWithData:data];
    [self.window makeKeyAndVisible];
    [self.window addSubview:_splashView];
    [self.window bringSubviewToFront:_splashView];
    _timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(startFlashImageTimeUp) userInfo:nil repeats:NO];
    
    //    }
}

- (void)getPicURLRequest
{
    NSMutableDictionary* dic = [[NSMutableDictionary alloc]init];
    [dic setValue:@"ios" forKey:@"type"];
    [dic setValue:@"p" forKey:@"picSize"];
    [StartLogoRequest requestWithParameters:dic withIndicatorView:nil withCancelSubject:nil onRequestStart:nil onRequestFinished:^(ITTBaseDataRequest *request) {
        
        if ([request isSuccess]) {
            if ([request.handleredResult[@"result"] isEqualToString:@"0"]) {
                NSString *picUrlStr = request.handleredResult[@"data"][@"flash_pic"];
                NSRange range = NSMakeRange(picUrlStr.length-4, 4);
               NSString * picUrlStr1 = [picUrlStr substringWithRange:range];
                if (![picUrlStr1 isEqualToString:@"null"]) {
                [[NSUserDefaults standardUserDefaults]setObject:picUrlStr forKey:@"flash_pic"];                }

                
                NSString *picUrlStrM = request.handleredResult[@"data"][@"flash_pic_m"];
                range = NSMakeRange(picUrlStrM.length-4, 4);
              NSString *picUrlStrM1 = [picUrlStrM substringWithRange:range];
                if (![picUrlStrM1 isEqualToString:@"null"]) {
                    [[NSUserDefaults standardUserDefaults]setObject:picUrlStrM forKey:@"flash_pic_m"];
                }

                //                [NSThread detachNewThreadSelector:@selector(loadImage) toTarget:self withObject:nil];
            }
        }
        
    } onRequestCanceled:nil onRequestFailed:^(ITTBaseDataRequest *request) {
        //       [self.window makeKeyAndVisible];
    }];
    
}

- (void)loadImage {
    
    //下载图片
    NSURL *url;
    NSString *str;
    if (is4InchScreen()) {
        str = [[NSUserDefaults standardUserDefaults]objectForKey:@"flash_pic"];
        url=[NSURL URLWithString:str];
        _picName = @"flash_pic";
        
    } else {
        str = [[NSUserDefaults standardUserDefaults]objectForKey:@"flash_pic_m"];
        url=[NSURL URLWithString:str];
        _picName = @"flash_pic_m";
        
    }
    
    UIImage *img = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:url]];
    
    // self.thumbnail.image = img;
    
    
    
    //存储图片
    
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *picPath=[docDir stringByAppendingPathComponent:_picName];
    
    //将图片写到Documents文件中
    
    [UIImagePNGRepresentation(img) writeToFile: picPath atomically:YES];
    
    //线程退出
    
    [NSThread exit];
    
}

-(void)startFlashImageTimeUp
{
    self.window.rootViewController = self.revealController;
    [self.window makeKeyAndVisible];
    [UIView animateWithDuration:1 animations:^{
        _splashView.alpha = 0;
        
    } completion:^(BOOL finished) {
        if (finished) {
            [_splashView removeFromSuperview];
            [_timer invalidate];
            
        }
    }];
}

#pragma mark - RemoteNotifications
//获取DeviceToken成功
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    // NSString *token = [NSString string
    //   DATA_ENV.iosDeviceToken =
    NSString* dt = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    dt = [dt stringByReplacingOccurrencesOfString:@" " withString:@""];
    
   // NSLog(@"deviceToken:%@-%d", dt,dt.length);
    DATA_ENV.iosDeviceToken = dt;
   // NSLog(@"4444%@",DATA_ENV.iosDeviceToken);
    //这里进行的操作，是将Device Token发送到服务端
}

//注册消息推送失败
- (void)application:(UIApplication *)application
didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    // NSString *error_str = [NSString stringWithFormat: @"%@", error];
    //    UIAlertView *alert =
    //    [[UIAlertView alloc] initWithTitle:@"温馨提示"
    //                               message:error_str
    //                              delegate:nil
    //                     cancelButtonTitle:@"确定"
    //                     otherButtonTitles:nil];
    // [alert show];
    
    //  NSLog(@"Failed to get token, error:%@", error_str);
}

//处理收到的消息推送
- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
{
  //  NSLog(@"Receive remote notification : %@",application.scheduledLocalNotifications);
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:1];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    if(DATA_ENV.pushMessageArray == nil){
        NSArray *array = [[NSArray alloc]init];
        DATA_ENV.pushMessageArray = array;
    }
    NSArray *array1 = DATA_ENV.pushMessageArray;
 //   NSLog(@"rrrrr%@",array1);
    NSMutableArray *pushArray = [[NSMutableArray alloc]initWithArray:DATA_ENV.pushMessageArray];
    NSDictionary *dict = userInfo[@"aps"];
    PushMessage *pushMessage = [[PushMessage alloc]initWithDataDic:dict];
    //9.26
    pushMessage.messageTitle = [pushMessage.messageTitle stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //  NSLog(@"pushMessage--%@",pushMessage);
    //9.26
    pushMessage.type = @"1";
    pushMessage.messageTime = [self getDevieTime];
    // if (![_pushMessage isEqualToString: pushMessage.messageTitle]) {
    //   _pushMessage = pushMessage.messageTitle;
    [pushArray addObject:pushMessage];
    // }
   // NSLog(@"消息推送pushArray--%@",pushArray);
    DATA_ENV.pushMessageArray = pushArray;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"RECEIVEPUSHMESSAGE" object:nil userInfo:nil];
  //  NSLog(@"消息推送--%@",DATA_ENV.pushMessageArray);
    
}

#pragma mark - getDevieTime
- (NSString *)getDevieTime
{
    NSDate *senddate=[NSDate date];
    
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];//@"YYYY-MM-dd"
    NSString *locationString=[dateformatter stringFromDate:senddate];
  //  NSLog(@"%@",locationString);
    return locationString;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // NSLog(@"application%@",application.scheduledLocalNotifications);
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    //[[WineManager shareWineManager] startHaierUSDK];
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    //    if (!DATA_ENV.isAutoLogin) {
    //        [LoginManager logoutRequestWhenCompletion:^(BOOL isSuccess, NSString *returnMsg) {
    //            //  NSString *message;
    //            if (isSuccess) {
    //                //     message = @"退出成功";
    //                DATA_ENV.isLocalOnline = NO;
    //                DATA_ENV.isBindingDevice = NO;
    //                DATA_ENV.isVistor = YES;
    //                //首页
    //                
    //            }
    //        }];
    //
    //    }
}

#pragma mark - FirstHelpViewControllerDelegate

-(void)didClickNowButton
{
    [self clickNow];
}


@end
