//
//  UIButton+propertyTest.m
//  博文对应的小实验
//
//  Created by 杭城小刘 on 2017/9/5.
//  Copyright © 2017年 杭城小刘. All rights reserved.
//

#import "UIButton+propertyTest.h"
#import <objc/runtime.h>

static const  char Name;

@implementation UIButton (propertyTest)

-(void)setName:(NSString *)name{
    objc_setAssociatedObject(self, &Name, name, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(NSString *)name{
    return objc_getAssociatedObject(self, &Name);
}

@end
