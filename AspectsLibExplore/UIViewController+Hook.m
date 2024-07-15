//
//  UIViewController+Hook.m
//  AspectsLibExplore
//
//  Created by Unix_Kernel on 7/8/24.
//  Copyright © 2024 杭城小刘. All rights reserved.
//

#import "UIViewController+Hook.h"
#import "Aspects.h"


@implementation UIViewController (Hook)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [UIViewController aspect_hookSelector:@selector(viewWillAppear:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> info) {
            UIViewController *vc = (UIViewController *)info.instance;
            vc.view.backgroundColor = [UIColor systemPinkColor];
        } error:nil];
    });
    
}

@end
