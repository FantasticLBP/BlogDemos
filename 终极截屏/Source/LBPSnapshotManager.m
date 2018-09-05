

//
//  LBPSnapshotManager.m
//  终极截屏
//
//  Created by 刘斌鹏 on 2018/6/19.
//  Copyright © 2018年 杭城小刘. All rights reserved.
//

#import "LBPSnapshotManager.h"

@interface LBPSnapshotManager()

@property (nonatomic, assign) BOOL isCapturing;
@property (nonatomic, strong) UIView *captureView;
@property (nonatomic, copy) UIImage* (^CaptureBlock)(void);


@end

@implementation LBPSnapshotManager

+ (LBPSnapshotManager *)sharedInstance{
    static LBPSnapshotManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[LBPSnapshotManager alloc] init];
    });
    return instance;
}

- (void)snapshotForView:(__kindof UIView *)view onView:(UIView *)view success:(void(^)(UIImage *snapshot))success{
    if (!view || _isCapturing) {
        return ;
    }
    self.captureView = view;
    
    
}


#pragma mark - UIScrollView

- (void)snapshotForScrollView:(UIScrollView *)scrollView{
    
    //1、保存截图时候的位置和大小
    CGPoint scrollviewOffset = scrollView.contentOffset;
    CGRect currentFrame = scrollView.frame;
    //2、将 scrollview 的内容展开成真实高度;偏移量设置为0
    scrollView.contentOffset = CGPointZero;
    scrollView.frame = CGRectMake(0, 0, scrollview.contentSize.width, scrollview.contentSize.height);
    //3、开启绘图上下文
    UIGraphicsBeginImageContextWithOptions(scrollView.contentSize, YES, [UIScreen mainScreen].scale);
    
    UIImage *imageGot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //4、Scrollview 恢复截屏之前的偏移量和frame
    scrollView.contentOffset = scrollviewOffset;
    scrollView.frame = currentFrame;
    
}

@end
