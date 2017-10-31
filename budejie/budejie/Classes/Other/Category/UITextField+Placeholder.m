//
//  UITextField+Placeholder.m
//  budejie
//
//  Created by hjun on 2017/10/31.
//  Copyright © 2017年 hjun. All rights reserved.
//

#import "UITextField+Placeholder.h"
#import <objc/message.h>
@implementation UITextField (Placeholder)

+ (void)load{
    
    // setPlaceholder
    Method setPlaceholderMethod = class_getInstanceMethod(self, @selector(setPlaceholder:));
    Method setTextFieldPlaceholderMethod = class_getInstanceMethod(self, @selector(TextFieldPlaceholder:));
    
    method_exchangeImplementations(setPlaceholderMethod, setTextFieldPlaceholderMethod);

}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    
    // 给成员属性赋值 runtime给系统的类添加成员属性
    // 添加成员属性
    objc_setAssociatedObject(self, @"placeholderColor", placeholderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    // 获取占位文字label控件
    UILabel *placeholderLabel = [self valueForKey:@"placeholderLabel"];
    
    // 设置占位文字颜色
    placeholderLabel.textColor = placeholderColor;
}

- (void)TextFieldPlaceholder:(NSString *)placeholder{
    [self TextFieldPlaceholder:placeholder];
    self.placeholderColor = self.placeholderColor;
    
    
}
- (UIColor *)placeholderColor
{
    return objc_getAssociatedObject(self, @"placeholderColor");
}



@end
