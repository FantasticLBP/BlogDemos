//
//  ViewController.m
//  CALayer基本操作
//
//  Created by 杭城小刘 on 2018/1/3.
//  Copyright © 2018年 杭城小刘. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) CALayer *layer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CALayer *layer = [CALayer layer];
    layer.bounds = CGRectMake(0, 0, 100, 100);
    
    layer.backgroundColor = [UIColor redColor].CGColor;
    
    layer.position = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
    layer.anchorPoint = CGPointMake(0.5, 0.5);
    self.layer = layer;
    
    [self.view.layer addSublayer:layer];
 
    
    
    
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //动画底层被包装为一个事务
    [CATransaction begin];
    [CATransaction setDisableActions:NO];
    [CATransaction setAnimationDuration:3];
    
    self.layer.bounds = CGRectMake(100, 100, 200, 200);
    self.layer.backgroundColor = [UIColor yellowColor].CGColor;
    self.layer.cornerRadius = 40;
    
    [CATransaction commit];
     
}

@end
