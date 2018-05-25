//
//  ViewController.m
//  圆形图片裁剪
//
//  Created by 杭城小刘 on 2017/10/19.
//  Copyright © 2017年 杭城小刘. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //1、加载一张图片
    UIImage *image = [UIImage imageNamed:@"onepiece"];
    
    //2、生成跟图片同样大小的上下文
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    //3、在上下文添加一个圆形的裁剪区
    UIBezierPath *path  = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    
    //把路径设置成裁剪区域
    [path addClip];
    
    //4、将图片绘制到上下文
    [image drawAtPoint:CGPointZero];
    
    //5、生成一张图片
    UIImage *getImage = UIGraphicsGetImageFromCurrentImageContext();
    //6、手动关闭上下文
    UIGraphicsEndImageContext();
    
    self.imageView.image = getImage;
    
}





@end
