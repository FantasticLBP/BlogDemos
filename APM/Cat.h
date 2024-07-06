//
//  Cat.h
//  APM
//
//  Created by Unix_Kernel on 7/1/24.
//  Copyright © 2024 杭城小刘. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Person;

NS_ASSUME_NONNULL_BEGIN

@interface Cat : NSObject

@property (nonatomic, strong) Person *hoster;

@end

NS_ASSUME_NONNULL_END
