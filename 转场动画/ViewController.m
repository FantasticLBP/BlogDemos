//
//  ViewController.m
//  转场动画
//
//  Created by 杭城小刘 on 2018/1/12.
//  Copyright © 2018年 杭城小刘. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

static int _i = 1;

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    //方法1：CA 的转场动画
    _i++;
    if (_i > 3) {
        _i = 1;
    }
    NSString *imageName = [NSString stringWithFormat:@"%d",_i];
    self.imageView.image = [UIImage imageNamed:imageName];
    
    CATransition *animation = [CATransition animation];
    animation.type = @"pageCurl";
    animation.subtype = kCATransitionFromTop;
    animation.duration = 1.5;
    animation.startProgress = 0.2;
    animation.endProgress = 0.5;
    [self.imageView.layer addAnimation:animation forKey:nil];
    
    //方法2:UIView 的转场动画
    [UIView transitionWithView:self.imageView duration:1 options:UIViewAnimationOptionTransitionCurlUp animations:^{
        _i++;
        if (_i > 3) {
            _i = 1;
        }
    } completion:^(BOOL finished) {
        
    }];
}

@end
