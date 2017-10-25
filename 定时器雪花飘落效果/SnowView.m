
//
//  SnowView.m
//  定时器雪花飘落效果
//
//  Created by 杭城小刘 on 2017/10/17.
//  Copyright © 2017年 杭城小刘. All rights reserved.
//

#import "SnowView.h"

@implementation SnowView

-(void)awakeFromNib{
    [super awakeFromNib];
    
    //创建CADisplayLink 就是当屏幕每次一刷新就调用 屏幕是60fps，也就是每秒钟刷新一次，因此每一秒钟调用一次update，但是此时update调用内部setNeedsDisplay，此时不用等到系统刷新屏幕再去调用drawRect方法，因为CADisplayLink创建出调用就是屏幕刷新一次调用一次
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(update)];
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    
}

static int snowY = 0;


-(void)update{
    snowY += 10;
    if (snowY > self.bounds.size.height) {
        snowY = 0;
    }
    //调用setNeedsDisplay方法后并不是马上调用drawRect方法，而是等到下次屏幕刷新的时候调用
    [self setNeedsDisplay];
}

-(void)drawRect:(CGRect)rect{
    UIImage *image = [UIImage imageNamed:@"snow"];
    [image drawAtPoint:CGPointMake(0, snowY)] ;
    
}

@end
