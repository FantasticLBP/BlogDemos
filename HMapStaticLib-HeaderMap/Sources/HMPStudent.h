//
//  Student.h
//  HMapStaticFramework
//
//  Created by Unix_Kernel on 7/2/25.
//  Copyright © 2025 杭城小刘. All rights reserved.
//

#import "HMPPerson.h"

NS_ASSUME_NONNULL_BEGIN

@interface HMPStudent : HMPPerson

@property (nonatomic, copy, readonly) NSString *name;

- (instancetype)initWithName:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
