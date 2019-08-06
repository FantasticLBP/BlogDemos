//
//  AppDelegate.h
//  HotFix
//
//  Created by 杭城小刘 on 7/11/19.
//  Copyright © 2019 @杭城小刘. All rights reserved.
//

#import "BugProtector.h"
#import "FixManager.h"

@interface BugProtector ()

@end

@implementation BugProtector

static BugProtector *_sharedInstance = nil;

#pragma mark - life cycle
+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //because has rewrited allocWithZone  use NULL avoid endless loop lol.
        _sharedInstance = [[super allocWithZone:NULL] init];
        [FixManager fixIt];
    });
    
    return _sharedInstance;
}

+ (FixManager *)fixManager
{
    static FixManager *_manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [FixManager sharedInstance];
    });
    return _manager;
}

+ (id)allocWithZone:(struct _NSZone *)zone
{
    return [BugProtector sharedInstance];
}

+ (instancetype)alloc
{
    return [BugProtector sharedInstance];
}

- (id)copy
{
    return self;
}

- (id)mutableCopy
{
    return self;
}

- (id)copyWithZone:(struct _NSZone *)zone
{
    return self;
}

#ifdef DEBUG
- (void)dealloc
{
    NSLog(@"%s",__func__);
}
#endif


#pragma mark - public Method
+ (void)getFixScript:(NSString *)scriptText
{
    [FixManager evalString:scriptText];
}

@end
