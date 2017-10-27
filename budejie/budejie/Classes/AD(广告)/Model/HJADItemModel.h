//
//  HJADItemModel.h
//  budejie
//
//  Created by hjun on 2017/10/27.
//  Copyright © 2017年 hjun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HJADItemModel : NSObject

/** 广告地址 */
@property (nonatomic, strong) NSString *w_picurl;
/** 点击广告跳转的界面 */
@property (nonatomic, strong) NSString *ori_curl;
    
@property (nonatomic, assign) CGFloat w;
    
@property (nonatomic, assign) CGFloat h;
    
@end
