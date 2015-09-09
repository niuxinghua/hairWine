//
//  LoginManager.h
//  HaierIceBox
//
//  Created by Jeremy on 14-6-6.
//
//

#import <Foundation/Foundation.h>
typedef void (^requestSuccess)(BOOL isSuccess,NSString * returnMsg);

@interface LoginManager : NSObject

+ (void)loginRequestWithLoginID:(NSString *)loginid password:(NSString *)password isAutoLogin:(BOOL)autoLogin completion:(requestSuccess)completion;

+ (void)logoutRequestWhenCompletion:(void(^)(BOOL isSuccess,NSString * returnMsg))completion;
+ (void)getUserBindingDeviceCompletion:(requestSuccess)completion;
+ (void)getBoxWineRequestCompletion:(requestSuccess)completion;


@end


@interface RegisterManager : NSObject

+(void)registRequest;

@end