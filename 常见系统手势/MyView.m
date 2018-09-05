
//
//  MyView.m
//  基本图形绘制
//
//  Created by 杭城小刘 on 2017/10/14.
//  Copyright © 2017年 杭城小刘. All rights reserved.
//

#import "MyView.h"

@implementation MyView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

*/
- (void)drawRect:(CGRect)rect {
    [self drawLine];
//    [self drawRect];
//    [self drawCiclr1];
//    [self drawCircle2];
//    [self drawSector:rect];
//    [self drawQuadCurve];
//    [self drawUnFilledSector:rect];
//    [self drawFilledSector:rect];
}

-(void)drawFilledSector:(CGRect)rect{
    //圆心
    CGPoint center =CGPointMake(rect.size.width * 0.5, rect.size.height * 0.5);
    //半径
    CGFloat radius = rect.size.width * 0.5;
    //扇形起始点位置：0 代表圆的最右边
    CGFloat startA = 0;
    //扇形的终点为主
    CGFloat endA = -M_PI/2;
    //扇形的方向。YES：顺时针，NO：逆时针
    BOOL wise = NO;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:wise];
    //以上个终点为起点
    [path addLineToPoint:center];
    //如果需要绘制填充效果的图形，那么可以不用封闭path
    //[path closePath];
    
    [[UIColor whiteColor] set];
    [path fill];
}

//画没有填充满的扇形
-(void)drawUnFilledSector:(CGRect)rect{
    //圆心
    CGPoint center =CGPointMake(rect.size.width * 0.5, rect.size.height * 0.5);
    //半径
    CGFloat radius = rect.size.width * 0.5;
    //扇形起始点位置：0 代表圆的最右边
    CGFloat startA = 0;
    //扇形的终点为主
    CGFloat endA = -M_PI/2;
    //扇形的方向。YES：顺时针，NO：逆时针
    BOOL wise = NO;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:wise];
    //以上个终点为起点
    [path addLineToPoint:center];
    [path closePath];
    
    [[UIColor whiteColor] set];
    [path stroke];
}

//画扇形
-(void)drawSector:(CGRect)rect{
    //圆心
    CGPoint center =CGPointMake(rect.size.width * 0.5, rect.size.height * 0.5);
    //半径
    CGFloat radius = rect.size.width * 0.5;
    //扇形起始点位置：0 代表圆的最右边
    CGFloat startA = 0;
    //扇形的终点为主
    CGFloat endA = M_PI;
    //扇形的方向。YES：顺时针，NO：逆时针
    BOOL wise = NO;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:wise];
    [[UIColor whiteColor] set];
    [path stroke];
}

//画圆方法1:利用圆角矩形的画法
-(void)drawCiclr1{
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(50, 50, 200, 200) cornerRadius:100];
    [[UIColor brownColor] set];
    [path fill];
}

//画圆方法2：利用画椭圆
-(void)drawCircle2{
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(150, 150, 100, 100)];
    [[UIColor redColor] set];
    [path fill];
}

-(void)drawRoundRect{
    //1、获得上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //2、绘制路径
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(50, 50, 200, 200) cornerRadius:30];
    [[UIColor yellowColor] set];
    //3、将绘制的路径添加到上下文
    CGContextAddPath(ctx, path.CGPath);
    //4、把上下文的内容显示到view上
    CGContextFillPath(ctx);
}


-(void)drawRect{
    //1、获得上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //2、绘制路径
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(50, 50, 200, 200)];
    [[UIColor yellowColor] set];
    //3、将绘制的路径添加到上下文
    CGContextAddPath(ctx, path.CGPath);
    //4、把上下文的内容显示到view上
    CGContextFillPath(ctx);
}

//画曲线
-(void)drawQuadCurve{
    //1、获得上下文
    CGContextRef ctx =  UIGraphicsGetCurrentContext();
    
    //2、绘制路径
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path moveToPoint:CGPointMake(100, 200)];
    [path addQuadCurveToPoint:CGPointMake(200, 200) controlPoint:CGPointMake(150, 50)];
    
    CGContextSetLineWidth(ctx, 5);
    
    //3、将绘制的路径添加到上下文
    CGContextAddPath(ctx, path.CGPath);
    //4、把上下文的内容显示到view上（渲染）：fill、stroke
    CGContextStrokePath(ctx);
}


//画直线
-(void)drawLine{
    //rect:当前view的bounds
    NSLog(@"%s",__func__);
    
    
    //1、取得上下文
    //2、绘制图形（描述路径）
    //3、将绘制的图形添加到上下文（路径添加到上下文）
    //4、上下文的内容显示到view上（渲染）
    
    //1、获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //2、描述路径
    UIBezierPath *path = [UIBezierPath bezierPath];
    //设置起点
    [path moveToPoint:CGPointMake(200, 200)];
    //添加线条到某个点
    [path addLineToPoint:CGPointMake(100, 100)];
    [path addLineToPoint:CGPointMake(200, 80)];
    [path addLineToPoint:CGPointMake(100, 240)];
    /*
     //一个path上可以绘制多条线
     [path moveToPoint:CGPointMake(50, 20)];
     [path addLineToPoint:CGPointMake(50, 280)];
     
     [path moveToPoint:CGPointMake(150, 40)];
     [path addLineToPoint:CGPointMake(150, 300)];
     */
    
    
    //设置上下文的状态
    CGContextSetLineWidth(ctx, 10);
    CGFloat colors[4] = {1.0, 0.0, 0.0, 1.0};
    CGContextSetStrokeColor(ctx, colors);
    //设置线条的连接样式
    
    //    kCGLineJoinMiter,
    //    kCGLineJoinRound,
    //    kCGLineJoinBevel
    CGContextSetLineJoin(ctx,  kCGLineJoinRound);
    
    //设置顶角样式
    //    kCGLineCapButt,
    //    kCGLineCapRound,
    //    kCGLineCapSquare
    CGContextSetLineCap(ctx, kCGLineCapSquare);
    //3、将绘制的路径添加到上下文
    CGContextAddPath(ctx, path.CGPath);
    //4、把上下文的内容显示到view上（渲染）：fill、stroke
    CGContextStrokePath(ctx);
}

@end
