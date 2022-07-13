//
//  ViewController.m
//  完美自定义键盘顶部 View
//
//  Created by 杭城小刘 on 7/13/22.
//  Copyright © 2022 杭城小刘. All rights reserved.
//

#import "ViewController.h"
#import "TestViewController.h"
#import <AudioToolbox/AudioToolbox.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (nonatomic, strong) UIInputView *inputView;

@end

@implementation ViewController

#pragma mark - life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.usernameTextField.inputAccessoryView = self.inputView;
    self.passwordTextField.inputAccessoryView = self.inputView;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


#pragma mark - private method
- (void)handleClickAvator
{
    [self jumpDetaiViewControllerWithTitle:@"Address book"];
}

- (void)handleClickScan
{
    [self jumpDetaiViewControllerWithTitle:@"Scan"];
}

- (void)handleClickPaste
{
    [self jumpDetaiViewControllerWithTitle:@"Paste"];
}

- (void)jumpDetaiViewControllerWithTitle:(NSString *)title
{
    AudioServicesPlaySystemSound(1104);
    TestViewController *vc = [[TestViewController alloc] init];
    vc.msg = title;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - getters and setters
- (UIInputView *)inputView
{
    if (!_inputView) {
        UIInputView *inputView = [[UIInputView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40) inputViewStyle:UIInputViewStyleKeyboard];
        
        UIView *avatorContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width/3, 40)];
        UIImageView *avatorImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 11, 18, 18)];
        avatorImageView.image = [UIImage imageNamed:@"avator"];
        UILabel *addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 0, 100, 40)];
        addressLabel.text = @"Address book";
        addressLabel.textColor = UIColor.blackColor;
        addressLabel.font = [UIFont systemFontOfSize:16];
        UITapGestureRecognizer *avatorTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleClickAvator)];
        avatorTapGesture.cancelsTouchesInView = YES;
        [avatorContainerView addGestureRecognizer:avatorTapGesture];
        [avatorContainerView addSubview:avatorImageView];
        [avatorContainerView addSubview:addressLabel];
        
        UIView *scanContainerView = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/3 + 50, 0, self.view.frame.size.width/3, 40)];
        UIImageView *scanImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 11, 18, 18)];
        scanImageView.image = [UIImage imageNamed:@"scan"];
        UILabel *scanLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 50, 40)];
        scanLabel.text = @"Scan";
        scanLabel.textColor = UIColor.blackColor;
        scanLabel.font = [UIFont systemFontOfSize:16];
        UITapGestureRecognizer *scanTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleClickScan)];
        scanTapGesture.cancelsTouchesInView = YES;
        [scanContainerView addGestureRecognizer:scanTapGesture];
        [scanContainerView addSubview:scanImageView];
        [scanContainerView addSubview:scanLabel];
        
        UIView *pasteContainerView = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width*2/3 + 50, 0, self.view.frame.size.width/3 - 50, 40)];
        UILabel *pasteLabel = [[UILabel alloc] initWithFrame:pasteContainerView.bounds];
        pasteLabel.text = @"Paste";
        pasteLabel.textColor = UIColor.blackColor;
        pasteLabel.font = [UIFont systemFontOfSize:16];
        UITapGestureRecognizer *pasteTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleClickPaste)];
        pasteTapGesture.cancelsTouchesInView = YES;
        [pasteContainerView addGestureRecognizer:pasteTapGesture];
        [pasteContainerView addSubview:pasteLabel];
        
        [inputView addSubview:avatorContainerView];
        [inputView addSubview:scanContainerView];
        [inputView addSubview:pasteContainerView];
        _inputView = inputView;
    }
    return _inputView;
}

@end
