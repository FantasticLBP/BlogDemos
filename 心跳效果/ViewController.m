//
//  ViewController.m
//  心跳效果
//
//  Created by 杭城小刘 on 2018/1/10.
//  Copyright © 2018年 杭城小刘. All rights reserved.
//

#import "ViewController.h"
#import "UIViewController+HUD.h"
#import "AppDelegate.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "DatacurbHybrid.h"

@interface ViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) UIWebView *webview;
@property (nonatomic, strong) JSContext *context;

@end

@implementation ViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self.view addSubview:self.webview];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    [self.webview loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:filePath]]];
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}

- (void)heartJump{
    
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.toValue = @0.2;
    animation.keyPath = @"transform.scale";
    animation.repeatCount = HUGE_VALF;
    animation.duration = 0.5;
    animation.autoreverses = YES;
    [self.imageView.layer addAnimation:animation forKey:nil];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self showHint:@"💗我的心脏砰砰跳、迷恋上你的味道💗"];
    });
}


- (void)stopHeart{
    [self.imageView.layer removeAllAnimations];
}

- (void)hybrid{
    self.context = [self.webview valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    DatacurbHybrid *hybrid = [[DatacurbHybrid alloc] init];
    hybrid.message = @"hi";
    hybrid.viewcontroller = self;
    self.context[@"Hybrid"] = hybrid;
}


#pragma mark -- UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [self hybrid];
}

#pragma mark -- lazy load

- (UIWebView *)webview{
    if (!_webview) {
        
        _webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 60, [UIScreen mainScreen].bounds.size.width, 60)];
        _webview.delegate = self;
        _webview.backgroundColor = [UIColor clearColor];
        _webview.scrollView.backgroundColor = [UIColor clearColor];
    }
    return _webview;
}

@end
