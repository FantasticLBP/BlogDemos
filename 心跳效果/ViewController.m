//
//  ViewController.m
//  心跳效果
//
//  Created by 杭城小刘 on 2018/1/10.
//  Copyright © 2018年 杭城小刘. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.toValue = @0.2;
    animation.keyPath = @"transform.scale";
    animation.repeatCount = MAXFLOAT;
    animation.duration = 0.5;
    animation.autoreverses = YES;
    [self.imageView.layer addAnimation:animation forKey:nil];
}


@end
