//
//  AppDelegate.h
//  HotFix
//
//  Created by 杭城小刘 on 7/11/19.
//  Copyright © 2019 @杭城小刘. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BugProtector : NSObject

+ (instancetype)sharedInstance;

+ (void)getFixScript:(NSString *)scriptText;

@end

NS_ASSUME_NONNULL_END
