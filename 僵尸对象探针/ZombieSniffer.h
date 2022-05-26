//
//  ZombieSniffer.h
//  DDD
//
//  Created by LBP on 5/14/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZombieSniffer : NSObject

/*!
 *  @method installSniffer
 *  启动zombie检测
 */
+ (void)installSniffer;

/*!
 *  @method uninstallSnifier
 *  停止zombie检测
 */
+ (void)uninstallSnifier;

/*!
 *  @method appendIgnoreClass
 *  添加白名单类
 */
+ (void)appendIgnoreClass: (Class)cls;

@end

NS_ASSUME_NONNULL_END
