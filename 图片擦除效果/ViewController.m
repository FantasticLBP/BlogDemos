//
//  ViewController.m
//  图片擦除效果
//
//  Created by 杭城小刘 on 2017/10/26.
//  Copyright © 2017年 杭城小刘. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureChange:)];
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:panGesture];
}


-(void)panGestureChange:(UIPanGestureRecognizer *)pan{
    
    //图片区域擦除效果
    
    //1、获取手势所在的点
    CGPoint position = [pan locationInView:self.imageView];
    //2、开启图片上下文，确定上下文所在的rect
    CGFloat rectWH = 44;
    CGRect rect = CGRectMake(position.x - rectWH/2, position.y - rectWH/2, rectWH, rectWH);
    UIGraphicsBeginImageContextWithOptions(self.imageView.bounds.size, NO, 0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();

    
    //3、将图片绘制到上下文中
    [self.imageView.layer renderInContext:ctx];
    
    //4、将手势所在的区域裁剪掉
    CGContextClearRect(ctx, rect);
    //5、从当前上下文中得到图片
    UIImage *imageGot = UIGraphicsGetImageFromCurrentImageContext();
    //6、将新的图片显示出来
    self.imageView.image = imageGot;
    //7、关闭上下文
    UIGraphicsEndImageContext();
}


@end
