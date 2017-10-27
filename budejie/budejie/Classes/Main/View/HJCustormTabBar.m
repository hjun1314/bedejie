//
//  HJCustormTabBar.m
//  budejie
//
//  Created by hjun on 2017/10/26.
//  Copyright © 2017年 hjun. All rights reserved.
//

#import "HJCustormTabBar.h"
@interface HJCustormTabBar()
@property (nonatomic,strong)UIButton *middleBtn;

@end
@implementation HJCustormTabBar

- (UIButton *)middleBtn{
    if (_middleBtn == nil) {
        _middleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_middleBtn setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [_middleBtn setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [_middleBtn sizeToFit];
        [self addSubview:_middleBtn];
    }
    return _middleBtn;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    // 跳转tabBarButton位置
    NSInteger count = self.items.count;
    CGFloat btnW = self.bounds.size.width / (count + 1);
    CGFloat btnH = self.bounds.size.height;
    CGFloat x = 0;
    int i = 0;
    // 私有类:打印出来有个类,但是敲出来没有,说明这个类是系统私有类
    // 遍历子控件 调整布局
    for (UIView *tabBarButton in self.subviews) {
        
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            if (i == 2) {
                i += 1;
            }
            
            x = i * btnW;
            
            tabBarButton.frame = CGRectMake(x, 0, btnW, btnH);
            
            i++;
        }
    }
    
    // 调整发布按钮位置
    self.middleBtn.center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
    

    
    
}
@end
