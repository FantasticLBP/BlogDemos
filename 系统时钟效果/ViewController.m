//
//  ViewController.m
//  系统时钟效果
//
//  Created by 杭城小刘 on 2018/1/8.
//  Copyright © 2018年 杭城小刘. All rights reserved.
//

#import "ViewController.h"


#define Angle_Per_Second 6
#define Angle_Per_Minute 6
#define Angle_Per_Hour 30

//每一分钟、时针旋转的度数
#define Hour_Angle_Per_Minute 0.5

#define Angle2Rad(angle) (angle*M_PI/180)


@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *clockView;

@property (nonatomic, strong) CALayer *secondLayer;

@property (nonatomic, strong) CALayer *minuteLayer;

@property (nonatomic, strong) CALayer *hourLayer;

@end

@implementation ViewController

/*
 模拟系统实现时钟效果。
 1、因为指针不用进行事件交互，所以可以CALayer实现
 2、需要绕着表盘中心（position）旋转，所以可以将指针的 AnchorPoint 设置好
 3、让指针旋转-》添加 NSTimer
 4、旋转多少度 ：当前秒数 * 每秒钟旋转的度数。转换成弧度
 5、获取日历
 5、layer层的动画 layer.CATrnsform3DMakeRotation(Angle,0,0,1)
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addHourView];
    [self addMinuteView];
    
    [self addSecondView];
    [self timeChange];
    [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
}


-(void)timeChange{
    
    NSCalendar *calender = [NSCalendar currentCalendar];
    
    NSDateComponents *cmp = [calender components:NSCalendarUnitSecond | NSCalendarUnitMinute | NSCalendarUnitHour fromDate:[NSDate date]];
    //获取当前多少秒
    NSInteger second = cmp.second;
    //获取当前多少分
    NSInteger minute = cmp.minute;
    //获取当前多少小时
    NSInteger hour = cmp.hour;
    
    CGFloat secondAngle = second * Angle_Per_Second;
    CGFloat minuteAngle = minute * Angle_Per_Minute;
    CGFloat hourAngle = hour * Angle_Per_Hour + hour * Hour_Angle_Per_Minute;
    
    
    self.secondLayer.transform = CATransform3DMakeRotation(Angle2Rad(secondAngle), 0, 0, 1);
    
    self.minuteLayer.transform = CATransform3DMakeRotation(Angle2Rad(minuteAngle), 0, 0, 1);
    
    self.hourLayer.transform = CATransform3DMakeRotation(Angle2Rad(hourAngle), 0, 0, 1);
}


-(void)addSecondView{
    
    CALayer *layer = [CALayer layer];
    layer.backgroundColor = [UIColor redColor].CGColor;
    
    layer.bounds = CGRectMake(0, 0, 3, 80);
    layer.position = CGPointMake(self.clockView.bounds.size.width/2,  self.clockView.bounds.size.height/2);
    layer.anchorPoint = CGPointMake(0.5, 1);
    self.secondLayer = layer;
    [self.clockView.layer addSublayer:layer];
}


-(void)addMinuteView{
    CALayer *layer = [CALayer layer];
    layer.backgroundColor = [UIColor blackColor].CGColor;
    
    layer.bounds = CGRectMake(0, 0, 1, 60);
    layer.position = CGPointMake(self.clockView.bounds.size.width/2, self.clockView.bounds.size.height/2);
    layer.anchorPoint = CGPointMake(0.5, 1);
    self.minuteLayer = layer;
    [self.clockView.layer addSublayer:layer];
}

-(void)addHourView{
    CALayer *layer = [CALayer layer];
    layer.backgroundColor = [UIColor blackColor].CGColor;
    
    layer.bounds = CGRectMake(0, 0, 1, 50);
    layer.position = CGPointMake(self.clockView.bounds.size.width/2, self.clockView.bounds.size.height/2);
    layer.anchorPoint = CGPointMake(0.5, 1);
    self.hourLayer = layer;
    [self.clockView.layer addSublayer:layer];
}




@end
