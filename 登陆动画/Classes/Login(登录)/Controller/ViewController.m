//
//  ViewController.m
//  登陆动画
//
//  Created by 杭城小刘 on 2017/9/9.
//  Copyright © 2017年 杭城小刘. All rights reserved.
//

#import "ViewController.h"
#import "LoginAnimationView.h"
#import "ContactsViewController.h"

@interface ViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) LoginAnimationView *animationView;
@property (weak, nonatomic) IBOutlet UIView *animationBgView;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@property (weak, nonatomic) IBOutlet UISwitch *autoLoginSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *rememberPasswordSwitch;



@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"私人通讯录";
    [self.animationBgView addSubview:self.animationView];
    
    [self.usernameTextField addTarget:self action:@selector(editChange) forControlEvents:UIControlEventEditingChanged];
    [self.passwordTextField addTarget:self action:@selector(editChange) forControlEvents:UIControlEventEditingChanged];
    [self editChange];
}

#pragma mark -- UITextFieldDelegate
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField == self.usernameTextField) {
        [self.animationView startAnimation:NO];
    }else{
        [self.animationView startAnimation:YES];
    }
}

#pragma mark -- reponse method
- (IBAction)clickLoginButton:(UISwitch *)sender{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
       
        if ([self.usernameTextField.text isEqualToString:@"admin"] && [self.passwordTextField.text isEqualToString:@"123456"]) {
            [self performSegueWithIdentifier:@"loginIdentifier" sender:nil];
        }else{
            NSLog(@"账号或密码错误");
        }
    });
    
    
}



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    ContactsViewController *vc = segue.destinationViewController;
    vc.navigationItem.title = [NSString stringWithFormat:@"%@的联系人",self.usernameTextField.text];
    
    
    
}

- (IBAction)clickRememberPasswordSwicth:(UISwitch *)sender{
    //取消记住密码，则取消自动登录
    if (sender.on == NO) {
        [self.autoLoginSwitch setOn:NO animated:YES];
    }
}


- (IBAction)clickAutoLoginSwitch:(UISwitch *)sender{
    //点击自动登录，则点击记住密码
    if (sender.on == YES) {
        [self.rememberPasswordSwitch setOn:YES animated:YES];
    }
}

-(void)editChange{
    self.loginButton.enabled = self.usernameTextField.text.length && self.passwordTextField.text.length;
}

#pragma mark -- lazy load
-(LoginAnimationView *)animationView{
    if (!_animationView) {
        _animationView = [LoginAnimationView loginAnimationView];
        _animationView.frame = CGRectMake(25, 0, self.view.frame.size.width - 50, 100);
    }
    return _animationView;
}

@end
