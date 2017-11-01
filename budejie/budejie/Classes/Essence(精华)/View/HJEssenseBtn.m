//
//  HJEssenseBtn.m
//  budejie
//
//  Created by hjun on 2017/11/1.
//  Copyright © 2017年 hjun. All rights reserved.
//

#import "HJEssenseBtn.h"

@implementation HJEssenseBtn
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.font = [UIFont systemFontOfSize:16];
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted{
    
}
@end
