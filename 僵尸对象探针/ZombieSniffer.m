//
//  ZombieSniffer.m
//  DDD
//
//  Created by LBP on 5/14/22.
//

#import "ZombieSniffer.h"
#import <objc/runtime.h>
#import "ZombieProxy.h"

typedef void (*MIDeallocPointer) (id objc);
//野指针探测器是否开启
static BOOL _enabled = NO;
//根类
static NSArray *_rootClasses = nil;
//用于存储被释放的对象
static NSDictionary<id, NSValue*> *_rootClassDeallocImps = nil;

//白名单
static inline NSMutableSet *__mi_sniffer_white_lists()
{
    //创建白名单集合
    static NSMutableSet *mi_sniffer_white_lists;
    //单例初始化白名单集合
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mi_sniffer_white_lists = [[NSMutableSet alloc] init];
    });
    return mi_sniffer_white_lists;
}

static inline void __mi_dealloc(__unsafe_unretained id obj)
{
    //获取对象的类
    Class currentCls = [obj class];
    Class rootCls = currentCls;

    //获取非NSObject和NSProxy的类
    while (rootCls != [NSObject class] && rootCls != [NSProxy class]) {
        //获取rootCls的父类，并赋值
        rootCls = class_getSuperclass(rootCls);
    }
    //获取类名
    NSString *clsName = NSStringFromClass(rootCls);
    //根据类名获取dealloc的imp指针
    MIDeallocPointer deallocImp = NULL;
    [[_rootClassDeallocImps objectForKey:clsName] getValue:&deallocImp];

    if (deallocImp != NULL) {
        deallocImp(obj);
    }
}

static inline IMP __mi_swizzleMethodWithBlock(Method method, void *block)
{
    IMP blockImp = imp_implementationWithBlock((__bridge id _Nonnull)(block));
    return method_setImplementation(method, blockImp);
}

@implementation ZombieSniffer


+ (void)initialize
{
    _rootClasses = [@[[NSObject class], [NSProxy class]] retain];
}

#pragma mark - public
+ (void)installSniffer
{
    @synchronized (self) {
        if (!_enabled) {
            [self _swizzleDealloc];
            _enabled = YES;
        }
    }
}

+ (void)uninstallSnifier
{
    @synchronized (self) {
        if (_enabled) {
            [self _unswizzleDealloc];
            _enabled = NO;
        }
    }
}

+ (void)appendIgnoreClass:(Class)cls
{
    @synchronized (self) {
        NSMutableSet *whiteList = __mi_sniffer_white_lists();
        NSString *clsName = NSStringFromClass(cls);
        [clsName retain];
        [whiteList addObject:clsName];
    }
}

#pragma mark - private
+ (void)_swizzleDealloc
{
    static void *swizzledDeallocBlock = NULL;
    //定义block，作为方法的IMP
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        swizzledDeallocBlock = (__bridge void *)[^void(id obj) {
            //获取对象的类
            Class currentClass = [obj class];
            //获取类名
            NSString *clsName = NSStringFromClass(currentClass);
            //判断该类是否在白名单类
            if ([__mi_sniffer_white_lists() containsObject: clsName]) {
                //如果在白名单内，则直接释放对象
                __mi_dealloc(obj);
            } else {
                NSValue *objVal = [NSValue valueWithBytes: &obj objCType: @encode(typeof(obj))];
                //为obj设置指定的类
                object_setClass(obj, [ZombieProxy class]);
                //保留对象原本的类
                ((ZombieProxy *)obj).originClass = currentClass;

                //设置在30s后调用dealloc将存储的对象释放，避免内存空间的增大
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(30 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    __unsafe_unretained id deallocObj = nil;
                    //获取需要dealloc的对象
                    [objVal getValue: &deallocObj];
                    //设置对象的类为原本的类
                    object_setClass(deallocObj, currentClass);
                    //释放
                    __mi_dealloc(deallocObj);
                });
            }
        } copy];
    });

    //交换了根类NSObject和NSProxy的dealloc方法为originalDeallocImp
    NSMutableDictionary *deallocImps = [NSMutableDictionary dictionary];
    //遍历根类
    for (Class rootClass in _rootClasses) {
        //获取指定类中dealloc方法
        Method oriMethod = class_getInstanceMethod([rootClass class], NSSelectorFromString(@"dealloc"));
        //hook - 交换dealloc方法的IMP实现
        IMP originalDeallocImp = __mi_swizzleMethodWithBlock(oriMethod, swizzledDeallocBlock);
        //设置IMP的具体实现
        [deallocImps setObject: [NSValue valueWithBytes: &originalDeallocImp objCType: @encode(typeof(IMP))] forKey: NSStringFromClass(rootClass)];
    }
    //_rootClassDeallocImps字典存储交换后的IMP实现
    _rootClassDeallocImps = [deallocImps copy];
}

+ (void)_unswizzleDealloc
{
    //还原dealloc交换的IMP
    [_rootClasses enumerateObjectsUsingBlock:^(Class rootClass, NSUInteger idx, BOOL * _Nonnull stop) {
        IMP originDeallocImp = NULL;
        //获取根类类名
        NSString *clsName = NSStringFromClass(rootClass);
        //获取hook后的dealloc实现
        [[_rootClassDeallocImps objectForKey:clsName] getValue:&originDeallocImp];

        NSParameterAssert(originDeallocImp);
        //获取原本的dealloc实现
        Method oriMethod = class_getInstanceMethod([rootClass class], NSSelectorFromString(@"dealloc"));
        //还原dealloc的实现
        method_setImplementation(oriMethod, originDeallocImp);
    }];
    //释放
    [_rootClassDeallocImps release];
    _rootClassDeallocImps = nil;
}

@end
