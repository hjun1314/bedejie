//
//  HJSettingVC.m
//  budejie
//
//  Created by hjun on 2017/10/27.
//  Copyright © 2017年 hjun. All rights reserved.
//

#import "HJSettingVC.h"
#define CachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

@interface HJSettingVC ()
@property (nonatomic, assign) NSInteger totalSize;

@end

@implementation HJSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"设置";
    
    [SVProgressHUD showWithStatus:@"正在计算缓存尺寸...."];
    
    // 获取文件夹尺寸
    // 文件夹非常小,如果我的文件非常大
    [FileTool getFileSize:CachePath completion:^(NSInteger totalSize) {
        
        _totalSize = totalSize;
        
        [self.tableView reloadData];
        
        [SVProgressHUD dismiss];
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
   static NSString *ID = @"CELL";
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    if (cell == nil) {
        cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    }
    
    cell.textLabel.text = [self sizeStr];

    
    return cell;
}
// 点击cell就会调用
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 清空缓存
    // 删除文件夹里面所有文件
    [FileTool removeDirectoryPath:CachePath];
    
    _totalSize = 0;
    
    [self.tableView reloadData];
}


// 获取缓存尺寸字符串
- (NSString *)sizeStr
{
    NSInteger totalSize = _totalSize;
    NSString *sizeStr = @"清除缓存";
    // MB KB B
    if (totalSize > 1000 * 1000) {
        // MB
        CGFloat sizeF = totalSize / 1000.0 / 1000.0;
        sizeStr = [NSString stringWithFormat:@"%@(%.1fMB)",sizeStr,sizeF];
    } else if (totalSize > 1000) {
        // KB
        CGFloat sizeF = totalSize / 1000.0;
        sizeStr = [NSString stringWithFormat:@"%@(%.1fKB)",sizeStr,sizeF];
    } else if (totalSize > 0) {
        // B
        sizeStr = [NSString stringWithFormat:@"%@(%.ldB)",sizeStr,totalSize];
    }
    
    return sizeStr;
}

@end
