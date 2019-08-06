//
//  ViewController.m
//  动画组
//
//  Created by 杭城小刘 on 2018/1/13.
//  Copyright © 2018年 杭城小刘. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *animationView;

@end

@implementation ViewController

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
    //方法1:
    CABasicAnimation *scaleAnimation = [CABasicAnimation animation];
    scaleAnimation.keyPath = @"transform.scale";
    scaleAnimation.toValue = @0.4;
    
    scaleAnimation.fillMode = kCAFillModeForwards;
    scaleAnimation.removedOnCompletion = NO;
    
    [self.animationView.layer addAnimation:scaleAnimation forKey:nil];
    
    
    CABasicAnimation *positionAnimation = [CABasicAnimation animation];
    positionAnimation.keyPath = @"position.y";
    positionAnimation.toValue = @500;
    
     //下面2行代码让动画停留在动画结束的位置
    positionAnimation.fillMode = kCAFillModeForwards;
    positionAnimation.removedOnCompletion = NO;
    
    [self.animationView.layer addAnimation:positionAnimation forKey:nil];
     
    
    
    //方法2
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    
    CABasicAnimation *positionAnimation = [CABasicAnimation animation];
    positionAnimation.keyPath = @"position.y";
    positionAnimation.toValue = @500;
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animation];
    scaleAnimation.keyPath = @"transform.scale";
    scaleAnimation.toValue = @0.5;
    
    //设置动画组
    animationGroup.animations = @[positionAnimation,scaleAnimation];
    //集中设置动画状态属性
    animationGroup.fillMode = kCAFillModeForwards;
    animationGroup.removedOnCompletion = NO;
    
    [self.animationView.layer addAnimation:animationGroup forKey:nil];
    
    
}


@end
