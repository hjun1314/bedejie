//
//  HJFriendTrendVC.m
//  budejie
//
//  Created by hjun on 2017/10/26.
//  Copyright © 2017年 hjun. All rights reserved.
//

#import "HJFriendTrendVC.h"
#import "HJLoginVC.h"
@interface HJFriendTrendVC ()

@end

@implementation HJFriendTrendVC
- (IBAction)clickLoginBtn:(UIButton *)sender {
    HJLoginVC *login = [[HJLoginVC alloc]init];
    [self.navigationController presentViewController:login animated:YES completion:nil];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
}
- (void)setupNav{
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"friendsRecommentIcon"] highlightImage:[UIImage imageNamed:@"friendsRecommentIcon-click"]  target:self action:@selector(clickFriend)];
    self.navigationItem.title = @"我的关注";
    
}
- (void)clickFriend{
    HJLog(@"点击了我的关注");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
