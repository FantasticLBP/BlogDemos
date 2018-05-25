//
//  ViewController.m
//  双列表联动（外卖App）
//
//  Created by 杭城小刘 on 2017/9/24.
//  Copyright © 2017年 杭城小刘. All rights reserved.
//

#import "ViewController.h"
#import "PregnancyPeriodCell.h"
#import "QuestionCell.h"
#import "QuestionCollectionModel.h"
#import "YYModel.h"

#define BoundWidth  [[UIScreen mainScreen]bounds].size.width
#define BoundHeight [[UIScreen mainScreen]bounds].size.height

#define LeftCellHeight 77
#define RightCellHeight 70

static NSString *PregnancyPeriodCellID = @"PregnancyPeriodCell";
static NSString *QuestionCellID = @"QuestionCell";


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *leftTablview;

@property (nonatomic, strong) UITableView *rightTableview;

@property (nonatomic, strong) NSMutableArray *datas;

@property (nonatomic, assign) BOOL isScrollDown;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"漏网之题";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.leftTablview];
    [self.view addSubview:self.rightTableview];
    
    [self.leftTablview reloadData];
    [self.rightTableview reloadData];
    [self getCollectionData];
}


#pragma mark -- private method

-(void)getCollectionData{
    NSString *dataPath = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"];
    NSArray *datas = [NSArray arrayWithContentsOfFile:dataPath];
    for (NSDictionary *dict in datas) {
        [self.datas addObject:[QuestionCollectionModel yy_modelWithJSON:dict]];
    }
    [self.leftTablview reloadData];
    [self.rightTableview reloadData];
    [self.leftTablview selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
}


#pragma mark -- UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView == self.leftTablview) {
        return 1;
    }
    return self.datas.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.leftTablview) {
        return self.datas.count;
    }
    QuestionCollectionModel *model = self.datas[section];
    NSArray *questions =model.questions;
    return questions.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.leftTablview) {
        return LeftCellHeight;
    }
    return RightCellHeight;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.leftTablview) {
        PregnancyPeriodCell *cell = [tableView dequeueReusableCellWithIdentifier:PregnancyPeriodCellID forIndexPath:indexPath];
        QuestionCollectionModel *model = self.datas[indexPath.row];
        cell.week = model.tag;
        
        return cell;
    }
    QuestionCell *cell = [tableView dequeueReusableCellWithIdentifier:QuestionCellID forIndexPath:indexPath];
    QuestionCollectionModel *model = self.datas[indexPath.section];
    NSArray *questions =model.questions;
    QuestionModel *questionModel = questions[indexPath.row];
    cell.model = questionModel;
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.rightTableview  && !self.isScrollDown && self.rightTableview.isDragging ) {
        [self.leftTablview selectRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.section inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
    }
}


-(void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.rightTableview && self.isScrollDown && self.rightTableview.isDragging) {
        [self.leftTablview selectRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.section+1 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
        
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if (self.leftTablview == tableView)
    {
        [self.rightTableview scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.row] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }else{
        NSLog(@"嗡嗡嗡");
    }
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    static CGFloat lastOffsetY = 0;
    
    UITableView *tableView = (UITableView *)scrollView;
    if (self.rightTableview == tableView){
        self.isScrollDown = (lastOffsetY < scrollView.contentOffset.y);
        lastOffsetY = scrollView.contentOffset.y;
    }
    
}

#pragma mark -- private method



#pragma mark -- lazy load

-(UITableView *)leftTablview{
    if (!_leftTablview) {
        _leftTablview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0.2*BoundWidth, BoundHeight)];
        _leftTablview.delegate = self;
        _leftTablview.dataSource = self;
        [_leftTablview registerClass:[PregnancyPeriodCell class]
              forCellReuseIdentifier:PregnancyPeriodCellID];
        _leftTablview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _leftTablview.showsVerticalScrollIndicator = NO;
    }
    return _leftTablview;
}

-(UITableView *)rightTableview{
    if (!_rightTableview) {
        _rightTableview =[[UITableView alloc] initWithFrame:CGRectMake(0.2*BoundWidth, 0, BoundWidth - 0.2*BoundWidth, BoundHeight)];
        _rightTableview.delegate = self;
        _rightTableview.dataSource = self;
        [_rightTableview registerClass:[QuestionCell class] forCellReuseIdentifier:QuestionCellID];
        _rightTableview.allowsSelection = NO;
        _rightTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _rightTableview.showsVerticalScrollIndicator = NO;
        
        _rightTableview.tableFooterView = ({
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BoundWidth, 10)];
            view;
        });
    }
    return _rightTableview;
}

-(NSMutableArray *)datas{
    if (!_datas) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}

@end

