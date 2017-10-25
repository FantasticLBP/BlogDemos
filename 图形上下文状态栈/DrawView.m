
//
//  DrawView.m
//  图形上下文状态栈
//
//  Created by 杭城小刘 on 2017/10/18.
//  Copyright © 2017年 杭城小刘. All rights reserved.
//

#import "DrawView.h"

@implementation DrawView

-(void)drawRect:(CGRect)rect{
    
    //1、得到图形上下文
    CGContextRef ctx =UIGraphicsGetCurrentContext();
    //2、绘制路径
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(10, 150)];
    [path addLineToPoint:CGPointMake(290, 150)];
    //保存当前的图形上下文状态栈
    CGContextSaveGState(ctx);
    
    
    [[UIColor redColor] set];
    CGContextSetLineWidth(ctx, 10);
    //3、将路径添加到图形上下文中
    CGContextAddPath(ctx, path.CGPath);
    //4、渲染上下文
    CGContextStrokePath(ctx);
    
   
    //3、将路径天教导图形上下文中
    CGContextAddPath(ctx, path.CGPath);
    //4、渲染上下文
    CGContextStrokePath(ctx);
    
    
    path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(150, 10)];
    [path addLineToPoint:CGPointMake(150, 290)];
    //从图形上下文状态栈中恢复保存的上下文属性信息
    CGContextRestoreGState(ctx);
    //3、将路径天教导图形上下文中
    CGContextAddPath(ctx, path.CGPath);
    //4、渲染上下文
    CGContextStrokePath(ctx);
    
}



@end
