//
//  ViewController.m
//  Block底层研究
//
//  Created by 刘斌鹏 on 2018/5/16.
//  Copyright © 2018年 杭城小刘. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark -- life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    //block 函数式编程
    [self blockAsFunctionalProgramming];
    //block 链式语法
    [self blockAsChainSyntax];
    // NSParameterAssert
    [self testAssert:nil];
}
- (IBAction)clickButton:(id)sender {
}
- (IBAction)didClickButton:(id)sender {
}

- (void)testAssert:(NSString *)message{
    NSParameterAssert( message.length > 0);
    NSLog(@"%@",message);
}

- (void)blockAsChainSyntax{
    self.prepare.play(@"女人");
}

- (void)blockAsFunctionalProgramming{
    [self reprepare:^{
        NSLog(@"接下来玩女人，好不好？😊");
    }];
}

#pragma mark -- private method

- (ViewController *(^)(NSString *))play{
    NSLog(@"即将吃喝玩乐");
    ViewController *(^block)(NSString *) = ^ViewController *(NSString *fun){
        NSLog(@"接下来玩%@，好不好？",fun);
        return self;
    };
    return block;
}

- (ViewController *)prepare{
    NSLog(@"我们先好好休息一下。😂\n");
    return self;
}


- (void)reprepare:(void(^)(void))replay{
    NSLog(@"我们先好好休息一下。😂\n");
    replay();
}


@end
