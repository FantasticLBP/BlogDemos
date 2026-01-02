//
//  ViewController.m
//  BinarayOrderExplore
//
//  Created by Unix_Kernel on 7/6/24.
//  Copyright © 2024 杭城小刘. All rights reserved.
//

#import "ViewController.h"
#import "Student.h"

@interface ViewController ()
@property (nonatomic, strong) Student *st;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.st = [[Student alloc] init];
    
}


@end
