//
//  HJNewVC.m
//  budejie
//
//  Created by hjun on 2017/10/26.
//  Copyright © 2017年 hjun. All rights reserved.
//

#import "HJNewVC.h"

@interface HJNewVC ()

@end

@implementation HJNewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    [self setupNav];
}
- (void)setupNav{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"MainTagSubIcon"] highlightImage:[UIImage imageNamed:@"MainTagSubIconClick"]  target:self action:@selector(clickNew)];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
}
#pragma mark- 点击订阅
- (void)clickNew{
    HJLog(@"点击了订阅");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
