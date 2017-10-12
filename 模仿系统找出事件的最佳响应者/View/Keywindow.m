//
//  Keywindow.m
//  主流App框架
//
//  Created by 杭城小刘 on 2017/10/11.
//  Copyright © 2017年 杭城小刘. All rights reserved.
//

#import "Keywindow.h"
#import "ViewController.h"

@implementation Keywindow

/**
 模仿系统实现寻找最合适的view步骤
 1、控件接收事件
 2、触摸点在自己身上
 3、从后往前遍历子控件，重复前面2个步骤
 4、如果没有符合条件的子控件，那么就自己最合适
 */

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    NSLog(@"%s",__func__);
    if (self.userInteractionEnabled == NO || self.hidden == YES || self.alpha <= 0.01) {
        return nil;
    }

    if (![self pointInside:point withEvent:event]) {
        return nil;
    }
    
    for (NSUInteger index = self.subviews.count - 1; index >= 0; index--) {
        CGPoint childViewPoint = [self convertPoint:point toView:self.subviews[index]];
        UIView *fitestView = [self.subviews[index] hitTest:childViewPoint withEvent:event];
        if (fitestView) {
            return fitestView;
        }
        return nil;
    }
    
    return self;
}



@end
