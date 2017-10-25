
//
//  UIImage+ClipBorderColor.m
//  裁剪带圆形边框的图片
//
//  Created by 杭城小刘 on 2017/10/24.
//  Copyright © 2017年 杭城小刘. All rights reserved.
//

#import "UIImage+ClipBorderColor.h"

@implementation UIImage (ClipBorderColor)
+(UIImage *)imageWithBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor image:(UIImage *)image{
    
    //3、开启图片上下文
    CGRect imageSize = CGRectMake(0, 0, image.size.width + 2*borderWidth, image.size.height + 2*borderWidth);
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(image.size.width + 2*borderWidth, image.size.height + 2*borderWidth), NO, 0);
    
    //4、绘制大圆（带有背景颜色的底层大圆）
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:imageSize];
    [borderColor set];
    [path fill];
    
    //5、绘制小圆
    path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(borderWidth, borderWidth, image.size.width , image.size.height)];
    //设置裁剪
    [path addClip];
    //5、把图片给绘制上下文.
    [image drawInRect:CGRectMake(borderWidth, borderWidth, image.size.width , image.size.height)];
    //6、从当前上下文得到一张新的图片
    UIImage *gotImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //7、关闭上下文
    UIGraphicsEndImageContext();
    return gotImage;
}
@end
