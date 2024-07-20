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
    [self testDispatchGroup];
}

- (void)testDispatchGroup {
    // D - A,B
    dispatch_queue_t group1 = dispatch_group_create();
    // E - B,C
    dispatch_queue_t group2 = dispatch_group_create();
    // F - D,E
    dispatch_queue_t group3 = dispatch_group_create();
    
    dispatch_group_enter(group1);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"A Task");
        }
        dispatch_group_leave(group1);
    });
    
    dispatch_group_enter(group1);
    dispatch_group_enter(group2);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"B Task");
        }
        dispatch_group_leave(group1);
        dispatch_group_enter(group2);
    });
    
    dispatch_group_enter(group2);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"C Task");
        }
        dispatch_group_leave(group2);
    });
    
    dispatch_group_enter(group3);
    dispatch_group_notify(group1, dispatch_get_global_queue(0, 0), ^{
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            for (int i = 0; i < 3; i++) {
                NSLog(@"D Task");
            }
            dispatch_group_leave(group3);
        });
    });
    
    dispatch_group_enter(group3);
    dispatch_group_notify(group2, dispatch_get_global_queue(0, 0), ^{
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            for (int i = 0; i < 3; i++) {
                NSLog(@"E Task");
            }
            dispatch_group_leave(group3);
        });
    });
    
    dispatch_group_notify(group3, dispatch_get_global_queue(0, 0), ^{
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            for (int i = 0; i < 3; i++) {
                NSLog(@"F Task");
            }
        });
    });
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
