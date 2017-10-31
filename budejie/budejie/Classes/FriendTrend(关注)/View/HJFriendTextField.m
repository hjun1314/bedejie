//
//  HJFriendTextField.m
//  budejie
//
//  Created by hjun on 2017/10/31.
//  Copyright © 2017年 hjun. All rights reserved.
//

#import "HJFriendTextField.h"
#import "UITextField+Placeholder.h"
@implementation HJFriendTextField

- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.tintColor = [UIColor whiteColor];
    // 监听文本框编辑: 1.代理 2.通知 3.target
    // 原则:不要自己成为自己代理
    // 开始编辑
    [self addTarget:self action:@selector(textBegin) forControlEvents:UIControlEventEditingDidBegin];
    
    // 结束编辑
    [self addTarget:self action:@selector(textEnd) forControlEvents:UIControlEventEditingDidEnd];
    
    self.placeholderColor = [UIColor redColor];
}
// 文本框开始编辑调用
- (void)textBegin
{
    self.placeholderColor = [UIColor whiteColor];
}


// 文本框结束编辑调用
- (void)textEnd
{
    self.placeholderColor = [UIColor redColor];
}


@end
