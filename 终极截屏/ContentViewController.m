

//
//  ContentViewController.m
//  终极截屏
//
//  Created by 刘斌鹏 on 2018/6/19.
//  Copyright © 2018年 杭城小刘. All rights reserved.
//

#import "ContentViewController.h"
#import <WebKit/WebKit.h>

@interface ContentViewController ()<UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) UIWebView *webview;
@property (nonatomic, strong) WKWebView *wkwebview;

@end

@implementation ContentViewController

#pragma mark -- life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.type == SnapshotType_Scrollview) {
        [self.view addSubview:self.tableview];
    }
    else if(self.type == SnapshotType_UIWebView){
        [self.view addSubview:self.webview];
        [self loadwebview];
    }
    else if(self.type == SnapshotType_WkWebview){
        [self.view addSubview:self.wkwebview];
        [self loadWkwebview];
    }
}

#pragma mark -- response method

- (IBAction)snapshot:(id)sender {
    if (self.type == SnapshotType_UIWebView || self.type == SnapshotType_Scrollview) {
        
        
        
        
        
        
    }
    else{
        
    }
}


#pragma mark -- UITableViewDatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"杭城小刘%zd",indexPath.row];
    return cell;
}


#pragma mark -- private method

- (void)loadwebview{
    [self.webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.jianshu.com/"]]];
}

- (void)loadWkwebview{
    [self.wkwebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.jianshu.com/"]]];
}

#pragma mark -- setter && getter

- (UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableview.dataSource = self;
        [_tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        _tableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    }
    return _tableview;
}


- (UIWebView *)webview{
    if (!_webview) {
        _webview = [[UIWebView alloc] initWithFrame:self.view.bounds];
    }
    return _webview;
}

- (WKWebView *)wkwebview{
    if (!_wkwebview) {
        _wkwebview = [[WKWebView alloc] initWithFrame:self.view.bounds];
    }
    return _wkwebview;
}

@end
