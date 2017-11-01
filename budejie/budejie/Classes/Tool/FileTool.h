//
//  FileTool.h
//  budejie
//
//  Created by hjun on 2017/11/1.
//  Copyright © 2017年 hjun. All rights reserved.
//
///用来专门处理某件事情,网络处理,缓存处理
#import <Foundation/Foundation.h>

@interface FileTool : NSObject
/**
 *  获取文件夹尺寸
 *
 *  @param directoryPath 文件夹路径
 *
 */
+ (void)getFileSize:(NSString *)directoryPath completion:(void(^)(NSInteger))completion;


/**
 *  删除文件夹所有文件
 *
 *  @param directoryPath 文件夹路径
 */
+ (void)removeDirectoryPath:(NSString *)directoryPath;


@end
