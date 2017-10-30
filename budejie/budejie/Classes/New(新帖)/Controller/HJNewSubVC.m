//
//  HJNewSubVC.m
//  budejie
//
//  Created by hjun on 2017/10/30.
//  Copyright © 2017年 hjun. All rights reserved.
//

#import "HJNewSubVC.h"
#import "HJNewModel.h"
#import "HJNewSubCell.h"
static NSString * const ID = @"cell";

@interface HJNewSubVC ()

@property (nonatomic,strong)NSArray *subData;


@end

@implementation HJNewSubVC
//- (NSArray *)subData{
//    if (_subData == nil) {
//        _subData = [NSArray array];
//    }
//    return _subData;
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"HJNewSubCell" bundle:nil]forCellReuseIdentifier:ID];
}
- (void)loadData{
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"tag_recommend";
    parameters[@"action"] = @"sub";
    parameters[@"c"] = @"topic";
    
    [[UPSHttpNetWorkTool sharedApi]GET:@"http://api.budejie.com/api/api_open.php" params:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        // 字典数组转换模型数组
        _subData = [HJNewModel mj_objectArrayWithKeyValuesArray:responseObject];
        [self.tableView reloadData];
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.subData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HJNewSubCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    HJNewModel *model = self.subData[indexPath.row];
    cell.model = model;
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

@end
