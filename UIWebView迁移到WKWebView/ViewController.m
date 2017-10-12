//
//  ViewController.m
//  UIWebView迁移到WKWebView
//
//  Created by 杭城小刘 on 2017/8/29.
//  Copyright © 2017年 杭城小刘. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>

//监测帧刷新率
#import "YYFPSLabel.h"

#define BoundWidth  [[UIScreen mainScreen]bounds].size.width
#define BoundHeight [[UIScreen mainScreen]bounds].size.height

@interface ViewController ()<WKNavigationDelegate,WKUIDelegate>
//<UIWebViewDelegate>

@property (nonatomic, strong) WKWebView *wkWebView;

@property (nonatomic, strong) UIWebView *webView;

@property (nonatomic, strong) YYFPSLabel *fpsTestLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
  
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://192.168.51.175:8020/mz-tools/html/childPreBuild/test.html"]];
//    /*
//     * UIWebView
//    [self.view addSubview:self.webView];
//    [self.webView loadRequest:request];
//     */
//    
//    /*
//     * WKWebView
//     */
//    [self.view addSubview:self.wkWebView];
//    [self.wkWebView loadRequest:request];
//    
//    
//    [self.view addSubview:self.fpsTestLabel];
    
    
}


#pragma mark -- WKNavigationDelegate
//在发送网络请求前，判断是否需要跳转
//- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
//    
//}
//
////在收到响应后，决定是否需要跳转
//- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
//    
//}

//页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
    
}

//接收到服务端请求重定向
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
    
}

//页面加载失败
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    
}

//页面内容开始返回
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation{
    
}

//页面加载完成后
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
    
}

//页面请求失败
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    
}



#pragma mark -- WKUIDelegate
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"你好" message:@"嗯，你好" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"退出" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }];
    [alertVC addAction:ok];
    [alertVC addAction:cancel];
    [self presentViewController:alertVC animated:YES completion:nil];
}

#pragma mark -- UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *urlString = request.URL.absoluteString;
    if ([urlString containsString:@"baidu.com"]) {
        return YES;
    }
    return NO;
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    NSLog(@"开始加载");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"加载完成");
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"加载失败");
}

#pragma mark -- lazy load
-(WKWebView *)wkWebView{
    if (!_wkWebView) {
        _wkWebView = [[WKWebView alloc] initWithFrame:self.view.bounds];
        _wkWebView.navigationDelegate = self;
        _wkWebView.UIDelegate = self;
    }
    return _wkWebView;
}

-(UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        _webView.delegate = self;
    }
    return _webView;
}

-(YYFPSLabel *)fpsTestLabel{
    if (!_fpsTestLabel) {
        _fpsTestLabel = [[YYFPSLabel alloc] initWithFrame:CGRectMake(BoundWidth/2 - 100 /2, BoundHeight/2-30/2, 100, 30)];
    }
    return _fpsTestLabel;
}

- (IBAction)clickRememberPasswordSwicth:(id)sender {
}

- (IBAction)clickAutoLoginSwitch:(id)sender {
}
@end
