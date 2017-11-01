//
//  HJMeVC.m
//  budejie
//
//  Created by hjun on 2017/10/26.
//  Copyright © 2017年 hjun. All rights reserved.
//

#import "HJMeVC.h"
#import "HJSettingVC.h"
#import "HJMeCell.h"
#import "HJMeModel.h"
#import "HJWebVC.h"
static NSString * const ID = @"cell";
static NSInteger const cols = 4;
static CGFloat const margin = 1;
#define itemWH (XMGScreenW - (cols - 1) * margin) / cols

@interface HJMeVC ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic,strong)NSMutableArray *data;
@property (nonatomic,strong)UICollectionView *collectionView;

@end

@implementation HJMeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
    [self setfootView];
    [self loadData];
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 10;
    
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);

}

- (void)setupNav{
    
    UIBarButtonItem *lightDay = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"mine-setting-icon"] highlightImage:[UIImage imageNamed:@"mine-setting-icon"] target:self action:@selector(setting)];
    UIBarButtonItem *nightDay = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"mine-moon-icon"] selectImage:[UIImage imageNamed:@"mine-moon-icon-click"]target:self action:@selector(clickNightDay:)];
    
    self.navigationItem.rightBarButtonItems = @[lightDay,nightDay];
    
    self.navigationItem.title = @"我的";
    
}
- (void)clickNightDay:(UIButton *)button{
    button.selected = !button.selected;
}

- (void)loadData{
    // 2.拼接请求参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"square";
    parameters[@"c"] = @"topic";
   
    [[UPSHttpNetWorkTool sharedApi]GET:@"http://api.budejie.com/api/api_open.php" params:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *dictArr = responseObject[@"square_list"];
        _data = [HJMeModel mj_objectArrayWithKeyValuesArray:dictArr];
        [self reloadCollectionData];
        
        NSInteger count = self.data.count;
        NSInteger rows = (count - 1) / cols + 1;
        self.collectionView.xmg_height = rows * itemWH;

        self.tableView.tableFooterView = self.collectionView;

        [self.collectionView reloadData];

    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}

- (void)reloadCollectionData{
    
    NSInteger count = self.data.count;
    NSInteger exter = count % cols;
    if (exter) {
        exter = cols - exter;
        for (int i = 0; i<exter; i++) {
            
            HJMeModel *model = [[HJMeModel alloc]init];
            [self.data addObject:model];
        }
    }

}

- (void)setfootView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    // 设置cell尺寸
    NSInteger cols = 4;
    CGFloat margin = 1;
    layout.itemSize = CGSizeMake(itemWH, itemWH);
    layout.minimumInteritemSpacing = margin;
    layout.minimumLineSpacing = margin;
    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, 0, 300) collectionViewLayout:layout];
    _collectionView = collectionView;

     collectionView.backgroundColor = self.tableView.backgroundColor;
    self.tableView.tableFooterView = collectionView;
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.scrollEnabled = NO;

    ///注册cell
    [collectionView registerNib:[UINib nibWithNibName:@"HJMeCell" bundle:nil] forCellWithReuseIdentifier:ID];
}
#pragma mark - UICollectionViewDataSource &Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 从缓存池取
    HJMeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.model = self.data[indexPath.row];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    HJMeModel *model = self.data[indexPath.row];
    if (![model.url containsString:@"http"]) {
        return;
    }
    HJWebVC *webVC = [[HJWebVC alloc]init];
    webVC.url = [NSURL URLWithString:model.url];
    
    [self.navigationController pushViewController:webVC animated:YES];
    
}
    ///设置
- (void)setting{
    HJSettingVC *setting = [[HJSettingVC alloc]init];
    setting.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:setting animated:YES];
}

    
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


@end
