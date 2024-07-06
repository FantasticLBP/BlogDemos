//
//  GenerateOrderFileUtils.h
//  BinarayOrderExplore
//
//  Created by Unix_Kernel on 7/7/24.
//  Copyright © 2024 杭城小刘. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GenerateOrderFileUtils : NSObject

+ (void)generateOrderFiles:(void(^)(NSString *filePath))completionHandler;

@end

NS_ASSUME_NONNULL_END
