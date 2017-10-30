//
//  HJFastLoginView.m
//  budejie
//
//  Created by hjun on 2017/10/30.
//  Copyright © 2017年 hjun. All rights reserved.
//

#import "HJFastLoginView.h"

@implementation HJFastLoginView

+ (instancetype)addFastLoginView{
    
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]firstObject];
    
}

@end
