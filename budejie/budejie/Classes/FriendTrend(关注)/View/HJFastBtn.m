//
//  HJFastBtn.m
//  budejie
//
//  Created by hjun on 2017/10/30.
//  Copyright © 2017年 hjun. All rights reserved.
//

#import "HJFastBtn.h"

@implementation HJFastBtn

- (void)layoutSubviews{
    [super layoutSubviews];
    // 设置图片位置
    self.imageView.xmg_y = 0;
    self.imageView.xmg_centerX = self.xmg_width * 0.5;
    
    // 设置标题位置
    self.titleLabel.xmg_y = self.xmg_height - self.titleLabel.xmg_height;
    
    // 计算文字宽度 , 设置label的宽度
    [self.titleLabel sizeToFit];
    
    self.titleLabel.xmg_centerX = self.xmg_width * 0.5;
}
@end
