//
//  ViewController.m
//  HotFix
//
//  Created by 杭城小刘 on 2019/8/6.
//  Copyright © 2019 杭城小刘. All rights reserved.
//

#import "ViewController.h"
#import "Tester.h"
#import "FixManager.h"
#import "Enginner.h"
#import "BugProtector.h"

@interface ViewController ()
@property (nonatomic, strong) UIButton *button;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"A";
    
    [FixManager fixIt];
    [self.view addSubview:self.button];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSString *fixScriptString = @" \
    fixInstanceMethodReplace('Tester', 'divideUsingDenominator:', function(instance, originInvocation, originArguments){ \
    if (originArguments[0] == 0) { \
    console.log('zero goes here'); \
    } else { \
    runInvocation(originInvocation); \
    } \
    }); \
    \
    ";
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"FixBug" object:@{@"message": fixScriptString}];
    
    
    NSString *enginnerFixScript = @" \
    fixClassMethodAfter('Enginner', 'sayHi:age:', function(instance, originInvocation,  originArguments) { \
    if (originArguments[0] && !originArguments[1]) { \
    console.log('居然不告我你的芳龄，小妹妹很调皮哦。'); \
    } \
    runInvocation(originInvocation); \
    }); \
    ";
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"FixBug" object:@{@"message": enginnerFixScript}];
    
}


// 测试修复线上包问题
- (void)testHotFix
{
    // 针对方法替换的例子
    Tester *mc = [[Tester alloc] init];
    double result = [mc divideUsingDenominator:0];
    NSLog(@"result: %f", result);
    
    // 针对方法执行完毕后面添加逻辑的例子
    [Enginner sayHi:@"杭城小刘" age:nil];
}

- (void)calcuate
{
    [self testHotFix];
}

#pragma mark - getters and setters
- (UIButton *)button
{
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.frame = CGRectMake(40, 100, self.view.frame.size.width - 80, 40);
        [_button setTitle:@"点击计算" forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(calcuate) forControlEvents:UIControlEventTouchUpInside];
        _button.layer.borderColor = [UIColor grayColor].CGColor;
        _button.layer.cornerRadius = 5;
        _button.layer.borderWidth = 1;
    }
    return _button;
}

@end
