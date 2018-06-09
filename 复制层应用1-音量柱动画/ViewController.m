//
//  ViewController.m
//  UI动画
//
//  Created by 刘斌鹏 on 2018/6/5.
//  Copyright © 2018年 杭城小刘. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (nonatomic, strong) CAReplicatorLayer *replicatorrLayer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self musicVolumnAnimation];
}

//音乐播放柱状动画
- (void)musicVolumnAnimation{
    //创建复制层，因为我们做的多个音量柱变化的动画都是一样的，所以创建了一个复制层，这个复制层可以对里面的 sublayer 进行复制，所以我们不需要重复创建了
    
    CAReplicatorLayer *replicatorrLayer = [CAReplicatorLayer layer];
    replicatorrLayer.frame = CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height);
    replicatorrLayer.backgroundColor = [UIColor blackColor].CGColor;
    self.replicatorrLayer = replicatorrLayer;
    [self.contentView.layer addSublayer:replicatorrLayer];
    
    
    //创建音量震动条
    CALayer *layer = [CALayer layer];
    layer.backgroundColor = [UIColor whiteColor].CGColor;
    CGFloat width = 30;
    CGFloat height = 100;
    layer.bounds = CGRectMake(0, self.contentView.frame.size.height - height, width, height);
    layer.anchorPoint = CGPointMake(0, 1);
    layer.position = CGPointMake(0, self.contentView.frame.size.height);
    [self.contentView.layer addSublayer:layer];
    
    //创建音量震动动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale.y"];
    animation.toValue = @0;
    animation.duration = 1;
    animation.repeatCount = MAXFLOAT;
    animation.autoreverses = YES;
    [layer addAnimation:animation forKey:nil];
    
    
    [replicatorrLayer addSublayer:layer];
    
    //* The number of copies to create, including the source object.
    replicatorrLayer.instanceCount = 6; //复制 sublayer 的个数，包括创建的第一个sublayer 在内的个数
    replicatorrLayer.instanceDelay = 0.4; //设置动画延迟执行的时间
    replicatorrLayer.instanceAlphaOffset = -0.15;   //设置透明度递减
    replicatorrLayer.instanceTransform = CATransform3DMakeTranslation(50, 0, 0);
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.replicatorrLayer.frame = self.contentView.bounds;
}



@end
