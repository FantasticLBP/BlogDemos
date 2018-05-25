//
//  ViewController.m
//  LBPAttributedStringTools
//
//  Created by 刘斌鹏 on 2018/5/25.
//  Copyright © 2018年 杭城小刘. All rights reserved.
//

#import "ViewController.h"
#import "LBPHightedAttributedString.h"

@interface ViewController ()


@property (weak, nonatomic) IBOutlet UILabel *label1;

@property (weak, nonatomic) IBOutlet UILabel *label2;


@end

@implementation ViewController

#pragma mark -- life cycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    NSString *showString = @"摘一颗苹果，等你从门前经过，送到你的手中帮你解渴，像夏天的可乐，像冬天的可可，你是对的时间对的角色，已经约定过，一起过下个周末";
    
     self.label1.attributedText =  [LBPHightedAttributedString setAllText:showString andSpcifiStr:@"你" withColor:[UIColor redColor] specifiStrFont:[UIFont systemFontOfSize:17]];
    
    self.label2.attributedText = [LBPHightedAttributedString setAllText:showString andSpcifiStr:@"对" withColor:[UIColor brownColor] specifiStrFont:[UIFont systemFontOfSize:30]];
    
}



@end
