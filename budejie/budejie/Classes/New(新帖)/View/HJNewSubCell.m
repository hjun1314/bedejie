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



- (void)setModel:(HJNewModel *)model{
    _model = model;
    _nameLabel.text = model.theme_name;
    _numLabel.text = model.sub_number;
    
    [_iconView sd_setImageWithURL:[NSURL URLWithString:_model.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
