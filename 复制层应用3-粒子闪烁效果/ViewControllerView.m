//
//  ViewControllerView.m
//  复制层应用3-粒子闪烁效果
//
//  Created by 刘斌鹏 on 2018/6/6.
//  Copyright © 2018年 杭城小刘. All rights reserved.
//

#import "ViewControllerView.h"

@interface ViewControllerView()

@property (nonatomic, strong) UIBezierPath *path;
@property (nonatomic, weak) CALayer *dotLayer;
@end

@implementation ViewControllerView

+ (Class)layerClass{
    return [CAReplicatorLayer class];
}

- (void)awakeFromNib{
    [super awakeFromNib];
    
    UIPanGestureRecognizer *tapGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(draw:)];
    [self addGestureRecognizer:tapGesture];
    self.path = [UIBezierPath bezierPath];
    
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(-UIScreen.mainScreen.bounds.size.width, 0, 15, 15);
    layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:192/255.0 blue:203/255.0 alpha:1].CGColor;
    layer.cornerRadius = 7.5;
    self.dotLayer = layer;
    [self.layer addSublayer:layer];
    
    CAReplicatorLayer *replicatorLayer = (CAReplicatorLayer *)self.layer;
    replicatorLayer.instanceCount = 20;
    replicatorLayer.instanceDelay = 0.25;
}


- (void)draw:(UIPanGestureRecognizer *)tap{
    CGPoint currentPoint = [tap locationInView:self];
    if (tap.state == UIGestureRecognizerStateBegan) {
        [self.path moveToPoint:currentPoint];
    }
    else if(tap.state == UIGestureRecognizerStateChanged){
        [self.path addLineToPoint:currentPoint];
        [self setNeedsDisplay];
    }
}

- (void)startAnimation{
    //要实现动画围绕着给定的形状执行，那么需要关键帧动画(类比于Flash概念中的关键帧动画，只需要给定指定的关键帧，其余的帧系统会创建出来。)。关键帧动画的 path 和 values 是互斥的，也就是说如果设置了 values 还设置了 path 那么 path 属性会覆盖 values 属性。
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position";
    animation.path = self.path.CGPath;
    animation.duration = 5;
    animation.repeatCount = MAXFLOAT;
    [self.dotLayer addAnimation:animation forKey:nil];
}

- (void)redraw{
    //清空路径：移除 path 上面所有的点，然后重绘
    [self.path removeAllPoints];
    [self setNeedsDisplay];
    //移除动画
    [self.dotLayer removeAllAnimations];
}

- (void)drawRect:(CGRect)rect{
    [self.path stroke];
}

@end
