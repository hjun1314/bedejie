//
//  HJFriendTrendVC.m
//  budejie
//
//  Created by hjun on 2017/10/26.
//  Copyright © 2017年 hjun. All rights reserved.
//

#import "HJFriendTrendVC.h"

@interface HJFriendTrendVC ()

@end

@implementation HJFriendTrendVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
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
