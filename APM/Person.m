//
//  Person.m
//  APM
//
//  Created by Unix_Kernel on 6/30/24.
//  Copyright © 2024 杭城小刘. All rights reserved.
//

#import "Person.h"

@implementation Person


- (void)sayHi {
    NSString *str = [[NSString alloc] init];
    str = @"Hello world";
    NSLog(@"%@", str);
}

@end
