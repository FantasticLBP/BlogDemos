//
//  ProgressView.m
//  下载进度条
//
//  Created by 杭城小刘 on 2017/10/15.
//  Copyright © 2017年 杭城小刘. All rights reserved.
//

#import "ProgressView.h"

@implementation ProgressView


-(void)drawRect:(CGRect)rect{
    CGPoint center = CGPointMake(rect.size.width * 0.5, rect.size.height * 0.5);
    CGFloat radius = rect.size.width * 0.5 - 10;
    CGFloat startA = -M_PI/2;
    CGFloat endA = -M_PI/2 + self.progress*2*M_PI;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:YES];
    
    [path stroke];
}

-(void)setProgress:(CGFloat)progress{
    _progress = progress;
    //手动调用控件的drawRect方法不会去绘制图形，因为拿不到当前的上下文
//    [self drawRect:self.bounds];
    //调用控件的setNeedsDispaly方法，系统底层会调用drawRect方法，且可以拿到上下文
    [self setNeedsDisplay];
}

@end
