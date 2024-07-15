//
//  InjectCode.m
//  AppHook
//
//  Created by Unix_Kernel on 7/14/24.
//  Copyright © 2024 杭城小刘. All rights reserved.
//

#import "InjectCode.h"
#import "fishhook.h"
#import "HookProtector.h"
#import <sys/sysctl.h>

// ptrace 函数指针，保存原始 ptrace 函数地址
int (*ptrace_pointer)(int _request, pid_t _pid, caddr_t _addr, int _data);
// sysctl 函数指针，保存原始 sysctl 函数地址
int (*sysctl_pointer)(int *, u_int, void *, size_t *, void *, size_t);

@implementation InjectCode

// hooked ptrac
/*
 arg1: ptrace 要做的事情
 arg2: 进程 ID，0代表当前进程
 arg3：（地址）
 arg4：（数据），取决于第一个参数
 */
// 如果使用 debugServer 则闪退，正常使用不受影响
int hooked_ptrace(int _request, pid_t _pid, caddr_t _addr, int _data) {
    if (_request == PT_DENY_ATTACH) {
        return 0;
    }
    return ptrace_pointer(_request, _pid, _addr, _data);
}

int hooked_sysctl(int *name, u_int namelen, void *info, size_t *infosize, void *newInfo, size_t newInfoSize) {
    int resultCode = sysctl_pointer(name, namelen, info, infosize, newInfo, newInfoSize);
    if (namelen == 4 && name[0] == CTL_KERN && name[1] == KERN_PROC && name[2] == KERN_PROC_PID && info) {
        struct kinfo_proc *myInfo = (struct kinfo_proc *)info;
        if (myInfo->kp_proc.p_flag & P_TRACED) {
            // 抑或取反。设置调试判断位为0.
            myInfo->kp_proc.p_flag ^= P_TRACED;
        }
        return resultCode;
    }
    return resultCode;
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        struct rebinding ptraceSt;
        ptraceSt.name = PTRACESYMBOL;
        ptraceSt.replacement = hooked_ptrace;   // hook 之后的函数地址
        ptraceSt.replaced = (void *)&ptrace_pointer;    // 保存原始函数地址
        
        struct rebinding sysctlSt;
        sysctlSt.name = SYSCTLSYMBOL;
        sysctlSt.replacement = hooked_sysctl;
        sysctlSt.replaced = (void *)&sysctl_pointer;
        
        struct rebinding bindings[] = { ptraceSt, sysctlSt };
        // fishhook 替换
        rebind_symbols(bindings, 2);
    });
}

@end
