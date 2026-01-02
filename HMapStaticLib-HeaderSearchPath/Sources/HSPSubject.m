//
//  Student.m
//  HMapStaticFramework
//
//  Created by Unix_Kernel on 7/2/25.
//  Copyright © 2025 杭城小刘. All rights reserved.
//

#import "HSPSubject.h"

@interface HSPSubject ()
@property (nonatomic, copy) NSString *name;
@end

@implementation HSPSubject

- (instancetype)initWithName:(NSString *)name {
    if (self = [super init]) {
        _name = name;
    }
    return self;
}

@end
