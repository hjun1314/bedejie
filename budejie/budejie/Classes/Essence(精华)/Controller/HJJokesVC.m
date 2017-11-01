//
//  HJJokesVC.m
//  budejie
//
//  Created by hjun on 2017/11/1.
//  Copyright © 2017年 hjun. All rights reserved.
//

#import "HJJokesVC.h"

@interface HJJokesVC ()

@end

@implementation HJJokesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = RandomColor;
    self.tableView.contentInset = UIEdgeInsetsMake(NavMaxY + TitlesViewH, 0, TabBarH, 0);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.backgroundColor = [UIColor clearColor];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@-%zd", self.class, indexPath.row];
    return cell;
    
    
    
    return cell;
}


@end
