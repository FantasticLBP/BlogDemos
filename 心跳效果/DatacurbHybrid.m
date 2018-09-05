//
//  DatacurbHybrid.m
//  心跳效果
//
//  Created by 刘斌鹏 on 2018/8/23.
//  Copyright © 2018年 杭城小刘. All rights reserved.
//

#import "DatacurbHybrid.h"

@implementation DatacurbHybrid


- (NSString *)heartBreaker{
    [self.viewcontroller heartJump];
    return @"美滋滋";
}

- (void)stopHeart{
    [self.viewcontroller stopHeart];
}

@end
