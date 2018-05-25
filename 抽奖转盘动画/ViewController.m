//
//  ViewController.m
//  抽奖转盘动画
//
//  Created by 杭城小刘 on 2018/1/13.
//  Copyright © 2018年 杭城小刘. All rights reserved.
//

#import "ViewController.h"
#import "WheelView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *yellowView;

@property (weak, nonatomic) IBOutlet UIButton *startButton;

@property (weak, nonatomic) IBOutlet UIButton *pauseButton;

@property (nonatomic, strong) WheelView *wheelView;

@end

@implementation ViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    
    [self.startButton addTarget:self action:@selector(startRotate) forControlEvents:UIControlEventTouchUpInside];
    
    [self.pauseButton addTarget:self action:@selector(stopRotate) forControlEvents:UIControlEventTouchUpInside];
    
    
    WheelView *view = [WheelView wheelView];
    view.center = self.view.center;
    self.wheelView = view;
    [self.view addSubview:view];
}


-(void)startRotate{
    
    [self.wheelView startRotate];
}

-(void)stopRotate{
    [self.wheelView pauseRotate];
}



@end
