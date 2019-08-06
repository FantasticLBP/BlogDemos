//
//  AppDelegate.h
//  HotFix
//
//  Created by 杭城小刘 on 7/2/19.
//  Copyright © 2019 @杭城小刘. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Aspects.h"
#import <objc/runtime.h>
#import <JavaScriptCore/JavaScriptCore.h>

NS_ASSUME_NONNULL_BEGIN

@interface FixManager : NSObject

+ (FixManager *)sharedInstance;
+ (void)fixIt;
+ (void)evalString:(NSString *)javascriptString;

@end

NS_ASSUME_NONNULL_END
