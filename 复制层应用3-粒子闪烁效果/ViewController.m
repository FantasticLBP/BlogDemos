//
//  ViewController.m
//  复制层应用3-粒子闪烁效果
//
//  Created by 刘斌鹏 on 2018/6/6.
//  Copyright © 2018年 杭城小刘. All rights reserved.
//

#import "ViewController.h"
#import "ViewControllerView.h"


@interface ViewController ()

@property (strong, nonatomic) IBOutlet ViewControllerView *backview;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (IBAction)clickLoginButton:(id)sender {
}



- (IBAction)clickStartAnimation:(id)sender {
    [self.backview startAnimation];
}

- (IBAction)clickRedraw:(id)sender {
    [self.backview redraw];
}





@end
