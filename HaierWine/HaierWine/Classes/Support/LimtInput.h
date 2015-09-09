//
//  LimtInput.h
//  输入框对输入字符的限制
//
//  Created by 张作伟 on 14-10-16.
//  Copyright (c) 2014年 isoftstone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

#define PROPERTY_NAME @"limit"

#define DECLARE_PROPERTY(className) \
@interface className (Limit) @end

DECLARE_PROPERTY(UITextField)
DECLARE_PROPERTY(UITextView)

@interface LimtInput : NSObject

@property(nonatomic ,assign)BOOL enableLimitCount;

+(LimtInput *)sharedInstance;

@end
