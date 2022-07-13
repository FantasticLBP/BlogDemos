//
//  TestViewController.m
//  完美自定义键盘顶部 View
//
//  Created by 杭城小刘 on 7/13/22.
//  Copyright © 2022 杭城小刘. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = self.msg;
    
    UILabel *label = [[UILabel alloc] initWithFrame:self.view.frame];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = self.msg;
    label.font = [UIFont systemFontOfSize:30];
    label.textColor = [UIColor brownColor];
    [self.view addSubview:label];
}




@end
