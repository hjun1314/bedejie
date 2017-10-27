//
//  HJADVC.m
//  budejie
//
//  Created by hjun on 2017/10/27.
//  Copyright © 2017年 hjun. All rights reserved.
//

#import "HJADVC.h"

@interface HJADVC ()
    @property (weak, nonatomic) IBOutlet UIImageView *launchImageView;
    @property (weak, nonatomic) IBOutlet UIView *ADView;

@end

@implementation HJADVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupLaunchImage];
}

- (void)setupLaunchImage{
    
    if (iphone6P) { // 6p
        self.launchImageView.image = [UIImage imageNamed:@"LaunchImage-800-Portrait-736h@3x"];
    } else if (iphone6) { // 6
        self.launchImageView.image = [UIImage imageNamed:@"LaunchImage-800-667h"];
    } else if (iphone5) { // 5
        self.launchImageView.image = [UIImage imageNamed:@"LaunchImage-568h"];
        
    } else if (iphone4) { // 4
        
        self.launchImageView.image = [UIImage imageNamed:@"LaunchImage-700"];
    }
    

}
    
    
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
