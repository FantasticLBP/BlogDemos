//
//  ContentViewController.h
//  终极截屏
//
//  Created by 刘斌鹏 on 2018/6/19.
//  Copyright © 2018年 杭城小刘. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger,SnapshotType) {
    SnapshotType_Scrollview = 0,
    SnapshotType_UIWebView,
    SnapshotType_WkWebview
};

@interface ContentViewController : UIViewController

@property (nonatomic, assign) SnapshotType type;

@end
