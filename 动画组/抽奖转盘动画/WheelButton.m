//
//  WheelButton.m
//  抽奖转盘动画
//
//  Created by 杭城小刘 on 2018/1/15.
//  Copyright © 2018年 杭城小刘. All rights reserved.
//

#import "WheelButton.h"

@implementation WheelButton


//该方法用于调整Button的ImageView的位置
//contentRect 为该按钮的frame
-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat originX = 0;
    CGFloat originY = 20;
    CGFloat width = 40;
    CGFloat height = 50;
    
    originX = (contentRect.size.width - width)/2;

    return CGRectMake(originX, originY, width, height);
}

@end
