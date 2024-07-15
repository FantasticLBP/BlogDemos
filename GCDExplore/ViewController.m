//
//  ViewController.m
//  GCDExplore
//
//  Created by Unix_Kernel on 7/12/24.
//  Copyright © 2024 杭城小刘. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self testDeadLock];
//    [self testBloakAndQueue];
    // dead lock
    // dispatch_sync(dispatch_get_main_queue(), nil);
}


- (void)testDeadLock {
    dispatch_queue_t queue  = dispatch_queue_create("test", DISPATCH_QUEUE_SERIAL);
    NSLog(@"1");
    dispatch_async(queue, ^{
        dispatch_sync(queue, ^{
            NSLog(@"3");
        });
    });
    NSLog(@"5");

}

// 美团面试题
- (void)testBloakAndQueue {
    __block int a = 0;
    while (a < 5) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            a++;
            NSLog(@"task --- a:%d", a);
        });
    }
    NSLog(@"%d", a);
}

@end
