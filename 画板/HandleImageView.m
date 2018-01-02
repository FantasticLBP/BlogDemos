//
//  HandleImageView.m
//  画板
//
//  Created by 杭城小刘 on 2018/1/2.
//  Copyright © 2018年 杭城小刘. All rights reserved.
//

#import "HandleImageView.h"

@interface HandleImageView()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation HandleImageView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}


-(void)setupUI{
    [self addSubview:self.imageView];
    
    
    
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.imageView addGestureRecognizer:panGesture];
    
    
    UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
    [self.imageView addGestureRecognizer:pinchGesture];
    
    
    
    UIRotationGestureRecognizer *rotationGesture = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotate:)];
    [self.imageView addGestureRecognizer:rotationGesture];
    
   

    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    [self.imageView addGestureRecognizer:longPress];

    
}


#pragma mark -- response method

-(void)rotate:(UIRotationGestureRecognizer *)gesture{
    
    gesture.view.transform = CGAffineTransformRotate(gesture.view.transform, gesture.rotation);
    // 复位,只要想相对于上一次旋转就复位;
    gesture.rotation = 0;
}

-(void)pan:(UIPanGestureRecognizer *)gesture{
    
    CGPoint transP = [gesture translationInView:gesture.view];
    gesture.view.transform = CGAffineTransformTranslate(gesture.view.transform, transP.x, transP.y);
    
    [gesture setTranslation:CGPointZero inView:gesture.view];
}

-(void)pinch:(UIPinchGestureRecognizer *)gesture{
    
    gesture.view.transform = CGAffineTransformScale(gesture.view.transform, gesture.scale, gesture.scale);
    gesture.scale = 1;
    
}

-(void)longPress:(UILongPressGestureRecognizer *)gesture{
    
    if (gesture.state == UIGestureRecognizerStateBegan) {
        [UIView animateWithDuration:0.25 animations:^{
            self.imageView.alpha = 0;
        } completion:^(BOOL finished) {
            self.imageView.alpha = 1;
            
            UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0);
            CGContextRef ctx = UIGraphicsGetCurrentContext();
            
            [self.layer renderInContext:ctx];
            
            UIImage *imageGot = UIGraphicsGetImageFromCurrentImageContext();
            
            UIGraphicsEndImageContext();
            
            [self.imageView removeFromSuperview];
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(handleImageView:didOperatedImage:)]) {
                [self.delegate handleImageView:self didOperatedImage:imageGot];
            }
            
        }];
    }
}

#pragma mark -- setter

-(void)setImage:(UIImage *)image{
    self.imageView.image = image;
}

#pragma mark -- lazy load

-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:self.frame];
        _imageView.userInteractionEnabled = YES;
    }
    return _imageView;
}

@end
