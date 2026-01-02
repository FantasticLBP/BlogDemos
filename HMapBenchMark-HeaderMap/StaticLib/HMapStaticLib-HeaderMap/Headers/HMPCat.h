//
//  Cat.h
//  HMapStaticLib
//
//  Created by Unix_Kernel on 6/29/25.
//  Copyright © 2025 杭城小刘. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HMPCat : NSObject

@property (nonatomic, copy, readonly) NSString *name;

- (instancetype)initWithName:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
