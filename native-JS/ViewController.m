//
//  ViewController.m
//  native-JS
//
//  Created by 刘斌鹏 on 2018/6/14.
//  Copyright © 2018年 杭城小刘. All rights reserved.
//

#import "ViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "PersonInject.h"
#import <WebKit/WebKit.h>

///一种全新的 native<->JS 交互方式
//<WKNavigationDelegate,WKUIDelegate>
@interface ViewController ()<UIWebViewDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) JSContext *jsContext;

@property (nonatomic, strong) UIButton *button;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.webView];
    [self.view addSubview:self.button];
    NSString *localHtmlPath = [[NSBundle mainBundle] pathForResource:@"native-JS" ofType:@"html"];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:localHtmlPath]]];
    
//    [self calcSum];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    
    NSLog(@"加载");
    
    self.jsContext = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    PersonInject *person = [[PersonInject alloc] init];
    person.name = @"杭城小刘";
    person.hobby = @"Coding、Movie、Music、Table tennis、Fit";
    self.jsContext[@"lbp"] = person;
}



- (void)webViewDidFinishLoad:(UIWebView *)webView{
    self.jsContext = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    PersonInject *person = [[PersonInject alloc] init];
    person.name = @"杭城小刘";
    person.hobby = @"Coding、Movie、Music、Table tennis、Fit";
    self.jsContext[@"lbp"] = person;
    
}

#pragma mark -- private method

- (void)calcSum{
    
    [self.jsContext evaluateScript:@"var name='杭城小刘'"];
    NSLog(@"name:%@",[self.jsContext[@"name"] toString]);
    
    
    
    NSString *divieFunction = @"function divide(a,b){ return a/b;}";
    [self.jsContext evaluateScript:divieFunction];
    
    NSLog(@"4/2=%d",[[self.jsContext evaluateScript:@"divide(4,2)"] toInt32]);
    
    
    self.jsContext[@"sayHi"] = ^(){
        NSLog(@"Hello world");
    };
    
    self.jsContext[@"pow"] = ^(JSValue *d, JSValue *powId){
        return pow([d toInt32], [powId toInt32]);
    };
    
    
    self.jsContext.exceptionHandler = ^(JSContext *context, JSValue *exception) {
        NSLog(@"异常信息：%@",exception);
    };
    
}

- (void)callJS{
    JSValue *functionName = self.jsContext[@"sum"];
    NSInteger sum = [[functionName callWithArguments:@[@"2",@"18"]] toInt32];;
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"来自JS 的计算" message:[NSString stringWithFormat:@"%zd",sum] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
    [alertVC addAction:okAction];
    [self presentViewController:alertVC animated:YES completion:nil];
}

#pragma mark -- setter && getter

//- (JSContext *)jsContext{
//    if (!_jsContext) {
//        _jsContext = [[JSContext alloc] init];
//    }
//    return _jsContext;
//}

- (UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
//        _webView.UIDelegate = self;
//        _webView.navigationDelegate = self;
        _webView.delegate = self;
    }
    return _webView;
}

- (UIButton *)button{
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.frame = CGRectMake(100, [UIScreen mainScreen].bounds.size.height - 100,  [UIScreen mainScreen].bounds.size.width - 2*100, 40);
        [_button setTitle:@"JS大哥你好" forState:UIControlStateNormal];
        [_button setBackgroundColor:[UIColor brownColor]];
        [_button setTintColor:[UIColor whiteColor]];
        [_button addTarget:self action:@selector(callJS) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

@end
