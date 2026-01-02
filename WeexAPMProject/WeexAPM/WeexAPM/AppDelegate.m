//
//  AppDelegate.m
//  WeexAPM
//
//  Created by Unix_Kernel on 12/23/25.
//

#import "AppDelegate.h"
#import <WeexSDK/WeexSDK.h>
#import "WXLogicCalculationModule.h"
#import "WXColorButtonComponent.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [WXSDKEngine initSDKEnvironment];
    
    // Weex 异常监控
    [WXAnalyzerCenter setOpen:YES];
    [WXAPMReporter registerAPMReporter];
    
    // 注册 Weex 默认模块和组件（基础功能必需）
    [WXSDKEngine registerDefaults];
    [WXSDKEngine setGlobalDeviceSize:[UIScreen mainScreen].bounds.size];
    
    [WXSDKEngine registerModule:@"logicCalculation" withClass:[WXLogicCalculationModule class]];
    [WXSDKEngine registerComponent:@"color-button" withClass:[WXColorButtonComponent class]];
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
