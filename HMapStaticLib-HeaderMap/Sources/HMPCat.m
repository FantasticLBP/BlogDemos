//
//  Cat.m
//  HMapStaticLib
//
//  Created by Unix_Kernel on 6/29/25.
//  Copyright © 2025 杭城小刘. All rights reserved.
//

#import "HMPCat.h"

@interface HMPCat()
@property (nonatomic, copy) NSString *name;
@end

@implementation HMPCat

- (instancetype)initWithName:(NSString *)name {
    if (self = [super init]) {
        _name = name;
    }
    return self;
}

@end
