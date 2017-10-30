//
//  UPSHttpNetWorkTool.m
//  UPS
//
//  Created by hjun on 2017/8/21.
//  Copyright © 2017年 hjun. All rights reserved.
//

#import "UPSHttpNetWorkTool.h"

@interface UPSHttpNetWorkTool()

@property (nonatomic,strong) AFHTTPSessionManager *manager;


@end
@implementation UPSHttpNetWorkTool

//获得单例接口
+ (instancetype)sharedApi{
    static dispatch_once_t onceToken;
    static UPSHttpNetWorkTool *instance;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc]init];
    });
    return instance;
}
///// GET请求方法:path传URL地址  params传请求体
//- (void)GET:(NSString *)path params:(id)params complete:(void(^)(BOOL result,id responseObj))comlete{
//    [self.manager GET:path parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        
//        NSError *error = nil;
//        id results = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&error];
//        comlete(YES, results);
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        comlete(NO, error);
//        [SVProgressHUD showErrorWithStatus:@"加载数据出错"];
//
//    }];
//    
//    
//    
//}
///// POST请求方法:path传URL地址  params传请求体
//- (void)POST:(NSString *)path params:(id)params complete:(void(^)(BOOL result,id responseObj))comlete{
//    [self.manager POST:path parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSError *error = nil;
//        id results = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&error];
//        //NSLog(@"result = %@ ----- error = %@",results,error);
//        comlete(YES, results);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        // NSLog(@"error = %@",error);
//        comlete(NO,error);
//    }];
//
//}
//
//- (void)POSTUrlString:(NSString *)stringUrl params:(NSDictionary *)params complete:(void(^)(NSDictionary *result,NSError *error))complete{
//    
//    [self.manager POST:stringUrl
//                 parameters:params
//                   progress:nil
//                    success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable responseObject) {
//                        if ([responseObject[@"msg"] isEqualToString:@"OK"]) {
//                            complete(responseObject[@"data"] ,nil);
//                        } else{
//                            [SVProgressHUD showErrorWithStatus:@"加载数据出错"];
//                            complete( nil ,[[NSError alloc ] initWithDomain:@"" code:0 userInfo:@{@"message":@"请求失败"}]);
//                        }
//                        
//                    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//                        [SVProgressHUD showErrorWithStatus:@"加载数据出错"];
//                        //                        NSLog(@"加载数据错误 = %@",error.localizedDescription);
//                    }
//     ];
//
//}
//
//- (AFHTTPSessionManager *)manager{
//    if (_manager == nil) {
//        _manager = [AFHTTPSessionManager manager];
//        //让第三方不解析，直接返回原始的二进制数据
//        _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"plant/html",nil];
//        //将请求体序列化
//        _manager.requestSerializer  = [AFJSONRequestSerializer serializer];
//        
//    }
//    return _manager;
//    
//}


/**
 *  普通get方法请求网络数据
 *
 *  @param url     请求网址路径
 *  @param params  请求参数
 *  @param success 成功回调
 *  @param fail    失败回调
 */

-(void)GET:(NSString *)url params:(NSDictionary *)params
   success:(LHResponseSuccess)success fail:(LHResponseFail)fail{
    
    AFHTTPSessionManager *manager = [UPSHttpNetWorkTool managerWithBaseURL:nil sessionConfiguration:NO];
    [manager GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        id dic = [UPSHttpNetWorkTool responseConfiguration:responseObject];
        
        success(task,dic);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail(task,error);
    }];
}

/**
 *  含有baseURL的get方法
 *
 *  @param url     请求网址路径
 *  @param baseUrl 请求网址根路径
 *  @param params  请求参数
 *  @param success 成功回调
 *  @param fail    失败回调
 */


-(void)GET:(NSString *)url baseURL:(NSString *)baseUrl params:(NSDictionary *)params
   success:(LHResponseSuccess)success fail:(LHResponseFail)fail{
    
    AFHTTPSessionManager *manager = [UPSHttpNetWorkTool managerWithBaseURL:baseUrl sessionConfiguration:NO];
    [manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        id dic = [UPSHttpNetWorkTool responseConfiguration:responseObject];
        
        success(task,dic);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail(task,error);
    }];
    
}
/**
 *  普通post方法请求网络数据
 *
 *  @param url     请求网址路径
 *  @param params  请求参数
 *  @param success 成功回调
 *  @param fail    失败回调
 */

-(void)POST:(NSString *)url params:(NSDictionary *)params
    success:(LHResponseSuccess)success fail:(LHResponseFail)fail{
    
    AFHTTPSessionManager *manager = [UPSHttpNetWorkTool managerWithBaseURL:nil sessionConfiguration:NO];
    
    [manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        id dic = [UPSHttpNetWorkTool responseConfiguration:responseObject];
        
        success(task,dic);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail(task,error);
    }];
}

/**
 *  含有baseURL的post方法
 *
 *  @param url     请求网址路径
 *  @param baseUrl 请求网址根路径
 *  @param params  请求参数
 *  @param success 成功回调
 *  @param fail    失败回调
 */

-(void)POST:(NSString *)url baseURL:(NSString *)baseUrl params:(NSDictionary *)params
    success:(LHResponseSuccess)success fail:(LHResponseFail)fail{
    
    AFHTTPSessionManager *manager = [UPSHttpNetWorkTool managerWithBaseURL:baseUrl sessionConfiguration:NO];
    [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        id dic = [UPSHttpNetWorkTool responseConfiguration:responseObject];
        
        success(task,dic);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail(task,error);
    }];
}

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

-(void)uploadWithURL:(NSString *)url params:(NSDictionary *)params fileData:(NSData *)filedata name:(NSString *)name fileName:(NSString *)filename mimeType:(NSString *) mimeType progress:(LHProgress)progress success:(LHResponseSuccess)success fail:(LHResponseFail)fail{
    
    AFHTTPSessionManager *manager = [UPSHttpNetWorkTool managerWithBaseURL:nil sessionConfiguration:NO];
    
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFileData:filedata name:name fileName:filename mimeType:mimeType];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        progress(uploadProgress);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        id dic = [UPSHttpNetWorkTool responseConfiguration:responseObject];
        success(task,dic);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail(task,error);
    }];
}

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
                fail:(LHResponseFail)fail{
    
    AFHTTPSessionManager *manager = [UPSHttpNetWorkTool managerWithBaseURL:baseurl sessionConfiguration:YES];
    
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:filedata name:name fileName:filename mimeType:mimeType];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        progress(uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        id dic = [UPSHttpNetWorkTool responseConfiguration:responseObject];
        
        success(task,dic);
        
        
        success(task,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail(task,error);
    }];
}
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
                                        fail:(void (^)(NSError *))fail{
    AFHTTPSessionManager *manager = [self managerWithBaseURL:nil sessionConfiguration:YES];
    
    NSURL *urlpath = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:urlpath];
    
    NSURLSessionDownloadTask *downloadtask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        progress(downloadProgress);
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        return [fileURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        if (error) {
            fail(error);
        }else{
            
            success(response,filePath);
        }
    }];
    
    [downloadtask resume];
    
    return downloadtask;
}

#pragma mark - Private

+(AFHTTPSessionManager *)managerWithBaseURL:(NSString *)baseURL  sessionConfiguration:(BOOL)isconfiguration{
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFHTTPSessionManager *manager =nil;
    
    NSURL *url = [NSURL URLWithString:baseURL];
    
    if (isconfiguration) {
        
        manager = [[AFHTTPSessionManager alloc] initWithBaseURL:url sessionConfiguration:configuration];
    }else{
        manager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
    }
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    return manager;
}

+(id)responseConfiguration:(id)responseObject{
    
    NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
    string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    return dic;
}

///  开始监控网络状态
+ (void)startMonitorNetworkStatus{
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusNotReachable) {
            //[SVProgressHUD showErrorWithStatus:@"无法连接网络!"];
        }
    }];
}



@end
