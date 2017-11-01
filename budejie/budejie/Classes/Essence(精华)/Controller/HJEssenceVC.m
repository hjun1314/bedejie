//
//  HJEssenceVC.m
//  budejie
//
//  Created by hjun on 2017/10/26.
//  Copyright © 2017年 hjun. All rights reserved.
//

#import "HJEssenceVC.h"
#import "HJEssenseBtn.h"
#import "HJAllVC.h"
#import "HJVideoVC.h"
#import "HJVoiceVC.h"
#import "HJPictureVC.h"
#import "HJJokesVC.h"
@interface HJEssenceVC ()<UIScrollViewDelegate>
@property (nonatomic,strong)UIView *titileView;
@property (nonatomic,strong)HJEssenseBtn *essenseBtn;
@property (nonatomic,strong)UIView *underLine;
@property (nonatomic,strong)UIScrollView *scrollView;

@end

@implementation HJEssenceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.view.backgroundColor = [UIColor orangeColor];
    [self addChildVC];
    [self setNav];
    [self setupScrollView];
    [self setupTitleView];
}
- (void)addChildVC{
    [self addChildViewController:[[HJAllVC alloc]init]];
    [self addChildViewController:[[HJVideoVC alloc]init]];
    [self addChildViewController:[[HJVoiceVC alloc]init]];
    [self addChildViewController:[[HJPictureVC alloc]init]];
    [self addChildViewController:[[HJJokesVC alloc]init]];
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

- (void)setupScrollView{
    self.automaticallyAdjustsScrollViewInsets = NO;

    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.backgroundColor = [UIColor purpleColor];
    scrollView.frame = self.view.bounds;
    scrollView.delegate = self;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    self.scrollView = scrollView;
    [self.view addSubview:scrollView];
    
    NSUInteger count = self.childViewControllers.count;
    CGFloat scrollViewW = scrollView.xmg_width;
    CGFloat scrollViewH = scrollView.xmg_height;
    for (int i = 0; i < count;
         i++) {
        UIView *childView = self.childViewControllers[i].view;
        childView.frame = CGRectMake(i * scrollViewW, 0, scrollViewW, scrollViewH);
        [scrollView addSubview:childView];
    }
    scrollView.contentSize = CGSizeMake(count * scrollViewW, 0);
    
}

- (void)setupTitleView{
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, self.view.xmg_width, 35)];
    titleView.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5];
    self.titileView = titleView;
    [self.view addSubview:titleView];
    [self setupTitleButtons];
    [self setupTitleViewUnderLine];
}

- (void)setupTitleButtons
{
    // 文字
    NSArray *titles = @[@"全部", @"视频", @"声音", @"图片", @"段子"];
    NSUInteger count = titles.count;
    
    // 标题按钮的尺寸
    CGFloat titleButtonW = self.titileView.xmg_width / count;
    CGFloat titleButtonH = self.titileView.xmg_height;
    
    // 创建5个标题按钮
    for (NSUInteger i = 0; i < count; i++) {
        HJEssenseBtn *titleButton = [[HJEssenseBtn alloc] init];
        titleButton.tag = i;
        [titleButton addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.titileView addSubview:titleButton];
        // frame
        titleButton.frame = CGRectMake(i * titleButtonW, 0, titleButtonW, titleButtonH);
        // 文字
        [titleButton setTitle:titles[i] forState:UIControlStateNormal];
       
    }
}

- (void)setupTitleViewUnderLine{
    
    HJEssenseBtn *firstBtn = self.titileView.subviews.firstObject;
    
    UIView *underLine = [[UIView alloc]init];
    underLine.xmg_height = 2;
    underLine.xmg_y = self.titileView.xmg_height - underLine.xmg_height;
    underLine.backgroundColor = [firstBtn titleColorForState:UIControlStateSelected];
    [self.titileView addSubview:underLine];
    
    self.underLine = underLine;
    
    ///设置一进去被选中
    firstBtn.selected = YES;
    self.essenseBtn = firstBtn;
    
    [firstBtn.titleLabel sizeToFit];
    
    self.underLine.xmg_width = firstBtn.titleLabel.xmg_width + 10;
    self.underLine.xmg_centerX = firstBtn.xmg_centerX;
    
    
}

- (void)titleButtonClick:(HJEssenseBtn *)titleButton{
    
    self.essenseBtn.selected = NO;
    titleButton.selected = YES;
    self.essenseBtn = titleButton;
    
    [UIView animateWithDuration:0.2 animations:^{
       
        self.underLine.xmg_width = titleButton.titleLabel.xmg_width + 10;
        self.underLine.xmg_centerX = titleButton.xmg_centerX;
        
        CGFloat offsetX = self.scrollView.xmg_width *titleButton.tag;
        
        self.scrollView.contentOffset = CGPointMake(offsetX, self.scrollView.contentOffset.y);
        
    }];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSUInteger index = scrollView.contentOffset.x / scrollView.xmg_width;
    HJEssenseBtn *titleBtn = self.titileView.subviews[index];
    [self titleButtonClick:titleBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
