
//
//  ViewControllerView.m
//  复制层应用2
//
//  Created by 刘斌鹏 on 2018/6/5.
//  Copyright © 2018年 杭城小刘. All rights reserved.
//

#import "ViewControllerView.h"

@implementation ViewControllerView

//该方法返回 UIView 的层
//改写 UIView 的层：重写 layerClass 方法
+ (Class)layerClass{
    return [CAReplicatorLayer class];
}

@end
