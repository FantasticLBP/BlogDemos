
//
//  RedView.m
//  主流App框架
//
//  Created by 杭城小刘 on 2017/10/11.
//  Copyright © 2017年 杭城小刘. All rights reserved.
//

#import "RedView.h"

@implementation RedView


-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //改变redView的frame即可，具体来说就是改变坐标x、y
    //x和y的话也就是找出当前坐标和上次坐标的不同
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self];
    CGPoint previousPoint = [touch previousLocationInView:self];
    self.transform = CGAffineTransformTranslate(self.transform, currentPoint.x - previousPoint.x, currentPoint.y - previousPoint.y);
}

@end
