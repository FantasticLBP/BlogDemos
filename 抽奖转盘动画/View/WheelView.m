//
//  WheelView.m
//  抽奖转盘动画
//
//  Created by 杭城小刘 on 2018/1/15.
//  Copyright © 2018年 杭城小刘. All rights reserved.
//

#import "WheelView.h"
#import "WheelButton.h"
#import <UIKit/UIKit.h>

#define Angle2Rad(angle) ((angle*M_PI)/180)

@interface WheelView()<CAAnimationDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

@property (nonatomic, strong) UIButton *prevSelButton;

@property (nonatomic, strong) CADisplayLink *displayLink;


@end

@implementation WheelView

+(instancetype)wheelView{
    
    return [[NSBundle mainBundle] loadNibNamed:@"WheelView" owner:nil options:nil].lastObject;
}



- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self = [[NSBundle mainBundle] loadNibNamed:@"WheelView" owner:nil options:nil].lastObject;
    }
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    [self setupUI];
}

#pragma mark -- CAAnimationDelegate

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
    //拿到当前选中按钮的旋转角度
    CGAffineTransform transform = self.prevSelButton.transform;
    CGFloat angle = atan2f(transform.b, transform.a);
    //让contentV倒着旋转回去
    self.backgroundImageView.transform = CGAffineTransformMakeRotation(-angle);
}

#pragma mark -- private method

-(void)setupUI{
    
    self.backgroundImageView.userInteractionEnabled = YES;
    
    CGFloat angleDel = 360/12;
    
    UIImage *contentImage = [UIImage imageNamed:@"LuckyAstrology"];
    UIImage *contentSelectedImage = [UIImage imageNamed:@"LuckyAstrologyPressed"];
    
    
    CGFloat scale = [UIScreen mainScreen].scale;
    
    CGFloat buttonImageOriginX = 0;
    CGFloat buttonImageOriginY = 0;
    CGFloat buttonImageWidth = scale * contentImage.size.width/12;
    CGFloat buttonImageHeight = scale * contentImage.size.height;
    
    
    
    for (int i = 0; i< 12; i++) {
        
        WheelButton *button = [WheelButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundImage:[UIImage imageNamed:@"LuckyRototeSelected"] forState:UIControlStateSelected];
        //Button的大小
        button.bounds = CGRectMake(0, 0, 66, 143);

        //button的位置
        button.layer.anchorPoint = CGPointMake(0.5, 1);
        button.layer.position = CGPointMake(self.backgroundImageView.frame.size.width*0.5, self.backgroundImageView.frame.size.height*0.5);
        //旋转button来确定位置
        button.transform = CGAffineTransformMakeRotation(Angle2Rad(i*angleDel));
        
        [button addTarget:self action:@selector(clickButtn:) forControlEvents:UIControlEventTouchUpInside];
        
        buttonImageOriginX = i*buttonImageWidth;
        //裁剪区域
        CGRect contentImageRect = CGRectMake(buttonImageOriginX, buttonImageOriginY, buttonImageWidth, buttonImageHeight);
        
        //裁剪图片
        CGImageRef contentImageRef = CGImageCreateWithImageInRect(contentImage.CGImage, contentImageRect);
        CGImageRef contentSelectedImageRef = CGImageCreateWithImageInRect(contentSelectedImage.CGImage, contentImageRect);
        
        [button setImage:[UIImage imageWithCGImage:contentImageRef] forState:UIControlStateNormal];
        [button setImage:[UIImage imageWithCGImage:contentSelectedImageRef] forState:UIControlStateSelected];
        
        [self.backgroundImageView addSubview:button];
        
        if (i == 0) {
            [self clickButtn:button];
        }
    }
    
}


- (IBAction)clickStart:(id)sender {
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.rotation";
    animation.toValue = @(4*M_PI);
    animation.duration = 2;
    animation.delegate = self;
    [self.backgroundImageView.layer addAnimation:animation forKey:nil];
    
}

-(void)clickButtn:(UIButton *)button{
    self.prevSelButton.selected = NO;
    button.selected = YES;
    self.prevSelButton = button;
}

-(void)update{
    self.backgroundImageView.transform = CGAffineTransformRotate(self.backgroundImageView.transform, M_PI/200);
    
}

#pragma mark -- public method

-(void)startRotate{
    self.displayLink.paused = NO;
}

-(void)pauseRotate{
    self.displayLink.paused = YES;
}


#pragma mark -- lazy load

-(CADisplayLink *)displayLink{
    if (!_displayLink) {
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(update)];
        [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    }
    return _displayLink;
}



@end
