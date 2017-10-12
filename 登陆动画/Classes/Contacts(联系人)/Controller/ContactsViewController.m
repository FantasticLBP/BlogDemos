
//
//  ContactsViewController.m
//  登陆动画
//
//  Created by 杭城小刘 on 2017/10/7.
//  Copyright © 2017年 杭城小刘. All rights reserved.
//

#import "ContactsViewController.h"
#import "ContactsModel.h"
#import "AddViewController.h"
#import "ContactEditViewController.h"

@interface ContactsViewController ()<AddViewControllerDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) ContactsModel *model;

@property (nonatomic, strong) NSMutableArray *datas;

@end

@implementation ContactsViewController

#pragma mark -- life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [UIView new];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(UpdateContact) name:@"UpdateContact" object:nil];
}

-(void)UpdateContact{
    [self.tableView reloadData];
}

#pragma mark -- button method

- (IBAction)clickQuitButton:(id)sender {
    UIAlertController *sheet = [UIAlertController alertControllerWithTitle:@"确定要取消吗？" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [sheet addAction:okAction];
    [sheet addAction:cancelAction];
    [self presentViewController:sheet animated:YES completion:nil];
    
}

- (IBAction)clickAddButton:(id)sender {
    
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if (![segue.destinationViewController isKindOfClass:[ContactEditViewController class]]) {
        AddViewController *vc = segue.destinationViewController;
        vc.delegate = self;
    }else if([segue.destinationViewController isKindOfClass:[ContactEditViewController class]]){
        ContactEditViewController *vc  = segue.destinationViewController;
        //[self.tableView indexPathForSelectedRow];会返回当前tableView选中的indexPath值
        vc.model = self.datas[[self.tableView indexPathForSelectedRow].row];
    }
   
}

#pragma mark -- AddViewControllerDelegate
-(void)addViewController:(AddViewController *)addViewController didClickAddButtonWithContact:(ContactsModel *)model{
    [self.datas addObject:model];
    [self.tableView reloadData];
}

#pragma mark -- UITabelViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView indexPathForSelectedRow];
    static NSString *CellId = @"ContactCellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellId];
    ContactsModel *model = self.datas[indexPath.row];
    cell.textLabel.text = model.name;
    cell.detailTextLabel.text = model.phone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  
    
    
}

#pragma mark -- lazy load
-(NSMutableArray *)datas{
    if (!_datas) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}
@end
