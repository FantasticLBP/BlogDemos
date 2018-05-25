//
//  ViewController.m
//  图标抖动动画（关键帧动画）
//
//  Created by 杭城小刘 on 2018/1/11.
//  Copyright © 2018年 杭城小刘. All rights reserved.
//

#import "ViewController.h"

#define angle2Rad(angle) ((angle *M_PI)/180 )


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    /*
     
     //系统删除App图标抖动动画
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.rotation.z";
    animation.duration = 0.2;
    animation.fromValue = @(angle2Rad(5));
    animation.toValue = @(angle2Rad(-5));
    animation.repeatCount = HUGE_VALF;
    animation.autoreverses = YES;
    [self.imageView.layer addAnimation:animation forKey:nil];
   */
    
    /*
    //方法二：Values方法
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    
    animation.keyPath = @"transform.rotation.z";
     
    animation.values = @[@(angle2Rad(-5)),@(angle2Rad(5)),@(angle2Rad(-5))];
 
    animation.repeatCount = HUGE_VALF;

    animation.duration = 0.5;
    [self.imageView.layer addAnimation:animation forKey:nil];
     */
    
    
    /*
    //方法三
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    
    animation.keyPath = @"transform.rotation.z";

    animation.values = @[@(angle2Rad(-5)),@(angle2Rad(5))];
    animation.autoreverses = YES;
    animation.repeatCount = HUGE_VALF;
    
    animation.duration = 0.5;
    [self.imageView.layer addAnimation:animation forKey:nil];
    */
    
    
    
    //方法二：path方法
     /*
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position";

    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(50, 50)];
    [path addLineToPoint:CGPointMake(300, 300)];
    
    animation.path = path.CGPath;
    animation.duration = 1;
    animation.repeatCount = HUGE_VALF;
    animation.autoreverses = YES;
    
    [self.imageView.layer addAnimation:animation forKey:nil];
      */
    
    
   
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position";
    
    animation.values = @[[NSValue valueWithCGPoint:CGPointMake(50, 100)],
                         [NSValue valueWithCGPoint:CGPointMake(300, 100)],
                         [NSValue valueWithCGPoint:CGPointMake(300, 300)],
                         [NSValue valueWithCGPoint:CGPointMake(50, 300)],
                         [NSValue valueWithCGPoint:CGPointMake(50, 100)]];
    animation.duration = 1;
    animation.repeatCount = HUGE_VALF;

    
    [self.imageView.layer addAnimation:animation forKey:nil];

    
    
    
}

@end
