//
//  ZombieProxy.h
//  DDD
//
//  Created by LBP on 5/14/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZombieProxy : NSProxy

@property (nonatomic, assign) Class originClass;

@end

NS_ASSUME_NONNULL_END
