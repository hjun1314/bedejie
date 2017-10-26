//
//  HJTabVC.m
//  budejie
//
//  Created by hjun on 2017/10/26.
//  Copyright © 2017年 hjun. All rights reserved.
//

#import "HJTabVC.h"
#import "HJMeVC.h"
#import "HJNewVC.h"
#import "HJEssenceVC.h"
#import "HJPublishVC.h"
#import "HJFriendTrendVC.h"
#import "UIImage+Image.h"

@interface HJTabVC ()

@end

@implementation HJTabVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupAllChildVC];
    [self setupAllTitleButton];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupAllChildVC{
    HJEssenceVC *essence = [[HJEssenceVC alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:essence];
    [self addChildViewController:nav];
    
    HJNewVC *new = [[HJNewVC alloc]init];
    UINavigationController *nav1 = [[UINavigationController alloc]initWithRootViewController:new];
    [self addChildViewController:nav1];
    
    HJPublishVC *publish = [[HJPublishVC alloc]init];
    UINavigationController *nav2 = [[UINavigationController alloc]initWithRootViewController:publish];
    [self addChildViewController:nav2];
    
    HJFriendTrendVC *friendVc = [[HJFriendTrendVC alloc]init];
    UINavigationController *nav3 = [[UINavigationController alloc]initWithRootViewController:friendVc]
    ;
    [self addChildViewController:nav3];
    
    HJMeVC *me = [[HJMeVC alloc]init];
    UINavigationController *nav4 = [[UINavigationController alloc]initWithRootViewController:me];
    [self addChildViewController:nav4];

}

// 设置tabBar上所有按钮内容
- (void)setupAllTitleButton
{
    // 0:nav
    UINavigationController *nav = self.childViewControllers[0];
    nav.tabBarItem.title = @"精华";
    nav.tabBarItem.image = [UIImage imageNamed:@"tabBar_essence_icon"];
    nav.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"tabBar_essence_click_icon"];
    
    // 1:新帖
    UINavigationController *nav1 = self.childViewControllers[1];
    nav1.tabBarItem.title = @"新帖";
    nav1.tabBarItem.image = [UIImage imageNamed:@"tabBar_new_icon"];
    nav1.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"tabBar_new_click_icon"];
    
    // 2:发布
    HJPublishVC *publishVc = self.childViewControllers[2];
    publishVc.tabBarItem.image = [UIImage imageNamed:@"tabBar_publish_icon"];
    publishVc.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"tabBar_publish_click_icon"];
    
    // 3.关注
    UINavigationController *nav3 = self.childViewControllers[3];
    nav3.tabBarItem.title = @"关注";
    nav3.tabBarItem.image = [UIImage imageNamed:@"tabBar_friendTrends_icon"];
    nav3.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"tabBar_friendTrends_click_icon"];
    
    // 4.我
    UINavigationController *nav4 = self.childViewControllers[4];
    nav4.tabBarItem.title = @"我";
    nav4.tabBarItem.image = [UIImage imageNamed:@"tabBar_me_icon"];
    nav4.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"tabBar_me_click_icon"];
    
}


@end
