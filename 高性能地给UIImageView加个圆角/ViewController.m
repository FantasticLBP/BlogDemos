//
//  ViewController.m
//  高性能地给UIImageView加个圆角
//
//  Created by 杭城小刘 on 2017/9/5.
//  Copyright © 2017年 杭城小刘. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIImageView *imageview;

@end

@implementation ViewController

#pragma mark -- lice cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.imageview];
    
    
   /*
    //方式1：设置图片圆角
    
    self.imageview.image = [UIImage imageNamed:@"test"];
    self.imageview.layer.cornerRadius =  32;
    self.imageview.layer.masksToBounds = YES;
    */
    
    //方式2:通过贝塞尔曲线设置图片圆角
    
    UIGraphicsBeginImageContextWithOptions(self.imageview.bounds.size, NO, 1.0);
    
    [[UIBezierPath bezierPathWithRoundedRect:self.imageview.bounds cornerRadius:32] addClip];
    
    UIImage *image = [UIImage imageNamed:@"test"];
    
    [image drawInRect:self.imageview.bounds];
    
    self.imageview.image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
}


#pragma mark -- lazy load

-(UIImageView *)imageview{
    if (!_imageview) {
        _imageview = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2 - 64/2, self.view.bounds.size.height / 2 - 64/2, 64, 64)];
    }
    return _imageview;
}

@end
