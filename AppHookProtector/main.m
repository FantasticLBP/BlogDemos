//
//  main.m
//  AppHookProtector
//
//  Created by Unix_Kernel on 7/14/24.
//  Copyright © 2024 杭城小刘. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <AppHook/AppHook.h>
#import <dlfcn.h>

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {

#ifndef DEBUG
        // 非 DEBUG 模式下禁止调试
//        disable_gdb_via_ptrace();
//        disable_gdb_via_sysctl();
//        disable_gdb_via_hidden_ptrace();
//        disable_gdb_via_hidden_sysctl();
        anti_debug();
#endif
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
