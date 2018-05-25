//
//  ViewController.m
//  图像折叠动画
//
//  Created by 杭城小刘 on 2018/1/22.
//  Copyright © 2018年 杭城小刘. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *topImageView;

@property (weak, nonatomic) IBOutlet UIImageView *bottomImageView;

@property (weak, nonatomic) IBOutlet UIView *drawView;
@end

@implementation ViewController


-(void)viewDidLoad{
    [super viewDidLoad];
    
    //让图片只显示上半部分。
    
    self.topImageView.layer.contentsRect = CGRectMake(0, 0, 1, 0.5);
    self.bottomImageView.layer.contentsRect = CGRectMake(0, 0.5, 1, 0.5);
    self.topImageView.layer.anchorPoint = CGPointMake(0.5, 1);
    self.bottomImageView.layer.anchorPoint = CGPointMake(0.5, 0);
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panIamge:)];
    [self.drawView addGestureRecognizer:panGesture];
}

-(void)panIamge:(UIPanGestureRecognizer *)gesture{
    
    
    CGPoint offset =  [gesture translationInView:self.drawView];
    
    CGFloat angle = offset.y / self.drawView.frame.size.height;
    
    
    CATransform3D transform = CATransform3DIdentity;
    
    transform.m34 = -1/10;
    
    self.topImageView.layer.transform = CATransform3DRotate(transform, -angle*M_PI, 1, 0, 0);
    
    
}



@end
