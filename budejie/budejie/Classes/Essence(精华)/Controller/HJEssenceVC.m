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
    [self addChildVCIntoScrollView:0];
}

#pragma mark- 初始化
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

- (void)setupScrollView{
   self.automaticallyAdjustsScrollViewInsets = NO;

    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.backgroundColor = [UIColor purpleColor];
    scrollView.frame = self.view.bounds;
    scrollView.delegate = self;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.scrollsToTop = NO;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;

    NSUInteger count = self.childViewControllers.count;
    CGFloat scrollViewW = scrollView.xmg_width;
//    CGFloat scrollViewH = scrollView.xmg_height;
//    for (int i = 0; i < count;
//         i++) {
//        UIView *childView = self.childViewControllers[i].view;
//        childView.frame = CGRectMake(i * scrollViewW, 0, scrollViewW, scrollViewH);
//        [scrollView addSubview:childView];
//    }
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
#pragma mark- 监听
- (void)game{
    HJLog(@"点击了左边");
}

- (void)titleButtonClick:(HJEssenseBtn *)titleButton{
    ///重复点击btn按钮
    if (self.essenseBtn == titleButton) {
        [[NSNotificationCenter defaultCenter]postNotificationName:didTitleBtn object:nil];
        
    }
    
    ///切换按钮
    self.essenseBtn.selected = NO;
    titleButton.selected = YES;
    self.essenseBtn = titleButton;
    
    NSUInteger index = titleButton.tag;
    [UIView animateWithDuration:0.3 animations:^{
         ///处理下划线
        self.underLine.xmg_width = titleButton.titleLabel.xmg_width + 10;
        self.underLine.xmg_centerX = titleButton.xmg_centerX;
        
        ///添加scrollView
        CGFloat offsetX = self.scrollView.xmg_width *index;
        
        self.scrollView.contentOffset = CGPointMake(offsetX, self.scrollView.contentOffset.y);
    } completion:^(BOOL finished) {
        [self addChildVCIntoScrollView:index];
    }];
    
//    // 设置index位置对应的tableView.scrollsToTop = YES， 其他都设置为NO
//    for (NSUInteger i = 0; i < self.childViewControllers.count; i++) {
//        UIViewController *childVc = self.childViewControllers[i];
//        // 如果view还没有被创建，就不用去处理
//        if (!childVc.isViewLoaded) continue;
//        
//        UIScrollView *scrollView = (UIScrollView *)childVc.view;
//        if (![scrollView isKindOfClass:[UIScrollView class]]) continue;
//        
//        //        if (i == index) { // 是标题按钮对应的子控制器
//        //            scrollView.scrollsToTop = YES;
//        //        } else {
//        //            scrollView.scrollsToTop = NO;
//        //        }
//        scrollView.scrollsToTop = (i == index);
//    }
//
}
#pragma mark- scrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSUInteger index = scrollView.contentOffset.x / scrollView.xmg_width;
    HJEssenseBtn *titleBtn = self.titileView.subviews[index];
    [self titleButtonClick:titleBtn];
}

#pragma mark-  添加子控制器的View到scrollView

- (void)addChildVCIntoScrollView:(NSUInteger)index{
    
    UIViewController *childVc = self.childViewControllers[index];
    
    // 如果view已经被加载过，就直接返回
    if (childVc.isViewLoaded) return;
    
    // 取出index位置对应的子控制器view
    UIView *childVcView = childVc.view;
    
    // 设置子控制器view的frame
    CGFloat scrollViewW = self.scrollView.xmg_width;
    childVcView.frame = CGRectMake(index * scrollViewW, 0, scrollViewW, self.scrollView.xmg_height);
    // 添加子控制器的view到scrollView中
    [self.scrollView addSubview:childVcView];
//    CGFloat scrollViewW = self.scrollView.xmg_width;
//    
//    NSUInteger index = self.scrollView.contentOffset.x / scrollViewW;
//    
//    
//       UIView *childView = self.childViewControllers[index].view;
//   
//
//    
//    childView.frame = self.scrollView.bounds;
//    
//    
//    [self.scrollView addSubview:childView];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
