//
//  HandleImageView.h
//  画板
//
//  Created by 杭城小刘 on 2018/1/2.
//  Copyright © 2018年 杭城小刘. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HandleImageView;


@protocol HandleImageViewDelegate<NSObject>

-(void)handleImageView:(HandleImageView *)handleImageView didOperatedImage:(UIImage *)image;


@end

@interface HandleImageView : UIView

@property (nonatomic, strong) UIImage *image;

@property (nonatomic, weak) id<HandleImageViewDelegate> delegate;

@end
