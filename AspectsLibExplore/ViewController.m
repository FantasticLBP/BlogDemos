//
//  ViewController.m
//  AspectsLibExplore
//
//  Created by Unix_Kernel on 7/8/24.
//  Copyright © 2024 杭城小刘. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController


typedef NS_OPTIONS(int, AspectBlockFlags) {
    AspectBlockFlagsHasCopyDisposeHelpers = (1 << 25),
    AspectBlockFlagsHasSignature = (1 << 30)
};

typedef struct AspectBlock {
    __unused Class isa;
    AspectBlockFlags Flags;
    __unused int Reserved;
    void (__unused *invoke)(struct AspectBlock *block, ...);

    struct {
        size_t reserved;
        size_t Block_size;
        void (*copy)(void *dst, const void *src);
        void (*dispose)(const void *);
    } *descriptor;
} *AspectBlockRef;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    void(^printBlock)(NSString *) = ^void(NSString *msg) {
        NSLog(@"%@", msg);
    };
    printBlock(@"Hello world");
    
    struct AspectBlock *fakeBlock = (__bridge struct AspectBlock *)printBlock;
    ((void (*)(void *, NSString *))fakeBlock->invoke)(fakeBlock, @"Hello world");
    
    
    
}


@end
