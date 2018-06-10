//
//  ViewController.m
//  微博发帖动画
//
//  Created by 刘斌鹏 on 2018/6/10.
//  Copyright © 2018年 杭城小刘. All rights reserved.
//

#import "ViewController.h"
#import "OPerationViewController.h"
#import "MuneItem.h"

#define BoundWith [UIScreen mainScreen].bounds.size.width
#define BoundHeight [UIScreen mainScreen].bounds.size.height


@interface ViewController ()

@property (nonatomic, strong) UIButton *postButton;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.postButton];
    
}


- (void)post{
    OPerationViewController *vc = [[OPerationViewController alloc] init];
    MuneItem *item = [MuneItem itemWithTitle:@"点评" image:[UIImage imageNamed:@"tabbar_compose_review"]];
    MuneItem *item1 = [MuneItem itemWithTitle:@"更多" image:[UIImage imageNamed:@"tabbar_compose_more"]];
    MuneItem *item2 = [MuneItem itemWithTitle:@"拍摄" image:[UIImage imageNamed:@"tabbar_compose_camera"]];
    MuneItem *item3 = [MuneItem itemWithTitle:@"相册" image:[UIImage imageNamed:@"tabbar_compose_photo"]];
    MuneItem *item4 = [MuneItem itemWithTitle:@"文字" image:[UIImage imageNamed:@"tabbar_compose_idea"]];
    MuneItem *item5 = [MuneItem itemWithTitle:@"签到" image:[UIImage imageNamed:@"tabbar_compose_review"]];
    
    
    vc.items = @[item,item1,item2,item3,item4,item5];
    
    [self presentViewController:vc animated:YES completion:nil];
}


#pragma mark -- setter && getter

- (UIButton *)postButton{
    if (!_postButton) {
        _postButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _postButton.frame = CGRectMake(30, BoundHeight - 80, BoundWith - 2*30, 40);
        _postButton.backgroundColor = [UIColor brownColor];
        [_postButton setTitle:@"发条动态吧" forState:UIControlStateNormal];
        [_postButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_postButton addTarget:self action:@selector(post) forControlEvents:UIControlEventTouchUpInside];
    }
    return _postButton;
}

@end
