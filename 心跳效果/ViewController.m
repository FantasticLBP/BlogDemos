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
@property (weak, nonatomic) IBOutlet UITextField *nameTextfield;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nameHeight;
@property (nonatomic, strong) DatacurbHybrid *hybrid;

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
    if (self.nameHeight.constant == 30) {
        self.nameHeight.constant = 0;
        [self.nameTextfield resignFirstResponder];
    } else {
        self.nameHeight.constant = 30;
        [self.nameTextfield becomeFirstResponder];
    }
    [self stopHeart];
}

- (void)heartJump{
    self.hybrid.message = self.nameTextfield.text;

    dispatch_async(dispatch_get_main_queue(),  ^{
        CABasicAnimation *animation = [CABasicAnimation animation];
        animation.toValue = @0.2;
        animation.keyPath = @"transform.scale";
        animation.repeatCount = HUGE_VALF;
        animation.duration = 0.5;
        animation.autoreverses = YES;
        [self.imageView.layer addAnimation:animation forKey:nil];
    });
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self showHint:@"💗我的心脏砰砰跳、迷恋上你的味道💗"];
    });
}


- (void)stopHeart{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.imageView.layer removeAllAnimations];
    });
}

- (void)initHybrid{
    self.context = [self.webview valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    self.context[@"Hybrid"] =  self.hybrid;
}


#pragma mark -- UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [self initHybrid];
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

- (DatacurbHybrid *)hybrid
{
    if (!_hybrid) {
        _hybrid =  [[DatacurbHybrid alloc] init];
        _hybrid.viewcontroller = self;
    }
    return _hybrid;
}

@end
