//
//  ViewController.m
//  UIKit画图-画文字
//
//  Created by 杭城小刘 on 2017/10/17.
//  Copyright © 2017年 杭城小刘. All rights reserved.
//

#import "ViewController.h"
#import "WordView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet WordView *wordView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.wordView.word = @"杭城小刘";
}





@end
