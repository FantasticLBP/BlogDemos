//
//  ViewController.m
//  ImageDecode
//
//  Created by Unix_Kernel on 7/17/24.
//  Copyright © 2024 杭城小刘. All rights reserved.
//

#import "ViewController.h"
#import <os/signpost.h>

//宏定义,实际开发中,区分Debug、Release
#define SP_BEGIN_LOG(subsystem, category, name) \
os_log_t m_log_##name = os_log_create((#subsystem), (#category));\
os_signpost_id_t m_spid_##name = os_signpost_id_generate(m_log_##name);\
os_signpost_interval_begin(m_log_##name, m_spid_##name, (#name));

#define SP_END_LOG(name) \
os_signpost_interval_end(m_log_##name, m_spid_##name, (#name));


@interface ViewController ()
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 100, self.view.frame.size.width - 100, 200)];
//    [self.view addSubview:self.imageView];
//    [self setImage];
    
    
    dispatch_queue_t queue = dispatch_queue_create("test", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        NSLog(@"1");  
    });
    dispatch_async(queue, ^{
        NSLog(@"2");
    });
    
    dispatch_sync(queue, ^{
        NSLog(@"3");
    });
    NSLog(@"4");
}

- (void)setImage {
    SP_BEGIN_LOG(custome, gl_log, imageSet);
    [self decodeImage:[UIImage imageNamed:@"peacock"] completion:^(UIImage *image) {
        self.imageView.image = image;
        SP_END_LOG(imageSet);
    }];
}

- (void)decodeImage:(UIImage *)image completion:(void(^)(UIImage *image))completionHandler {
    if (!image) return;
    //在子线程执行解码操作
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        CGImageRef imageRef = image.CGImage;
        //获取像素宽和像素高
        size_t width = CGImageGetWidth(imageRef);
        size_t height = CGImageGetHeight(imageRef);
        if (width == 0 || height == 0) return ;
        CGImageAlphaInfo alphaInfo = CGImageGetAlphaInfo(imageRef) & kCGBitmapAlphaInfoMask;
        BOOL hasAlpha = NO;
        //判断颜色是否含有alpha通道
        if (alphaInfo == kCGImageAlphaPremultipliedLast ||
            alphaInfo == kCGImageAlphaPremultipliedFirst ||
            alphaInfo == kCGImageAlphaLast ||
            alphaInfo == kCGImageAlphaFirst) {
            hasAlpha = YES;
        }
        //在iOS中，使用的是小端模式，在mac中使用的是大端模式，为了兼容，我们使用kCGBitmapByteOrder32Host，32位字节顺序，该宏在不同的平台上面会自动组装换成不同的模式。
        /*
         #ifdef __BIG_ENDIAN__
         # define kCGBitmapByteOrder16Host kCGBitmapByteOrder16Big
         # define kCGBitmapByteOrder32Host kCGBitmapByteOrder32Big
         #else    //Little endian.
         # define kCGBitmapByteOrder16Host kCGBitmapByteOrder16Little
         # define kCGBitmapByteOrder32Host kCGBitmapByteOrder32Little
         #endif
         */
        
        CGBitmapInfo bitmapInfo = kCGBitmapByteOrder32Host;
        //根据是否含有alpha通道，如果有则使用kCGImageAlphaPremultipliedFirst，ARGB否则使用kCGImageAlphaNoneSkipFirst，RGB
        bitmapInfo |= hasAlpha ? kCGImageAlphaPremultipliedFirst : kCGImageAlphaNoneSkipFirst;
        //创建一个位图上下文
        CGContextRef context = CGBitmapContextCreate(NULL, width, height, 8, 0,  CGColorSpaceCreateDeviceRGB(), bitmapInfo);
        if (!context) return;
        //将原始图片绘制到上下文当中
        CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
        //创建一张新的解压后的位图
        CGImageRef newImage = CGBitmapContextCreateImage(context);
        CFRelease(context);
        UIImage *originImage =[UIImage imageWithCGImage:newImage scale:[UIScreen mainScreen].scale orientation:image.imageOrientation];
        //回到主线程回调
        dispatch_async(dispatch_get_main_queue(), ^{
            !completionHandler ?: completionHandler(originImage);
        });
    });
}

@end
