//
//  HJRegisterLoginView.m
//  budejie
//
//  Created by hjun on 2017/10/30.
//  Copyright © 2017年 hjun. All rights reserved.
//

#import "HJRegisterLoginView.h"
@interface HJRegisterLoginView()
@property (weak, nonatomic) IBOutlet UIButton *registerLoginBtn;

@end
@implementation HJRegisterLoginView

+ (instancetype)addLoginView{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]firstObject];
}
+ (instancetype)addRegisterView{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}

- (void)awakeFromNib{
    [super awakeFromNib];
    UIImage *image = _registerLoginBtn.currentBackgroundImage;
    
    image = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
    
    [_registerLoginBtn setBackgroundImage:image forState:UIControlStateNormal];
}

@end
