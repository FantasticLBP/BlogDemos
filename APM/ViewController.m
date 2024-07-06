//
//  ViewController.m
//  APM
//
//  Created by Unix_Kernel on 6/30/24.
//  Copyright © 2024 杭城小刘. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "Cat.h"
@interface ViewController ()
@property (nonatomic, assign) NSInteger count;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.count = 0;
//    [self mockLocalizedIssue];
//    [self mockLogicIssue];
//    [self mockIssue0];
//    [self mockIssue1];
//    [self mockIssue2:nil];
//    [self mockIssue3];
//    [self mockDataIssue];
//    [self mockAssertIssue];
//    [self mockEndlessLoopIssue];
    [self mockRetainCycle];
}

#pragma mark - 国际化多语言检查
- (void)mockLocalizedIssue {
    self.title = @"Static Analysis";
    self.title = NSLocalizedString(@"title", @"Faked title");
}

#pragma mark - 逻辑检查
- (void)mockLogicIssue {
    NSInteger a = 0;
    NSInteger b = 1;
    NSInteger result = b/a;
    NSLog(@"%zd", result);
}

#pragma mark - 内存问题检查
- (void)mockIssue0 {
    CGPathRef shadowPath = CGPathCreateWithRect(self.view.bounds, NULL);
    NSLog(@"%@", shadowPath);
    // Fix Version
    // CGPathRef shadowPath = CGPathCreateWithRect(self.view.bounds, NULL);
    // CGPathRelease(shadowPath);
}

- (void)mockIssue2:(void(^)(void))callback {
    callback();
    // Fix Verisin
    // !callback ?: callback();
}

#pragma mark - 数据检查
- (void)mockIssue1 {
    FILE *fp;
    fp = fopen("info.plist", "r");
}

- (NSArray *)mockIssue3 {
    NSString *str = nil;
    return @[@"problem0", str, @"problem1"];
}

- (void)mockDataIssue {
    NSString *str = [[NSString alloc] init];
    str = @"123";
    NSLog(@"%@", str);
}

#pragma mark - Xcode13 new feature
- (void)mockAssertIssue {
    self.count = 1;
    NSAssert(++self.count == 2, @"Oops, the count value must set to 1!");
    NSLog(@"self.count value ---- %zd", self.count);
}

- (void)mockEndlessLoopIssue {
    NSInteger innerUpperBounds = 9;
    NSInteger outerUpperBounds = 3;
    
    NSInteger result = 0;
    for (NSInteger i = 0; i < outerUpperBounds; i++) {
        for (NSInteger j = 0; j < innerUpperBounds; result++) {
            result += i*j;
        }
    }
    
}

#pragma mark - Retain cycle
- (void)mockRetainCycle {
    Person *p = [[Person alloc] init];
    Cat *cat = [[Cat alloc] init];
    p.cat = cat;
    cat.hoster = p;
}
@end
