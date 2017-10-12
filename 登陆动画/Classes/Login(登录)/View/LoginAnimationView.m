//
//  LoginAnimationView.m
//  博文对应的小实验
//
//  Created by 杭城小刘 on 2017/9/10.
//  Copyright © 2017年 杭城小刘. All rights reserved.
//

#import "LoginAnimationView.h"

@interface LoginAnimationView()

@property (weak, nonatomic) IBOutlet UIImageView *leftArm;
@property (weak, nonatomic) IBOutlet UIImageView *rightArm;
@property (weak, nonatomic) IBOutlet UIImageView *leftHand;
@property (weak, nonatomic) IBOutlet UIImageView *rightHand;


@property (nonatomic, assign) CGFloat leftOffsetX;
@property (nonatomic, assign) CGFloat rightOffsetX;
@property (nonatomic, assign) CGFloat offsetY;

@end

@implementation LoginAnimationView

+(instancetype)loginAnimationView{
    return [[NSBundle mainBundle] loadNibNamed:@"LoginAnimationView" owner:nil options:nil][0];
}

-(void)awakeFromNib{
    [super awakeFromNib];
    _leftOffsetX = -self.leftArm.frame.origin.x;
    _rightOffsetX =  self.rightHand.frame.origin.x -self.rightArm.frame.origin.x-50;
    _offsetY = self.bounds.size.height -  self.leftArm.frame.origin.y - 12;
    
    
    self.leftArm.transform = CGAffineTransformMakeTranslation(_leftOffsetX, _offsetY);
    self.rightArm.transform = CGAffineTransformMakeTranslation(_rightOffsetX, _offsetY);
}

-(void)startAnimation:(BOOL)isClose{
    if (isClose) {
        [UIView animateWithDuration:0.5 animations:^{
            self.leftArm.transform = CGAffineTransformIdentity;
            self.rightArm.transform = CGAffineTransformIdentity;
            
            self.leftHand.transform = CGAffineTransformMakeTranslation(-self.leftOffsetX + 5, -self.offsetY);
            self.leftHand.transform = CGAffineTransformScale(self.leftHand.transform, 0.5, 0.5);
            
            self.rightHand.transform = CGAffineTransformMakeTranslation(-self.rightOffsetX + 5, -self.offsetY);
            self.rightHand.transform = CGAffineTransformScale(self.rightHand.transform, 0.5, 0.5);
        }];
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            self.leftArm.transform = CGAffineTransformMakeTranslation(_leftOffsetX, _offsetY);
            self.rightArm.transform = CGAffineTransformMakeTranslation(_rightOffsetX, _offsetY);
            
            self.leftHand.transform = CGAffineTransformIdentity;
            self.rightHand.transform = CGAffineTransformIdentity;
        }];
    }
    
    
}

-(void)stopAnimation{
    
    
}

@end
