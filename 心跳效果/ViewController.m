//
//  ViewController.m
//  心跳效果
//
//  Created by 杭城小刘 on 2018/1/10.
//  Copyright © 2018年 杭城小刘. All rights reserved.
//

#import "ViewController.h"
#import "UIViewController+HUD.h"
#import "AppDelegate.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

-(void)viewDidLoad{
    [super viewDidLoad];
  
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.toValue = @0.2;
    animation.keyPath = @"transform.scale";
    animation.repeatCount = HUGE_VALF;
    animation.duration = 0.5;
    animation.autoreverses = YES;
    [self.imageView.layer addAnimation:animation forKey:nil];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self showHint:@"💗章超杞小可爱，我喜欢你💗"];
    });
}


@end
