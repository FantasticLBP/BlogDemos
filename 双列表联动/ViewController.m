//
//  ViewController.m
//  双列表联动
//
//  Created by 杭城小刘 on 2017/9/22.
//  Copyright © 2017年 杭城小刘. All rights reserved.
//

#import "ViewController.h"


#define leftTableWidth  [UIScreen mainScreen].bounds.size.width * 0.3
#define rightTableWidth [UIScreen mainScreen].bounds.size.width * 0.7
#define ScreenWidth     [UIScreen mainScreen].bounds.size.width
#define ScreenHeight    [UIScreen mainScreen].bounds.size.height

static NSString *leftCellIdentifier = @"leftCellIdentifier";
static NSString *rightCellIdentifier = @"rightCellIdentifier";



@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *leftTableView;

@property (nonatomic, weak) UITableView *rightTableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.leftTableView];
    [self.view addSubview:self.rightTableView];
}


#pragma mark -- UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.leftTableView) {
        return 22;
    }
    return 18;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView == self.leftTableView) {
        return 1;
    }
    return 22;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell;
    if (tableView == self.leftTableView) {
        
        cell = [tableView dequeueReusableCellWithIdentifier:leftCellIdentifier forIndexPath:indexPath];
        cell.textLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row];
    } else {
        
        cell = [tableView dequeueReusableCellWithIdentifier:rightCellIdentifier forIndexPath:indexPath];
        cell.textLabel.text = [NSString stringWithFormat:@"第%ld组-第%ld行", indexPath.section, indexPath.row];
    }
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (tableView == self.rightTableView) {
        return [NSString stringWithFormat:@"第%zd组",section];
    }
    return nil;
}


/*
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == self.leftTableView) {
        return ;
    }
    
    
    NSIndexPath *topIndexPath = [self.rightTableView indexPathsForVisibleRows].firstObject;
    NSIndexPath *leftScrollIndexpath = [NSIndexPath indexPathForRow:topIndexPath.section inSection:0];
    [self.leftTableView selectRowAtIndexPath:leftScrollIndexpath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.rightTableView) {
        return ;
    }
    NSIndexPath *rightScrollIndexpath = [NSIndexPath indexPathForRow:0 inSection:indexPath.row];
    [self.rightTableView selectRowAtIndexPath:rightScrollIndexpath animated:YES scrollPosition:UITableViewScrollPositionTop];
    [self.rightTableView deselectRowAtIndexPath:rightScrollIndexpath animated:YES];
}
*/
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    // 如果是 左侧的 tableView 直接return
    if (scrollView == self.leftTableView) return;
    
    // 取出显示在 视图 且最靠上 的 cell 的 indexPath
    NSIndexPath *topHeaderViewIndexpath = [[self.rightTableView indexPathsForVisibleRows] firstObject];
    
    // 左侧 talbelView 移动的 indexPath
    NSIndexPath *moveToIndexpath = [NSIndexPath indexPathForRow:topHeaderViewIndexpath.section inSection:0];
    
    // 移动 左侧 tableView 到 指定 indexPath 居中显示
    [self.leftTableView selectRowAtIndexPath:moveToIndexpath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
    
}

//MARK: - 点击 cell 的代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    // 选中 左侧 的 tableView
    if (tableView == self.leftTableView) {
        
        NSIndexPath *moveToIndexPath = [NSIndexPath indexPathForRow:0 inSection:indexPath.row];
        
        // 将右侧 tableView 移动到指定位置
        [self.rightTableView selectRowAtIndexPath:moveToIndexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
        
        // 取消选中效果
        [self.rightTableView deselectRowAtIndexPath:moveToIndexPath animated:YES];
    }
}


#pragma mark -- private method

- (UITableView *)leftTableView {
    
    if (!_leftTableView) {
        
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, leftTableWidth, ScreenHeight)];
        
        [self.view addSubview:tableView];
        
        _leftTableView = tableView;
        
        tableView.dataSource = self;
        tableView.delegate = self;
        
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:leftCellIdentifier];
        tableView.backgroundColor = [UIColor redColor];
        tableView.tableFooterView = [[UIView alloc] init];
        
    }
    return _leftTableView;
}

- (UITableView *)rightTableView {
    
    if (!_rightTableView) {
        
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(leftTableWidth, 0, rightTableWidth, ScreenHeight)];
        
        [self.view addSubview:tableView];
        
        _rightTableView = tableView;
        
        tableView.dataSource = self;
        tableView.delegate = self;
        
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:rightCellIdentifier];
        tableView.backgroundColor = [UIColor cyanColor];
        tableView.tableFooterView = [[UIView alloc] init];
        
    }
    return _rightTableView;
}




@end
