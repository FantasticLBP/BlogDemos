//
//  WheelView.h
//  抽奖转盘动画
//
//  Created by 杭城小刘 on 2018/1/15.
//  Copyright © 2018年 杭城小刘. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WheelView : UIView


+(instancetype)wheelView;

-(void)startRotate;

-(void)pauseRotate;

@end
