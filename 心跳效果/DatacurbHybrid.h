//
//  DatacurbHybrid.h
//  心跳效果
//
//  Created by 刘斌鹏 on 2018/8/23.
//  Copyright © 2018年 杭城小刘. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import "ViewController.h"

@protocol DatacurbHybridInjectExport<JSExport>

@property (nonatomic, strong) ViewController *viewcontroller;
@property (nonatomic, strong) NSString *message;

- (NSString *)heartBreaker;
- (void)stopHeart;


@end



@interface DatacurbHybrid : NSObject<DatacurbHybridInjectExport>
@property (nonatomic, strong) ViewController *viewcontroller;
@property (nonatomic, strong) NSString *message;


- (void)stopHeart;
- (NSString *)heartBreaker;

@end
