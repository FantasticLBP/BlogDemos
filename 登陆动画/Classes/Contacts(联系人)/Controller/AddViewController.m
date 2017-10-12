//
//  AddViewController.m
//  登陆动画
//
//  Created by 杭城小刘 on 2017/10/8.
//  Copyright © 2017年 杭城小刘. All rights reserved.
//

#import "AddViewController.h"

@interface AddViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新建联系人";
    [self.usernameTextField addTarget:self action:@selector(editChange) forControlEvents:UIControlEventEditingChanged];
    [self.phoneTextField addTarget:self action:@selector(editChange) forControlEvents:UIControlEventEditingChanged];
}

-(void)editChange{
    self.saveButton.enabled = self.usernameTextField.text.length && self.phoneTextField.text.length;
}

- (IBAction)clickSaveButton:(id)sender {
    ContactsModel *model = [ContactsModel contactWithName:self.usernameTextField.text phone:self.phoneTextField.text];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(addViewController:didClickAddButtonWithContact:)]) {
        [self.navigationController popViewControllerAnimated:YES];
        [self.delegate addViewController:self didClickAddButtonWithContact:model];
    }
}


@end
