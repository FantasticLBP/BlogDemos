//
//  ViewController.m
//  无用类检测
//
//  Created by 杭城小刘 on 7/5/22.
//  Copyright © 2022 杭城小刘. All rights reserved.
//

#import "ViewController.h"
#import <objc/message.h>
#import "Person.h"
#import "Dog.h"

#define FAST_DATA_MASK  0x00007ffffffffff8UL
#define RW_INITIALIZED  (1<<29)

@interface ViewController ()

@end

@implementation ViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    Person *person = [[Person alloc] init];
    [person work];
//    Dog *dog = [[Dog alloc] init];
//    [dog work];
    NSLog(@"%@", [self isUsedViaClassName:@"Person"] ? @"使用了person类" : @"没有使用Person类");
    NSLog(@"%@", [self isUsedViaClassName:@"Dog"] ? @"使用了Dog类" : @"没有使用Dog类");
}


#pragma mark - private method
- (BOOL)isUsedViaClassName:(NSString *)clsassName
{
    Class metaCls = objc_getMetaClass(clsassName.UTF8String);
    if (metaCls) {
        uint64_t *bits = (__bridge void *)metaCls + 32;
        uint32_t *data = (uint32_t *)(*bits & FAST_DATA_MASK);
        if ((*data & RW_INITIALIZED) > 0) {
            return YES;
        }
    }
    return NO;
}

@end
