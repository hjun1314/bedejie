//
//  HJEssenceVC.m
//  budejie
//
//  Created by hjun on 2017/10/26.
//  Copyright © 2017年 hjun. All rights reserved.
//

#import "HJEssenceVC.h"

@interface HJEssenceVC ()

@end

@implementation HJEssenceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    [self setNav];
}

- (void)setNav{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"nav_item_game_icon"]highlightImage:[UIImage imageNamed:@"nav_item_game_click_icon"] target:self action:@selector(game)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"navigationButtonRandom"] highlightImage:[UIImage imageNamed:@"navigationButtonRandomClick"] target:nil action:nil];
    // titleView
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
}
- (void)game{
    HJLog(@"点击了左边");
}
    
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
