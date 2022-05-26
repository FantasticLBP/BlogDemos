//
//  ZombieProxy.m
//  DDD
//
//  Created by LBP on 5/14/22.
//

#import "ZombieProxy.h"
#define MockZombieObjectsDetector [self mockSystemBehaviorOfZombieObjects: _cmd]

@implementation ZombieProxy

- (BOOL)respondsToSelector: (SEL)aSelector
{
    return [self.originClass instancesRespondToSelector:aSelector];
}

- (NSMethodSignature *)methodSignatureForSelector: (SEL)sel
{
    return [self.originClass instanceMethodSignatureForSelector:sel];
}

- (void)forwardInvocation: (NSInvocation *)invocation
{
    [self mockSystemBehaviorOfZombieObjects:invocation.selector];
}


- (Class)class
{
    MockZombieObjectsDetector;
    return nil;
}

- (BOOL)isEqual:(id)object
{
    MockZombieObjectsDetector;
    return NO;
}

- (NSUInteger)hash
{
    MockZombieObjectsDetector;
    return 0;
}

- (id)self
{
    MockZombieObjectsDetector;
    return nil;
}

- (BOOL)isKindOfClass:(Class)aClass
{
    MockZombieObjectsDetector;
    return NO;
}

- (BOOL)isMemberOfClass:(Class)aClass
{
    MockZombieObjectsDetector;
    return NO;
}

- (BOOL)conformsToProtocol:(Protocol *)aProtocol
{
    MockZombieObjectsDetector;
    return NO;
}

- (BOOL)isProxy
{
    MockZombieObjectsDetector;
    return NO;
}

- (void)dealloc
{
    MockZombieObjectsDetector;
    [super dealloc];
}

- (NSZone *)zone
{
    MockZombieObjectsDetector;
    return nil;
}

- (NSString *)description
{
    MockZombieObjectsDetector;
    return nil;
}


#pragma mark - Private
- (void)mockSystemBehaviorOfZombieObjects:(SEL)selector
{
    NSString *msg = [NSString stringWithFormat:@"(-[%@ %@]) was sent to a zombie object at address: %p", NSStringFromClass(self.originClass), NSStringFromSelector(selector), self];
    NSLog(@"%@", msg);
    NSLog(@"堆栈：\n%@",[NSThread callStackSymbols]);
    abort();
}

@end
