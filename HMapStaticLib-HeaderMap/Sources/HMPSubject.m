//
//  Student.m
//  HMapStaticFramework
//
//  Created by Unix_Kernel on 7/2/25.
//  Copyright © 2025 杭城小刘. All rights reserved.
//

#import "HMPSubject.h"

@interface HMPSubject ()
@property (nonatomic, copy) NSString *name;
@end

@implementation HMPSubject

- (instancetype)initWithName:(NSString *)name {
    if (self = [super init]) {
        _name = name;
    }
    return self;
}

@end
