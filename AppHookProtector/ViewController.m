//
//  ViewController.m
//  AppHookProtector
//
//  Created by Unix_Kernel on 7/14/24.
//  Copyright © 2024 杭城小刘. All rights reserved.
//

#import "ViewController.h"
#import <sys/sysctl.h>

@interface ViewController ()

@end

@implementation ViewController

static dispatch_source_t timer;

- (void)viewDidLoad {
    [super viewDidLoad];
    
//#ifndef DEBUG
//    timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));
//    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
//    dispatch_source_set_event_handler(timer, ^{
//        if (isInDebugMode()) {
//            NSLog(@"在调试模式");
//            exit(0);
//        } else {
//            NSLog(@"不在调试模式");
//        }
//    });
//    dispatch_resume(timer);
//#endif
}

//bool isInDebugMode(void) {
//    int name[4];
//    name[0] = CTL_KERN;     // 内核
//    name[1] = KERN_PROC;    // 查询进程
//    name[2] = KERN_PROC_PID;    // 通过进程 id 来查找
//    name[3] = getpid();
//
//    struct kinfo_proc info; // 接收查询信息，利用结构体传递引用
//    size_t infoSize = sizeof(info);
//    int resultCode = sysctl(name, sizeof(name)/sizeof(*name), &info, &infoSize, 0, 0);
//    assert(resultCode == 0);
//    return info.kp_proc.p_flag & P_TRACED;
//}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%s", __func__);
}

@end
