
//
//  MuneItem.m
//  微博发帖动画
//
//  Created by 刘斌鹏 on 2018/6/10.
//  Copyright © 2018年 杭城小刘. All rights reserved.
//

#import "MuneItem.h"

@implementation MuneItem

+ (instancetype)itemWithTitle:(NSString *)title image:(UIImage *)image{
    
    MuneItem *item = [[self alloc] init];
    item.title = title;
    item.image = image;
    
    return item;
}

@end
