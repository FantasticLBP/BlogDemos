//
//  ViewController.m
//  约束布局
//
//  Created by 刘斌鹏 on 2018/6/27.
//  Copyright © 2018年 杭城小刘. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"布局约束";
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIView *superview = self.view;
    
    UIView *view1 = [[UIView alloc] init];
    view1.translatesAutoresizingMaskIntoConstraints = NO;
    view1.backgroundColor = [UIColor greenColor];
    [superview addSubview:view1];

    
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    [superview addConstraints:@[
                                [NSLayoutConstraint constraintWithItem:view1 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:superview attribute:NSLayoutAttributeLeft multiplier:1 constant:edgeInsets.left],
                                [NSLayoutConstraint constraintWithItem:view1 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:superview attribute:NSLayoutAttributeTop multiplier:1 constant:edgeInsets.top],
                                [NSLayoutConstraint constraintWithItem:view1 attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:superview attribute:NSLayoutAttributeBottom multiplier:1 constant:-edgeInsets.bottom],
                                [NSLayoutConstraint constraintWithItem:view1 attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:superview attribute:NSLayoutAttributeRight multiplier:1 constant:-edgeInsets.right]
                                ]];
    
}





@end
