//
//  HJMeCell.m
//  budejie
//
//  Created by hjun on 2017/10/31.
//  Copyright © 2017年 hjun. All rights reserved.
//

#import "HJMeCell.h"
#import "HJMeModel.h"
@interface HJMeCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end
@implementation HJMeCell

- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setModel:(HJMeModel *)model{
    _model = model;
    [_iconView sd_setImageWithURL:[NSURL URLWithString:model.icon]];
    
    _nameLabel.text = model.name;
}
@end
