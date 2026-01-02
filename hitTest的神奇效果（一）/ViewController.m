//
//  ViewController.m
//  hitTest的神奇效果（一）
//
//  Created by 杭城小刘 on 2017/10/12.
//  Copyright © 2017年 杭城小刘. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIGestureRecognizerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapContainer)];
    tap.delegate = self;
    tap.cancelsTouchesInView = YES;
    [self.view addGestureRecognizer:tap];
}
//
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return NO;
}

- (void)didTapContainer {
    NSLog(@"响应了容器的手饰事件后，子 View 自身的事件就不会被响应了");
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"viewController->%s",__func__);
}



@end
