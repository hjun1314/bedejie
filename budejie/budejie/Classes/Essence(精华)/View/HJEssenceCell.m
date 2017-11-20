//
//  HJEssenceCell.m
//  budejie
//
//  Created by hjun on 2017/11/17.
//  Copyright © 2017年 hjun. All rights reserved.
//

#import "HJEssenceCell.h"
#import "HJEssenceModel.h"
@interface HJEssenceCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIButton *moreBtn;
@property (weak, nonatomic) IBOutlet UIButton *dingBtn;
@property (weak, nonatomic) IBOutlet UIButton *caiBtn;
@property (weak, nonatomic) IBOutlet UIButton *sharedBtn;
@property (weak, nonatomic) IBOutlet UIButton *commentsBtn;



@end
@implementation HJEssenceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
}

- (void)setModel:(HJEssenceModel *)model{
    _model = model;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:model.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.nameLabel.text = model.name;
    self.timeLabel.text = model.passtime;
    self.contentLabel.text = model.text;
    
    [self setupButtonTitle:self.dingBtn number:model.ding placeholder:@"顶"];
    [self setupButtonTitle:self.caiBtn number:model.cai placeholder:@"踩"];
    [self setupButtonTitle:self.sharedBtn number:model.repost placeholder:@"分享"];
    [self setupButtonTitle:self.commentsBtn number:model.comment placeholder:@"评论"];
    
    
}

- (void)setupButtonTitle:(UIButton *)button number:(NSInteger)number placeholder:(NSString *)placeholder{
    
    if (number >= 10000) {
        
        [button setTitle:[NSString stringWithFormat:@"%.1f万",number / 10000.0] forState:UIControlStateNormal];
        
    }else if (number > 0){
        [button setTitle:[NSString stringWithFormat:@"%zd",number] forState:UIControlStateNormal];
        
    }else{
        [button setTitle:placeholder forState:UIControlStateNormal];
    }
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
