//
//  UIBarButtonItem+item.m
//  budejie
//
//  Created by hjun on 2017/10/27.
//  Copyright © 2017年 hjun. All rights reserved.
//

#import "UIBarButtonItem+item.h"

@implementation UIBarButtonItem (item)

+ (UIBarButtonItem *)itemWithImage:(UIImage *)image highlightImage:(UIImage *)highImage target:(id)target action:(SEL)action{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:highImage forState:UIControlStateHighlighted];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn sizeToFit];
    UIView *containView = [[UIView alloc]initWithFrame:btn.bounds];
    [containView addSubview:btn];
    
    return [[UIBarButtonItem alloc]initWithCustomView:containView];
    
}
    
+ (UIBarButtonItem *)itemWithImage:(UIImage *)image selectImage:(UIImage *)selectImage target:(id)target action:(SEL)action{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:selectImage forState:UIControlStateSelected];
    [btn sizeToFit];

    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIView *containView = [[UIView alloc]initWithFrame:btn.bounds];
    [containView addSubview:btn];
    
    return [[UIBarButtonItem alloc]initWithCustomView:containView];

}
    

@end
