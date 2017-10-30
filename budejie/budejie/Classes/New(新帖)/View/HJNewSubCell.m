//
//  HJNewSubCell.m
//  budejie
//
//  Created by hjun on 2017/10/30.
//  Copyright © 2017年 hjun. All rights reserved.
//

#import "HJNewSubCell.h"
#import "HJNewModel.h"
@interface HJNewSubCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;


@end
@implementation HJNewSubCell

- (void)setFrame:(CGRect)frame{
    frame.size.height -= 1;
    [super setFrame:frame];
}

- (void)setModel:(HJNewModel *)model{
    _model = model;
    _nameLabel.text = model.theme_name;
    NSString *numStr = [NSString stringWithFormat:@"%@人订阅",_model.sub_number];
    NSInteger num = model.sub_number.integerValue;
    if (num > 10000) {
        CGFloat numF = num / 10000.0;
         numStr = [NSString stringWithFormat:@"%.1f万人订阅",numF];
        numStr = [numStr stringByReplacingOccurrencesOfString:@".0" withString:@""];
    }
    
    _numLabel.text = numStr;
    
    [_iconView sd_setImageWithURL:[NSURL URLWithString:_model.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"] options:SDWebImageCacheMemoryOnly completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
        UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
        
        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
        ///裁剪
        [path addClip];
        ///画图片
        [image drawAtPoint:CGPointZero];
        
        //取出图片
        image = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        _iconView.image = image;
        
    }];
    
}

// 从xib加载就会调用一次
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    // 设置头像圆角,iOS9苹果修复
    //_iconView.layer.cornerRadius = 30;
    //_iconView.layer.masksToBounds = YES;
    
//    self.layoutMargins = UIEdgeInsetsZero;

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
