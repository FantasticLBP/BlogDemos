//
//  LBPSnapshotManager.h
//  终极截屏
//
//  Created by 刘斌鹏 on 2018/6/19.
//  Copyright © 2018年 杭城小刘. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface LBPSnapshotManager : NSObject


+ (LBPSnapshotManager *)sharedInstance;

- (void)snapshotForView:(__kindof UIView *)view onView:(UIView *)view success:(void(^)(UIImage *snapshot))success;



@end
