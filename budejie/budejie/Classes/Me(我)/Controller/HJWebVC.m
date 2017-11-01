//
//  HJWebVC.m
//  budejie
//
//  Created by hjun on 2017/10/31.
//  Copyright © 2017年 hjun. All rights reserved.
//

#import "HJWebVC.h"
#import <WebKit/WebKit.h>
@interface HJWebVC ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *forwardItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *refresh;
@property (weak, nonatomic) IBOutlet UIProgressView *progress;
@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (nonatomic,strong)WKWebView *webView;

@end

@implementation HJWebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    WKWebView *webView = [[WKWebView alloc]init];
    _webView = webView;
    [self.contentView addSubview:webView];
    
    NSURLRequest * request = [NSURLRequest requestWithURL:self.url];
    
    [webView loadRequest:request];
    
    [webView addObserver:self forKeyPath:@"canGoBack" options:NSKeyValueObservingOptionNew context:nil];
    [webView addObserver:self forKeyPath:@"canGoForward" options:NSKeyValueObservingOptionNew context:nil];
    [webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    
    // 进度条
    [webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    
    
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    self.backItem.enabled = self.webView.canGoBack;
    self.forwardItem.enabled = self.webView.canGoForward;
    self.title = self.webView.title;
    self.progress.progress = self.webView.estimatedProgress;
    self.progress.hidden = self.webView.estimatedProgress >= 1;
    
    
}
#pragma mark - 对象被销毁
- (void)dealloc
{
    [self.webView removeObserver:self forKeyPath:@"canGoBack"];
    [self.webView removeObserver:self forKeyPath:@"title"];
    [self.webView removeObserver:self forKeyPath:@"canGoForward"];
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}



- (IBAction)goBackItem:(UIBarButtonItem *)sender {
    [self.webView goBack];
}
- (IBAction)goForwardItem:(UIBarButtonItem *)sender {
    [self.webView goForward];
}
- (IBAction)refreshItem:(UIBarButtonItem *)sender {
    [self.webView reload];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    _webView.frame = self.contentView.bounds;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
