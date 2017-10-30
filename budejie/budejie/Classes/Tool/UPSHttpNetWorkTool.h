//
//  UPSHttpNetWorkTool.h
//  UPS
//
//  Created by hjun on 2017/8/21.
//  Copyright © 2017年 hjun. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 *  宏定义请求成功的block
 *
 *  @param response 请求成功返回的数据
 */
typedef void (^LHResponseSuccess)(NSURLSessionDataTask * task,id responseObject);

/**
 *  宏定义请求失败的block
 *
 *  @param error 报错信息
 */
typedef void (^LHResponseFail)(NSURLSessionDataTask * task, NSError * error);

/**
 *  上传或者下载的进度
 *
 *  @param progress 进度
 */
typedef void (^LHProgress)(NSProgress *progress);

@interface UPSHttpNetWorkTool : NSObject



//获得单例接口
+ (instancetype)sharedApi;
///// GET请求方法:path传URL地址  params传请求体
//- (void)GET:(NSString *)path params:(id)params complete:(void(^)(BOOL result,id responseObj))comlete;
///// POST请求方法:path传URL地址  params传请求体
//- (void)POST:(NSString *)path params:(id)params complete:(void(^)(BOOL result,id responseObj))comlete;

///测试短信接口
//- (void)POSTUrlString:(NSString *)stringUrl params:(NSDictionary *)params complete:(void(^)(NSDictionary *result,NSError *error))complete;




/**
 *  普通get方法请求网络数据
 *
 *  @param url     请求网址路径
 *  @param params  请求参数
 *  @param success 成功回调
 *  @param fail    失败回调
 */
-(void)GET:(NSString *)url
    params:(NSDictionary *)params success:(LHResponseSuccess)success
      fail:(LHResponseFail)fail;
/**
 *  含有baseURL的get方法
 *
 *  @param url     请求网址路径
 *  @param baseUrl 请求网址根路径
 *  @param params  请求参数
 *  @param success 成功回调
 *  @param fail    失败回调
 */
-(void)GET:(NSString *)url baseURL:(NSString *)baseUrl
    params:(NSDictionary *)params success:(LHResponseSuccess)success fail:(LHResponseFail)fail;

/**
 *  普通post方法请求网络数据
 *
 *  @param url     请求网址路径
 *  @param params  请求参数
 *  @param success 成功回调
 *  @param fail    失败回调
 */
-(void)POST:(NSString *)url
     params:(NSDictionary *)params
    success:(LHResponseSuccess)success
       fail:(LHResponseFail)fail;

/**
 *  含有baseURL的post方法
 *
 *  @param url     请求网址路径
 *  @param baseUrl 请求网址根路径
 *  @param params  请求参数
 *  @param success 成功回调
 *  @param fail    失败回调
 */
-(void)POST:(NSString *)url
    baseURL:(NSString *)baseUrl
     params:(NSDictionary *)params
    success:(LHResponseSuccess)success
       fail:(LHResponseFail)fail;

/**
 *  普通路径上传文件
 *
 *  @param url      请求网址路径
 *  @param params   请求参数
 *  @param filedata 文件
 *  @param name     指定参数名
 *  @param filename 文件名（要有后缀名）
 *  @param mimeType 文件类型
 *  @param progress 上传进度
 *  @param success  成功回调
 *  @param fail     失败回调
 */
-(void)uploadWithURL:(NSString *)url
              params:(NSDictionary *)params
            fileData:(NSData *)filedata
                name:(NSString *)name
            fileName:(NSString *)filename
            mimeType:(NSString *) mimeType
            progress:(LHProgress)progress
             success:(LHResponseSuccess)success
                fail:(LHResponseFail)fail;
/**
 *  含有跟路径的上传文件
 *
 *  @param url      请求网址路径
 *  @param baseurl  请求网址根路径
 *  @param params   请求参数
 *  @param filedata 文件
 *  @param name     指定参数名
 *  @param filename 文件名（要有后缀名）
 *  @param mimeType 文件类型
 *  @param progress 上传进度
 *  @param success  成功回调
 *  @param fail     失败回调
 */
-(void)uploadWithURL:(NSString *)url
             baseURL:(NSString *)baseurl
              params:(NSDictionary *)params
            fileData:(NSData *)filedata
                name:(NSString *)name
            fileName:(NSString *)filename
            mimeType:(NSString *) mimeType
            progress:(LHProgress)progress
             success:(LHResponseSuccess)success
                fail:(LHResponseFail)fail;

/**
 *  下载文件
 *
 *  @param url      请求网络路径
 *  @param fileURL  保存文件url
 *  @param progress 下载进度
 *  @param success  成功回调
 *  @param fail     失败回调
 *
 *  @return 返回NSURLSessionDownloadTask实例，可用于暂停继续，暂停调用suspend方法，重新开启下载调用resume方法
 */
+(NSURLSessionDownloadTask *)downloadWithURL:(NSString *)url
                                 savePathURL:(NSURL *)fileURL
                                    progress:(LHProgress )progress
                                     success:(void (^)(NSURLResponse *, NSURL *))success
                                        fail:(void (^)(NSError *))fail;



///开启网络状态
+ (void)startMonitorNetworkStatus;

@end
