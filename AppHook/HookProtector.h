//
//  HookProtector.h
//  AppHookProtector
//
//  Created by Unix_Kernel on 7/14/24.
//  Copyright © 2024 杭城小刘. All rights reserved.
//

#ifndef HookProtector_h
#define HookProtector_h

#include <sys/appleapiopts.h>
#include <sys/cdefs.h>
#import <dlfcn.h>
#import <sys/sysctl.h>

enum {
    ePtAttachDeprecated __deprecated_enum_msg("PT_ATTACH is deprecated. See PT_ATTACHEXC") = 10
};

#define PTRACESYMBOL "ptrace"
#define SYSCTLSYMBOL "sysctl"
#define KEY 0xAC


#define    PT_TRACE_ME  0    /* child declares it's being traced */
#define    PT_READ_I    1    /* read word in child's I space */
#define    PT_READ_D    2    /* read word in child's D space */
#define    PT_READ_U    3    /* read word in child's user structure */
#define    PT_WRITE_I   4    /* write word in child's I space */
#define    PT_WRITE_D   5    /* write word in child's D space */
#define    PT_WRITE_U   6    /* write word in child's user structure */
#define    PT_CONTINUE  7    /* continue the child */
#define    PT_KILL      8    /* kill the child process */
#define    PT_STEP      9    /* single step the child */
#define    PT_ATTACH    ePtAttachDeprecated    /* trace some running process */
#define    PT_DETACH    11    /* stop tracing a process */
#define    PT_SIGEXC    12    /* signals as exceptions for current_proc */
#define    PT_THUPDATE  13    /* signal for thread# */
#define    PT_ATTACHEXC 4    /* attach to running process with signal exception */
#define    PT_FORCEQUOTA    30    /* Enforce quota for root */
#define    PT_DENY_ATTACH   31
#define    PT_FIRSTMACH     32    /* for machine-specific requests */

__BEGIN_DECLS
    int   ptrace(int _request, pid_t _pid, caddr_t _addr, int _data);
__END_DECLS

typedef int (*ptrace_ptr_t)(int _request, pid_t _pid, caddr_t _addr, int _data);
typedef int (*sysctl_ptr_t)(int *name, u_int namelen, void *info, size_t *infosize, void *newInfo, size_t newInfoSize);

static __attribute__((always_inline)) void quit_process () {
#ifdef __arm64__
    asm(
        "mov x0,#0\n"
        "mov x16,#1\n" //这里相当于 Sys_exit,调用exit函数
        "svc #0x80\n"
    );
    return;
#endif
#ifdef __arm__
    asm(
        "mov r0,#0\n"
        "mov r16,#1\n" //这里相当于 Sys_exit
        "svc #80\n"
    );
    return;
#endif
    exit(0);
}

bool isInDebugMode(void) {
    int name[4];
    name[0] = CTL_KERN;     // 内核
    name[1] = KERN_PROC;    // 查询进程
    name[2] = KERN_PROC_PID;    // 通过进程 ID 来查找
    name[3] = getpid();     // 当前进程 ID
    
    struct kinfo_proc info; // 接收查询信息，利用结构体传递引用
    size_t infoSize = sizeof(info);
    void *handle = dlopen(0, RTLD_GLOBAL | RTLD_NOW);
    sysctl_ptr_t sysctl_ptr = dlsym(handle, SYSCTLSYMBOL);
    
    sysctl_ptr(name, sizeof(name)/sizeof(*name), &info, &infoSize, 0, 0);
    dlclose(handle);
    return info.kp_proc.p_flag & P_TRACED;
}

void disable_gdb_via_ptrace(void) {
    // 简易版：容易被 FishHook 进行符号表的修改，从而破解 ptrace 的拦截
    // ptrace(PT_DENY_ATTACH, 0, 0, 0);
    
    // ptrace 安全版本
    void *handle = dlopen(0, RTLD_GLOBAL | RTLD_NOW);
    ptrace_ptr_t ptrace_ptr = dlsym(handle, PTRACESYMBOL);
    ptrace_ptr(PT_DENY_ATTACH, 0, 0, 0);
    dlclose(handle);
}

void disable_gdb_via_sysctl(void) {
    static dispatch_source_t timer;
    timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        if (isInDebugMode()) {
            NSLog(@"在调试模式");
            quit_process();
        } else {
            NSLog(@"不在调试模式");
        }
    });
    dispatch_resume(timer);
}

void disable_gdb_via_hidden_ptrace(void) {
    unsigned char funcName[] = {
        (KEY ^ 'p'),
        (KEY ^ 't'),
        (KEY ^ 'r'),
        (KEY ^ 'a'),
        (KEY ^ 'c'),
        (KEY ^ 'e'),
        (KEY ^ '\0'),
    };
    unsigned char * p = funcName;
    // 再次异或之后恢复原本的值
    while (((*p) ^= KEY) != '\0') p++;
    
    void *handle = dlopen(0, RTLD_GLOBAL | RTLD_NOW);
    ptrace_ptr_t ptrace_ptr = dlsym(handle, (const char *)funcName);
    if (ptrace_ptr) {
        ptrace_ptr(PT_DENY_ATTACH, 0, 0, 0);
    }
    dlclose(handle);
}

bool isInDebugModeViaHiddenSysctl(void) {
    unsigned char funcName[] = {
        (KEY ^ 's'),
        (KEY ^ 'y'),
        (KEY ^ 's'),
        (KEY ^ 'c'),
        (KEY ^ 't'),
        (KEY ^ 'l'),
        (KEY ^ '\0'),
    };
    unsigned char * p = funcName;
    //再次异或之后恢复原本的值
    while (((*p) ^= KEY) != '\0') p++;
    
    int name[4];
    name[0] = CTL_KERN;     // 内核
    name[1] = KERN_PROC;    // 查询进程
    name[2] = KERN_PROC_PID;    // 通过进程 ID 来查找
    name[3] = getpid();     // 当前进程 ID
    
    struct kinfo_proc info; // 接收查询信息，利用结构体传递引用
    size_t infoSize = sizeof(info);
    void *handle = dlopen(0, RTLD_GLOBAL | RTLD_NOW);
    sysctl_ptr_t sysctl_ptr = dlsym(handle, (const char *)funcName);
    
    sysctl_ptr(name, sizeof(name)/sizeof(*name), &info, &infoSize, 0, 0);
    dlclose(handle);
    return info.kp_proc.p_flag & P_TRACED;
}

void disable_gdb_via_hidden_sysctl(void) {
    static dispatch_source_t timer;
    timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        if (isInDebugModeViaHiddenSysctl()) {
            NSLog(@"在调试模式");
            quit_process();
        } else {
            NSLog(@"不在调试模式");
        }
    });
    dispatch_resume(timer);
}

static __attribute__((always_inline)) void anti_debug() {
#ifdef __arm64__
    __asm__("mov X0, #31\n"
            "mov X1, #0\n"
            "mov X2, #0\n"
            "mov X3, #0\n"
            "mov w16, #26\n"
            "svc #0x80");
#else
    disable_gdb_via_ptrace();
#endif
}

#endif /* HookProtector_h */
