//
//  ViewController.m
//  WeexAPM
//
//  Created by Unix_Kernel on 12/23/25.
//

#import "ViewController.h"
#import "WeexViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Weex APM";
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    WeexViewController *vc = [[WeexViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end

