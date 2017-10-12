//
//  ShelterView.m
//  hitTest的神奇效果（一）
//
//  Created by 杭城小刘 on 2017/10/12.
//  Copyright © 2017年 杭城小刘. All rights reserved.
//

#import "ShelterView.h"

@implementation ShelterView

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"%s",__func__);
}

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    NSLog(@"%s",__func__);
    /**
     需求：不管点击按钮还是view都交给button处理
    思路：在view的hitTest方法中寻找最合适的view，那么返回nil告诉系统view不是最合适的view，那么系统则认为按钮是最合适的view
    return nil;
     */
    
    //需求，在view上点击，如果点击范围在button上则由button进行处理事件；否则交给view处理事件
    
    UIView *button = nil;
    for (UIView *subView in self.superview.subviews) {
        //判断事件的点是否在按钮上
        if ([subView isKindOfClass:[UIButton class]]) {
            button =subView;
        }
        
        
        CGPoint btnPoint = [self convertPoint:point toView:button];
        if ([button pointInside:btnPoint withEvent:event]) {
            return button;
        }else{
            //此时代表事件触摸点不在button上，但是也不能写nil，写nil的话点击屏幕上的其他地方系统会寻找最合适的view，此时返回nil（ return nil;），则代表view不是最合适的view,那么此时点击屏幕上除了按钮之外的区域，最合适的view就是控制器上面的view
            return [super hitTest:point withEvent:event];
        }
    }
    return nil;
}

@end
