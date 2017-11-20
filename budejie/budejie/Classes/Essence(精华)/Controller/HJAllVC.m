//
//  HJAllVC.m
//  budejie
//
//  Created by hjun on 2017/11/1.
//  Copyright © 2017年 hjun. All rights reserved.
//

#import "HJAllVC.h"
#import "HJEssenceModel.h"
#import "HJEssenceCell.h"
@interface HJAllVC (){
    CGFloat _contentOffsetY;//上次的offset
    CGFloat _contentOffsetSpeed;//与上次的滚差，用于判断速度
    NSString * _np;
}
@property (nonatomic,strong)NSMutableArray *topic;

/** 当前最后一条帖子数据的描述信息，专门用来加载下一页数据 */
@property (nonatomic, copy) NSString *maxtime;
@end

@implementation HJAllVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RandomColor;
    //self.tableView.contentInset = UIEdgeInsetsMake(NavMaxY + TitlesViewH , 0, TabBarH, 0);
    ///加c
    self.tableView.contentInset = UIEdgeInsetsMake(TitlesViewH , 0, TabBarH, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    self.tableView.rowHeight = 200;
    
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([HJEssenceCell class]) bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"HJTopicCellId"];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didClickTitleBtn) name:didTitleBtn object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didClickTabbarBtn) name:didTabbarBtn object:nil];
   
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshUP)];
    [self.tableView.mj_header beginRefreshing];
   //self.tableView.mj_header.automaticallyChangeAlpha = YES;
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshDown)];
//    [self.tableView.mj_footer beginRefreshing];
}

#pragma mark- 刷新
///下拉刷新
- (void)refreshUP{
    [self.tableView.mj_footer endRefreshing];
    [self loadEssenceDataUP];

}

///上拉加载
- (void)refreshDown{
    [self loadEssenceDataDown];
}

#pragma mark- 点击titleBtn 和 tabbar
- (void)didClickTitleBtn{
    HJLog(@"刷新");
    //    if (重复点击的不是精华按钮) return;

    if (self.view.window == nil) {
        return;
    }//    if (显示在正中间的不是AllViewController) return;

    if (self.tableView.scrollsToTop == NO) {
        return;
    }
    [self refreshUP];
}
- (void)didClickTabbarBtn{
    //    if (重复点击的不是精华按钮) return;
         if (self.view.window == nil) {
        return;
    }//    if (显示在正中间的不是AllViewController) return;
    
    if (self.tableView.scrollsToTop == NO) {
        return;
    }

}
- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
#pragma mark- 加载数据
- (void)loadEssenceDataUP{
    
    // 2.拼接参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @"1"; // 这里发送@1也是可行的
    [[UPSHttpNetWorkTool sharedApi]GET:BaseURL params:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        self.topic = [HJEssenceModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
    
}
- (void)loadEssenceDataDown{
    
    // 2.拼接参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @"31";
    parameters[@"maxtime"] = self.maxtime;
    
    [[UPSHttpNetWorkTool sharedApi]GET:BaseURL params:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        NSArray *moreTopices = [HJEssenceModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        ///累加到旧数组的后面
        [self.topic addObjectsFromArray:moreTopices];
        
        [self.tableView reloadData];
        
        [self.tableView.mj_footer beginRefreshing];
        
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        if (error.code != NSURLErrorCancelled) { // 并非是取消任务导致的error，其他网络问题导致的error
            [SVProgressHUD showErrorWithStatus:@"网络繁忙，请稍后再试！"];
        }
        [self.tableView.mj_footer endRefreshing];

    }];
    
}
#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.topic.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HJEssenceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HJTopicCellId"];
    cell.model = self.topic[indexPath.row];
   
    
    return cell;

    
    
    return cell;
}
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
//{
//    CGFloat offsetY = - (self.tableView.contentInset.top + 100);
//    if (self.tableView.contentOffset.y <= offsetY) { // header已经完全出现
//        [self.tableView.mj_header beginRefreshing];
//    }
//}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{//只会触发上拉加载更多
    if (scrollView.contentOffset.y > _contentOffsetY){//上滚
        //TGLog(@"up %f",scrollView.contentOffset.y);
        if (scrollView.contentOffset.y > 0){
            //隐藏，放入nav
            //通知形式
            //TGLog(@"我要隐藏了～～～～～～～～～～～～ %f",scrollView.contentOffset.y);
            if((scrollView.contentOffset.y - _contentOffsetY) > _contentOffsetSpeed && _contentOffsetSpeed>20){//速度超过20隐藏
                //TGLog(@"~~~~~~~~~~~~~~~~~~~~~%f %f",scrollView.contentOffset.y - _contentOffsetY,_contentOffsetSpeed);//滚速递减则不再发通知
               // [[NSNotificationCenter defaultCenter] postNotificationName:NavigationBarHiddenNotification object:nil userInfo:nil];
            }
            _contentOffsetSpeed = scrollView.contentOffset.y - _contentOffsetY;
        }
    }else{
        //显示，回归原位
        //通知形式
        //TGLog(@"dwon %f",scrollView.contentOffset.y);
        if (scrollView.contentOffset.y > 0){
            //TGLog(@"我要显示了^^^^^^^^^^^^^^^^^^^^ %f",scrollView.contentOffset.y);
            if (_contentOffsetY - scrollView.contentOffset.y > _contentOffsetSpeed && _contentOffsetSpeed>20){//速度超过20显示
                //TGLog(@"^^^^^^^^^^^^^^^^^^^^^^^%f %f",_contentOffsetY - scrollView.contentOffset.y,_contentOffsetSpeed);
                //[[NSNotificationCenter defaultCenter] postNotificationName:NavigationBarShowNotification object:nil userInfo:nil];
            }
            _contentOffsetSpeed = _contentOffsetY - scrollView.contentOffset.y;
        }else if (fabs(scrollView.contentOffset.y) > NavMaxY && fabs(scrollView.contentOffset.y) < NavMaxY+35){
            //TGLog(@"我要显示了^^^^^^^^^^^^^^^^^^^^ %f",scrollView.contentOffset.y);
           // [[NSNotificationCenter defaultCenter] postNotificationName:NavigationBarShowNotification object:nil userInfo:nil];
        }
    }
    _contentOffsetY = scrollView.contentOffset.y;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
