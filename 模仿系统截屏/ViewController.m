//
//  ViewController.m
//  模仿系统截屏
//
//  Created by 杭城小刘 on 2017/10/25.
//  Copyright © 2017年 杭城小刘. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

//触摸屏幕就截图
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
 
    /*
     * 模仿系统截图：（截图的本质就是将屏幕上的东西绘制成一张图片并保存下来）
     * 开启图片上下文
     * 从开启的上下文对象中得到当前的上下文
     * 因为view的显示本质是就是基于layer，所就将layer上的东西绘制到上下文中
     * 从当前上下文中得到图片
     * 关闭上下文
     * 将图片保存到相册中
     */
    CGSize size = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height);
    //1、开启图片上下文
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    //2、得到当前上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //3、将layer上的东西绘制到上下文中
    [self.view.layer renderInContext:ctx];
    //4、从上下文中得到图片
    UIImage *imgGot = UIGraphicsGetImageFromCurrentImageContext();
    //5、关闭上下文
    UIGraphicsEndImageContext();
    
    //6、保存图片
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"宝贝儿，是否保存截图？" message:@"截图已经生成" preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImageWriteToSavedPhotosAlbum(imgGot, self, @selector(image:didFinishSavingWithError:contextInfo:),  (__bridge void *)self);
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDestructive handler:nil];
    
    [alertVC addAction:ok];
    [alertVC addAction:cancel];
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{

    NSLog(@"image = %@, error = %@, contextInfo = %@", image, error, contextInfo);
}



@end
