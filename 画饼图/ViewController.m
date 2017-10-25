//
//  ViewController.m
//  画饼图
//
//  Created by 杭城小刘 on 2017/10/15.
//  Copyright © 2017年 杭城小刘. All rights reserved.
//

#import "ViewController.h"
#import "PieView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet PieView *pieView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pieView.pies = [NSArray arrayWithObjects:@(20),@(30),@(50), nil];
}



@end
