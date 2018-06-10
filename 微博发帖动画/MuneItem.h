//
//  MuneItem.h
//  微博发帖动画
//
//  Created by 刘斌鹏 on 2018/6/10.
//  Copyright © 2018年 杭城小刘. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface MuneItem : NSObject

//图片
@property (nonatomic, strong) UIImage *image;
//标题
@property (nonatomic, strong) NSString *title;


+ (instancetype)itemWithTitle:(NSString *)title image:(UIImage *)image;


@end
