//
//  LimtInput.m
//  输入框对输入字符的限制
//
//  Created by 张作伟 on 14-10-16.
//  Copyright (c) 2014年 isoftstone. All rights reserved.
//

#import "LimtInput.h"
#define RUNTIME_ADD_PROPERTY(propertyName) \
- (id)valueForUndefinedKey:(NSString *)key \
{ \
    if ([key isEqualToString:PROPERTY_NAME] ) { \
        return objc_getAssociatedObject(self, key.UTF8String); \
    } \
    return nil; \
} \
- (void)setValue:(id)value forUndefinedKey:(NSString *)key \
{ \
    if ([key isEqualToString:PROPERTY_NAME]) { \
        objc_setAssociatedObject(self, key.UTF8String, value, OBJC_ASSOCIATION_RETAIN); \
    } \
}

#define IMPLEMENT_PROPERTY(className) \
@implementation className (Limit) RUNTIME_ADD_PROPERTY(PROPERTY_NAME) @end

IMPLEMENT_PROPERTY(UITextField)
IMPLEMENT_PROPERTY(UITextView)

@implementation LimtInput

+(void)load
{
    [super load];
    [LimtInput sharedInstance];
}

+(LimtInput *)sharedInstance
{
    static LimtInput *g_limitInput;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        g_limitInput = [[LimtInput alloc]init];
        g_limitInput.enableLimitCount = YES;
    });
    
    return g_limitInput;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewDidChange:) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}

- (void)textFieldDidChange:(NSNotification *)notification
{
    if (!self.enableLimitCount) return;
    NSInteger count = 1000;
    UITextField *textField = (UITextField *)notification.object;
    if (textField.tag == 18) {
        count = 8;
    } else if(textField.tag ==111){
        count = 11;
    } else if (textField.tag == 116){
        count = 16;
    }
  //  NSNumber *number = [textField valueForKey:PROPERTY_NAME];
    if (textField.text.length > count && textField.markedTextRange == nil) {
        textField.text = [textField.text substringWithRange:NSMakeRange(0, count)];
    }}

- (void)textViewDidChange:(NSNotification *)notification
{
    if (!self.enableLimitCount) return;
    UITextView *textView = (UITextView *)notification.object;
    NSNumber *number = [textView valueForKey:PROPERTY_NAME];
    if (number&&textView.text.length > [number integerValue] && textView.markedTextRange == nil) {
        textView.text = [textView.text substringWithRange:NSMakeRange(0, [number integerValue])];
    }
}
@end
