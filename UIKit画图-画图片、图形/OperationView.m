

//
//  OperationView.m
//  UIKit画图-画图片、图形
//
//  Created by 杭城小刘 on 2017/10/17.
//  Copyright © 2017年 杭城小刘. All rights reserved.
//

#import "OperationView.h"

@implementation OperationView

-(void)drawRect:(CGRect)rect{
    
    UIImage *image = [UIImage imageNamed:@"way"];
    //按照图片原始尺寸绘制图片
    //[image drawAtPoint:CGPointZero];
    
    //将图片适当拉伸至当前rect
    //[image drawInRect:rect];
    
    //图片不拉伸，而是将图片复制多个，盖满rect
    //矩形裁剪区域：超过当前范围的图片都会被裁剪掉
    //UIRectClip(CGRectMake(0, 0, 100, 100));
    //[image drawAsPatternInRect:rect];
    
    //在当前rect范围内创建一个矩形
    [[UIColor yellowColor] set];
    UIRectFill(rect);
}

@end
