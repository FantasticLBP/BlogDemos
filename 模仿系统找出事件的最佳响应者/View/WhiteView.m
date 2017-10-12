//
//  WhiteView.m
//  主流App框架
//
//  Created by 杭城小刘 on 2017/10/11.
//  Copyright © 2017年 杭城小刘. All rights reserved.
//

#import "WhiteView.h"

@implementation WhiteView

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    NSLog(@"%s",__func__);
    return [super hitTest:point withEvent:event];
}


@end
