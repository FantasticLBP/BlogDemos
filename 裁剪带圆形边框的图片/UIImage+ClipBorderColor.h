//
//  UIImage+ClipBorderColor.h
//  裁剪带圆形边框的图片
//
//  Created by 杭城小刘 on 2017/10/24.
//  Copyright © 2017年 杭城小刘. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ClipBorderColor)



/**
 裁剪带有边框的图片

 @param borderWidth 边框宽度
 @param borderColor 边框的颜色
 @param image 需要裁剪的图片
 @return 裁剪后带有边框的图片
 */
+(UIImage *)imageWithBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor image:(UIImage *)image;
@end
