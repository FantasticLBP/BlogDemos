//
//  ViewController.m
//  Category中增加属性
//
//  Created by 杭城小刘 on 2017/9/5.
//  Copyright © 2017年 杭城小刘. All rights reserved.
//

#import "ViewController.h"
#import "UIButton+propertyTest.h"


@interface ViewController ()

@property (nonatomic, strong) UIButton *writeButton;

@property (nonatomic, strong) UIButton *readButton;

@end

@implementation ViewController


#pragma mark -- life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.writeButton];
    [self.view addSubview:self.readButton];
}

#pragma mark -- response method

-(void)writeProperty{
   self.writeButton.name = @"我是category中动态增加的属性";
}

-(void)readProperty{
    NSLog(@"%@",self.writeButton.name);
}




- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    //NS
    if (context == @"Button objc_setAssociatedObject name") {
        NSLog(@"keypath->%@,object->%@,change->%@,context->%@",keyPath,object,change,context);
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark -- lazy load

-(UIButton *)writeButton{
    if (!_writeButton) {
        _writeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _writeButton.backgroundColor = [UIColor brownColor];
        _writeButton.frame = CGRectMake(100, 50, self.view.bounds.size.width - 200, 40);
        [_writeButton setTitle:@"给category增加属性" forState:UIControlStateNormal];
        _writeButton.layer.cornerRadius = 5;
        _writeButton.layer.masksToBounds = YES;
        
        [_writeButton addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew |  NSKeyValueObservingOptionOld context:@"Button objc_setAssociatedObject name"];
        
        
        [_writeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [_writeButton addTarget:self action:@selector(writeProperty) forControlEvents:UIControlEventTouchUpInside];
    }
    return _writeButton;
}

-(UIButton *)readButton{
    if (!_readButton) {
        _readButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _readButton.backgroundColor = [UIColor brownColor];
        _readButton.frame = CGRectMake(100, 200, self.view.bounds.size.width - 200, 40);
        [_readButton setTitle:@"读取category属性" forState:UIControlStateNormal];
        _readButton.layer.cornerRadius = 5;
        _readButton.layer.masksToBounds = YES;
        
        [_readButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [_readButton addTarget:self action:@selector(readProperty) forControlEvents:UIControlEventTouchUpInside];
    }
    return _readButton;
}

- (IBAction)test:(id)sender {
}
@end
