
//
//  ContactEditViewController.m
//  登陆动画
//
//  Created by 杭城小刘 on 2017/10/9.
//  Copyright © 2017年 杭城小刘. All rights reserved.
//

#import "ContactEditViewController.h"

@interface ContactEditViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (nonatomic, strong) UIBarButtonItem *rightBarButtonItem;

@end

@implementation ContactEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.rightBarButtonItem = ({
        UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] init];
        rightBar.title = @"编辑";
        rightBar.target = self;
        rightBar.action = @selector(editContract);
        self.rightBarButtonItem = rightBar;
        rightBar;
    });
    
    self.usernameTextField.text = self.model.name;
    self.phoneTextField.text = self.model.phone;
    
}


- (IBAction)clickSaveButton:(id)sender {
    self.model.name = self.usernameTextField.text;
    self.model.phone = self.phoneTextField.text;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"UpdateContact" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)editContract{
    if ([self.rightBarButtonItem.title isEqualToString:@"编辑"]) {
        self.rightBarButtonItem.title = @"取消";
        [self.usernameTextField becomeFirstResponder];
        self.usernameTextField.userInteractionEnabled = YES;
        self.phoneTextField.userInteractionEnabled = YES;
    }else{
        self.rightBarButtonItem.title = @"编辑";
        [self.view endEditing:YES];
        self.usernameTextField.userInteractionEnabled = NO;
        self.phoneTextField.userInteractionEnabled = NO;
    }
}


#pragma mark -- setter
/*
 控制器之间传值不能在setter方法中赋值，因为在上一个VC中vc.model = self.datas[indexPath.row];后马上执行vc的setter方法。但是此时vc页面没有出现，self.usernameTextField 为nil，所以不能赋值
 一般在viewDidLoad中赋值
-(void)setModel:(ContactsModel *)model{
    _model = model;
    self.usernameTextField.text = model.name;
    self.phoneTextField.text =model.phone;
}
 */


@end
