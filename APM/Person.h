//
//  Person.h
//  APM
//
//  Created by Unix_Kernel on 6/30/24.
//  Copyright © 2024 杭城小刘. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Cat.h"
NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject

@property (nonatomic, strong) Cat *cat;

@end

NS_ASSUME_NONNULL_END
