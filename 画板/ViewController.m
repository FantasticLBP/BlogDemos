//
//  ViewController.m
//  画板
//
//  Created by 杭城小刘 on 2017/12/11.
//  Copyright © 2017年 杭城小刘. All rights reserved.
//

#import "ViewController.h"
#import "DrawView.h"
#import "HandleImageView.h"

@interface ViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,HandleImageViewDelegate>

@property (weak, nonatomic) IBOutlet DrawView *drawView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
}

#pragma mark -- HandleImageViewDelegate

-(void)handleImageView:(HandleImageView *)handleImageView didOperatedImage:(UIImage *)image{
    self.drawView.image = image;    
}

#pragma mark -- UIImagePickerControllerDelegate

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    HandleImageView *handleView = [[HandleImageView alloc] initWithFrame:self.drawView.bounds];
    handleView.image = image;
    handleView.delegate = self;
    [self.drawView addSubview:handleView];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark -- response method

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"提示" message:@"相册保存成功" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alertVc addAction:okAction];
    [self presentViewController:alertVc animated:YES completion:nil];

}

- (IBAction)clickClearScreenAction:(id)sender {
    [self.drawView clearScreen];
}

- (IBAction)clickRevokeAction:(id)sender {
    [self.drawView revoke];
}

- (IBAction)clickEreaseAction:(id)sender {
    [self.drawView erease];
}

- (IBAction)clickImageAction:(id)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
    
    
}

- (IBAction)clickSaveAction:(id)sender {
    //开启上下文（大小和画布一样大）
    UIGraphicsBeginImageContextWithOptions(self.drawView.bounds.size, NO, 0);
    //保存当前上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //将画板上的内容绘制到上下文中去
    [self.drawView.layer renderInContext:ctx];
    //从当前上下文获取一张图片
    UIImage *imageGot = UIGraphicsGetImageFromCurrentImageContext();
    //关闭上下文
    UIGraphicsEndImageContext();
    //将图片保存到相册
    UIImageWriteToSavedPhotosAlbum(imageGot, self, @selector(image: didFinishSavingWithError:contextInfo:), nil);

    
}



- (IBAction)penWidth:(UISlider *)sender {
    [self.drawView setPenWidth:sender.value*50];
}




-(IBAction)clickRedColor:(UIButton *)sender{
    [self.drawView setPenColor:sender.backgroundColor];
}


-(IBAction)clickBlueColor:(UIButton *)sender{
    [self.drawView setPenColor:sender.backgroundColor];
}


-(IBAction)clickYellowColor:(UIButton *)sender{
    [self.drawView setPenColor:sender.backgroundColor];
}

@end
