//
//  ViewController.m
//  给图片添加水印
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
    
    
    UIImage *image = [UIImage imageNamed:@"onepiece"];
    //开启和图片相同大小的上下文
    /*
     *siz:开启一个多大的上下文
     *opaque: 不透明度
     *scale: 0
     */
     
    UIGraphicsBeginImageContextWithOptions(image.size, YES, 0);
    //画图片
    [image drawAtPoint:CGPointZero];
    
    
    NSString *iconStr = @"@one piece 路飞";
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:17];
    dict[NSForegroundColorAttributeName] = [UIColor redColor];
    dict[NSBackgroundColorAttributeName] = [UIColor whiteColor];

    [iconStr drawInRect:CGRectMake(image.size.width - 130, image.size.height - 20, 130, 20) withAttributes:dict];
    
    //生成图片：从上下文信息中得到图片
    UIImage *getImage = UIGraphicsGetImageFromCurrentImageContext();
    
    self.imageView.image = getImage;
    
    //手动关闭上下文
    UIGraphicsEndImageContext();
    
}




@end
