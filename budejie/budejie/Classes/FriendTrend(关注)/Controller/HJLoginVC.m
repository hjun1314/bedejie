//
//  HJLoginVC.m
//  budejie
//
//  Created by hjun on 2017/10/30.
//  Copyright © 2017年 hjun. All rights reserved.
//

#import "HJLoginVC.h"
#import "HJRegisterLoginView.h"
#import "HJFastLoginView.h"
@interface HJLoginVC ()
@property (weak, nonatomic) IBOutlet UIView *middleView;
@property (nonatomic,weak) IBOutlet NSLayoutConstraint *leon;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@end

@implementation HJLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    HJRegisterLoginView *registerView = [HJRegisterLoginView addRegisterView];
    [self.middleView addSubview:registerView];
    
    HJRegisterLoginView *loginView = [HJRegisterLoginView addLoginView];
    [self.middleView addSubview:loginView];
    
     HJFastLoginView *fastView = [HJFastLoginView addFastLoginView];
    [self.bottomView addSubview:fastView];
    
}
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    HJRegisterLoginView *loginView = self.middleView.subviews[0];
    loginView.frame = CGRectMake(0, 0, self.middleView.xmg_width * 0.5, self.middleView.xmg_height);
    
    HJRegisterLoginView *registerView = self.middleView.subviews[1];
    registerView.frame = CGRectMake( self.middleView.xmg_width * 0.5, 0,self.middleView.xmg_width * 0.5, self.middleView.xmg_height);
    
    HJFastLoginView *fastView = self.bottomView.subviews.firstObject;
    fastView.frame = self.bottomView.bounds;
    
}

- (IBAction)dissmissBtn:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

}
- (IBAction)registerBtn:(UIButton *)sender {
    sender.selected = !sender.selected;
    // 平移中间view
    _leon.constant = _leon.constant == 0? -self.middleView.xmg_width * 0.5:0;
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];
    

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
