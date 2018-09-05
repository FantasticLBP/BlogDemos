//
//  ViewController.m
//  终极截屏
//
//  Created by 刘斌鹏 on 2018/6/19.
//  Copyright © 2018年 杭城小刘. All rights reserved.
//

#import "ViewController.h"
#import "ContentViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *scrollviewButton;
@property (weak, nonatomic) IBOutlet UIButton *wkwebviewButton;
@property (weak, nonatomic) IBOutlet UIButton *webviewButton;

@end

@implementation ViewController

#pragma mark -- life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"终极截屏";
    
    [self.scrollviewButton addTarget:self action:@selector(gotoScrollviewSnapshot) forControlEvents:UIControlEventTouchUpInside];
    [self.webviewButton addTarget:self action:@selector(gotoUIWebviewSnapshot) forControlEvents:UIControlEventTouchUpInside];
    [self.wkwebviewButton addTarget:self action:@selector(gotoWKWebviewSnapshot) forControlEvents:UIControlEventTouchUpInside];
}


#pragma mark -- response method

- (void)gotoScrollviewSnapshot{
    ContentViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ContentViewController"];
    vc.type = SnapshotType_Scrollview;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)gotoUIWebviewSnapshot{
    ContentViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ContentViewController"];
    vc.type = SnapshotType_UIWebView;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)gotoWKWebviewSnapshot{
    ContentViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ContentViewController"];
    vc.type = SnapshotType_WkWebview;
    [self.navigationController pushViewController:vc animated:YES];
}


@end
