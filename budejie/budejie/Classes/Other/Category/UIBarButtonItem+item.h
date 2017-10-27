//
//  UIBarButtonItem+item.h
//  budejie
//
//  Created by hjun on 2017/10/27.
//  Copyright © 2017年 hjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (item)
///快速创建uibarbuttonitem
+ (UIBarButtonItem *)itemWithImage:(UIImage *)image highlightImage:(UIImage *)highImage target:(id)target action:(SEL)action;
    
+ (UIBarButtonItem *)itemWithImage:(UIImage *)image selectImage:(UIImage *)selectImage target:(id)target action:(SEL)action;
    
    
@end
