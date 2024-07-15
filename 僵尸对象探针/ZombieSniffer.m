//
//  ZombieSniffer.m
//  DDD
//
//  Created by LBP on 5/14/22.
//

#import "ZombieSniffer.h"
#import <objc/runtime.h>
#import "ZombieProxy.h"

typedef void (*FLDeallocPointer) (id objc);
//野指针探测器是否开启
static BOOL _enabled = NO;
//根类
static NSArray *_rootClasses = nil;
//用于存储被释放的对象
static NSDictionary<id, NSValue*> *_rootClassDeallocImps = nil;

//白名单
static inline NSMutableSet *__fl_sniffer_white_lists() {
    static NSMutableSet *fl_sniffer_white_lists;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        fl_sniffer_white_lists = [[NSMutableSet alloc] init];
    });
    return fl_sniffer_white_lists;
}

static inline void __fl_dealloc(__unsafe_unretained id obj) {
    //获取对象的类
    Class currentCls = [obj class];
    Class rootCls = currentCls;

    //获取 非NSObject 和 NSProxy 的类
    while (rootCls != [NSObject class] && rootCls != [NSProxy class]) {
        // 获取 rootCls 的父类，并赋值
        rootCls = class_getSuperclass(rootCls);
    }
    // 获取类名
    NSString *clsName = NSStringFromClass(rootCls);
    // 根据类名获取 dealloc 的 imp 指针
    FLDeallocPointer deallocImp = NULL;
    [[_rootClassDeallocImps objectForKey:clsName] getValue:&deallocImp];

    if (deallocImp != NULL) {
        deallocImp(obj);
    }
}

static inline IMP __fl_swizzleMethodWithBlock(Method method, void *block) {
    IMP blockImp = imp_implementationWithBlock((__bridge id _Nonnull)(block));
    return method_setImplementation(method, blockImp);
}

@implementation ZombieSniffer

#pragma mark - life cycle
+ (void)initialize {
    _rootClasses = [@[[NSObject class], [NSProxy class]] retain];
}

#pragma mark - public
+ (void)installSniffer {
    @synchronized (self) {
        if (!_enabled) {
            [self _swizzleDealloc];
            _enabled = YES;
        }
    }
}

+ (void)uninstallSnifier {
    @synchronized (self) {
        if (_enabled) {
            [self _unswizzleDealloc];
            _enabled = NO;
        }
    }
}

+ (void)appendIgnoreClass:(Class)cls {
    @synchronized (self) {
        NSMutableSet *whiteList = __fl_sniffer_white_lists();
        NSString *clsName = NSStringFromClass(cls);
        [clsName retain];
        [whiteList addObject:clsName];
    }
}

#pragma mark - private
+ (void)_swizzleDealloc {
    static void *swizzledDeallocBlock = NULL;
    // 定义block，作为方法的IMP
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        swizzledDeallocBlock = (__bridge void *)[^void(id obj) {
            // 获取对象的类
            Class currentClass = [obj class];
            // 获取类名
            NSString *clsName = NSStringFromClass(currentClass);
            // 判断该类是否在白名单类
            if ([__fl_sniffer_white_lists() containsObject:clsName]) {
                // 如果在白名单内，则直接释放对象
                __fl_dealloc(obj);
            } else {
                NSValue *objVal = [NSValue valueWithBytes:&obj objCType:@encode(typeof(obj))];
                // 为 obj 修改 isa 为 ZombieProxy。为的是可以响应各种调用方法
                object_setClass(obj, [ZombieProxy class]);
                // 保留对象原本的类
                ((ZombieProxy *)obj).originClass = currentClass;

                // 设置在30s后调用 dealloc 将存储的对象释放，避免内存空间的增大导致 OOM
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(30 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    __unsafe_unretained id deallocObj = nil;
                    // 获取需要dealloc的对象
                    [objVal getValue:&deallocObj];
                    // 设置对象的类为原本的类
                    object_setClass(deallocObj, currentClass);
                    // 释放
                    __fl_dealloc(deallocObj);
                });
            }
        } copy];
    });

    // 交换了根类 NSObject 和 NSProxy 的 dealloc 方法为 originalDeallocImp
    NSMutableDictionary *deallocImps = [NSMutableDictionary dictionary];
    // 遍历根类
    for (Class rootClass in _rootClasses) {
        // 获取指定类中 dealloc 方法
        Method oriMethod = class_getInstanceMethod([rootClass class], NSSelectorFromString(@"dealloc"));
        // hook - 交换 dealloc 方法的 IMP 实现
        IMP originalDeallocImp = __fl_swizzleMethodWithBlock(oriMethod, swizzledDeallocBlock);
        // 设置 IMP 的具体实现
        [deallocImps setObject:[NSValue valueWithBytes:&originalDeallocImp objCType:@encode(typeof(IMP))] forKey:NSStringFromClass(rootClass)];
    }
    // _rootClassDeallocImps 字典存储交换后的 IMP 实现
    _rootClassDeallocImps = [deallocImps copy];
}

+ (void)_unswizzleDealloc {
    // 还原 dealloc 交换的 IMP
    [_rootClasses enumerateObjectsUsingBlock:^(Class rootClass, NSUInteger idx, BOOL * _Nonnull stop) {
        IMP originDeallocImp = NULL;
        // 获取根类类名
        NSString *clsName = NSStringFromClass(rootClass);
        // 获取 hook 后的 dealloc 实现
        [[_rootClassDeallocImps objectForKey:clsName] getValue:&originDeallocImp];

        NSParameterAssert(originDeallocImp);
        // 获取原本的dealloc实现
        Method oriMethod = class_getInstanceMethod([rootClass class], NSSelectorFromString(@"dealloc"));
        // 还原dealloc的实现
        method_setImplementation(oriMethod, originDeallocImp);
    }];
    // 释放
    [_rootClassDeallocImps release];
    _rootClassDeallocImps = nil;
}

@end
