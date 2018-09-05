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

@interface ViewController ()<UIWebViewDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) JSContext *jsContext;

@property (nonatomic, strong) UIButton *button;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.webView];
//    [self communicateByBridge];
    [self communicateByUrlScheme];
//    [self communicateByJSContext];
    
}

/*
 Native 和 Web 交互由 桥接对象实现
 具体实现可以查看对应的 Html 文件里面的 JS 部分
 */

- (void)communicateByBridge{
    
    [self.view addSubview:self.button];
    
    NSString *localHtmlPath = [[NSBundle mainBundle] pathForResource:@"native-JS" ofType:@"html"];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:localHtmlPath]]];
}

/*
 Native 和 Web 交互由 自定义 url-Scheme 实现
 具体实现可以查看对应的 Html 文件里面的 JS 部分
 */
- (void)communicateByUrlScheme{
    NSString *localHtmlPath = [[NSBundle mainBundle] pathForResource:@"urlScheme" ofType:@"html"];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:localHtmlPath]]];
}

/*
 Native 和 Web 交互由 JavascriptCore 实现
 具体实现可以查看对应的 Html 文件里面的 JS 部分
 */
- (void)communicateByJSContext{
    [self calcSum];
}


- (void)test{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"js"];
    NSString *scriptString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    JSContext *context = [[JSContext alloc] init];
    [context evaluateScript:scriptString];
    
    context[@"print"] = ^(NSString *text){
        NSLog(@"%@",text);
    };
    
    JSValue *jsfunction = context[@"printHello"];
    [jsfunction callWithArguments:nil];
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
    [self test];
    
    return ;
    JSValue *functionName = self.jsContext[@"sum"];
    NSInteger sum = [[functionName callWithArguments:@[@"2",@"18"]] toInt32];;
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"来自JS 的计算" message:[NSString stringWithFormat:@"%zd",sum] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
    [alertVC addAction:okAction];
    [self presentViewController:alertVC animated:YES completion:nil];
}

-(NSInteger)plusparm:(NSInteger)par1 parm2:(NSInteger)par2{
    return par1 + par2;
}

-(NSString*)URLDecodedString:(NSString*)str

{
    
    NSString *decodedString = (__bridge_transfer NSString*)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (__bridge CFStringRef)str,CFSTR(""),CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    
    return [decodedString stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    
}


#pragma mark -- UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
   
    
    
    NSURL *url = request.URL;
    NSString *scheme = url.scheme;
    NSString *method = url.host;
    NSString *parms =  url.query;
    NSArray *pars = [parms componentsSeparatedByString:@"&"];
    
    NSString *callbackString = [pars[1] substringFromIndex:9];
    
    
    id decodeParams = [[[self URLDecodedString:pars.lastObject] substringFromIndex:6] stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    NSInteger para1 = 0;
    NSInteger para2 = 0;
    
    if ([decodeParams isKindOfClass:[NSString class]]) {
        NSDictionary *paramsDict = [NSJSONSerialization JSONObjectWithData:[decodeParams dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
        para1 = [paramsDict[@"par1"] integerValue];
        para2 = [paramsDict[@"par2"] integerValue];
    }
    
    if ([[scheme lowercaseString] isEqualToString:@"jsbridge"]) {
        //发现scheme是JSBridge，那么就是自定义的URLscheme，不去加载网页内容而拦截去处理事件。
        
        if ([method isEqualToString:@"plus"]) {
            NSInteger result = [self plusparm:para1 parm2:para2];
            [self.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"window.Hybrid['%@']('%@');",callbackString,@(result)]];
        }
        
        return NO;
    }
    return YES;
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
