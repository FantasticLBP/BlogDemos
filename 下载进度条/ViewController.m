//
//  ViewController.m
//  下载进度条
//
//  Created by 杭城小刘 on 2017/10/15.
//  Copyright © 2017年 杭城小刘. All rights reserved.
//

#import "ViewController.h"
#import "ProgressView.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet ProgressView *progressView;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UISlider *slider;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.slider addTarget:self action:@selector(downloadProgressChange:) forControlEvents:UIControlEventValueChanged];
}

-(void)downloadProgressChange:(UISlider *)sender{
    self.progressView.progress = sender.value;
    self.label.text = [NSString stringWithFormat:@"%.2f%%",sender.value*100];
}




@end
