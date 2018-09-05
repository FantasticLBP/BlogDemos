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

@interface ViewController ()<UIWebViewDelegate,WKUIDelegate,WKNavigationDelegate>
//<WKNavigationDelegate,WKUIDelegate>

@property (nonatomic, strong) WKWebView *wkWebView;

@property (nonatomic, strong) UIButton *button;

@property (nonatomic, strong) UIWebView *webView;

@property (nonatomic, strong) YYFPSLabel *fpsTestLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.wkWebView];
    [self.view addSubview:self.button];
    
    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:htmlPath]];
    [self.wkWebView loadRequest:request];

//
//    /*
//     * WKWebView
//     */
//    [self.view addSubview:self.wkWebView];
//    [self.wkWebView loadRequest:request];
//    [self.view addSubview:self.fpsTestLabel];
}


#pragma mark -- response method

-(void)addContentToWebView{
    NSString *jsString = @" var pNode = document.createElement(\"p\"); pNode.innerText = \"我是由原生代码调用js后将一段文件添加到html上，也就是注入\";document.body.appendChild(pNode);";
    [self.webView stringByEvaluatingJavaScriptFromString:jsString];
}


#pragma mark -- private method

-(NSInteger)plusparm:(NSInteger)par1 parm2:(NSInteger)par2{
    return par1 + par2;
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
    NSURL *url = request.URL;
    NSString *scheme = url.scheme;
    NSString *method = url.host;
    NSString *parms =  url.query;
    NSArray *pars = [parms componentsSeparatedByString:@"&"];
    NSInteger par1 = [[pars[0] substringFromIndex:5] integerValue];
    NSInteger par2 = [[pars[1] substringFromIndex:5] integerValue];
    if ([scheme isEqualToString:@"jsbridge"]) {
        //发现scheme是JSBridge，那么就是自定义的URLscheme，不去加载网页内容而拦截去处理事件。
        
        if ([method isEqualToString:@"plus"]) {
           NSInteger result = [self plusparm:par1 parm2:par2];
            [self.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"receiveValue(%@);",@(result)]];
        }
        
        return NO;
    }
    return YES;
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
        
        NSString *userAgentString = @"DatacubrHybrid_1.1.0";
        [[NSUserDefaults standardUserDefaults] registerDefaults:@{@"UserAgent": userAgentString}];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [_wkWebView setCustomUserAgent:userAgentString];
    }
    return _wkWebView;
}

-(WKWebView *)webView{
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, BoundWidth, BoundHeight - 100)];
        _webView.delegate = self;
        
    }
    return _webView;
}

-(UIButton *)button{
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.frame = CGRectMake(100, BoundHeight - 80, BoundWidth - 200, 60);
        _button.backgroundColor = [UIColor brownColor];
        [_button setTitle:@"点我，网页添加一行内容" forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(addContentToWebView) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
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
