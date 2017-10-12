//
//  BaseView.m
//  主流App框架
//
//  Created by 杭城小刘 on 2017/10/11.
//  Copyright © 2017年 杭城小刘. All rights reserved.
//

#import "BaseView.h"

@implementation BaseView

// __func__ 打印的是当前方法在哪个类里面调用
//为了显示谁在调用，那么打印当前类即可
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"%@",[self class]);
}



@end
