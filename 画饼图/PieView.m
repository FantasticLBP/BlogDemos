//
//  PieView.m
//  画饼图
//
//  Created by 杭城小刘 on 2017/10/15.
//  Copyright © 2017年 杭城小刘. All rights reserved.
//

#import "PieView.h"

@implementation PieView

-(void)drawRect:(CGRect)rect{
    [self drawPie:rect];
}

-(void)drawPie:(CGRect)rect{
    CGPoint center = CGPointMake(rect.size.width * 0.5, rect.size.height * 0.5);
    CGFloat radius = rect.size.width * 0.5 -10;
    CGFloat startA = 0;
    CGFloat angle = 0;
    CGFloat endA = 0;
    for (NSNumber *pie in self.pies) {
        startA = endA;
        angle = (pie.intValue / 100.0) * 2 *M_PI;
        endA = startA + angle;
        
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:YES];
        [path addLineToPoint:center];
        [[self randomColor] set];
        [path fill];
    }
}

-(UIColor *)randomColor{
    CGFloat r = arc4random_uniform(256)/255.0;
    CGFloat g = arc4random_uniform(256)/255.0;
    CGFloat b = arc4random_uniform(256)/255.0;
    return [UIColor colorWithRed:r green:g blue:b alpha:1];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self setNeedsDisplay];
}

#pragma mark -- setter
-(void)setPies:(NSArray *)pies{
    _pies = pies;
    [self setNeedsDisplay];
}



@end
