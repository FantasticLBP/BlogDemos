//
//  ViewController.m
//  僵尸对象探针
//
//  Created by LBP on 5/26/22.
//  Copyright © 2022 杭城小刘. All rights reserved.
//

#import "ViewController.h"
#import "ZombieSniffer.h"
#import "ZombieObjectDetector.h"

@interface ViewController ()

@end

@implementation ViewController

- (BOOL)isZoomUserWithUserID:(NSInteger)userID error:(NSError **)error
{
    @autoreleasepool {
        NSString *errorMessage = [[NSString alloc] initWithFormat:@"the user is not zoom user"];
        if (userID == 100) {
            *error = [NSError errorWithDomain:@"com.test" code:userID userInfo:@{NSLocalizedDescriptionKey: errorMessage}];
            return NO;
        }
    }
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   [ZombieSniffer installSniffer]; 
    [self test];
}


- (void)test {
    for (NSInteger index = 0; index <= 100; index++) {
        NSString *str;
        str = [NSString stringWithFormat:@"welcome to zoom:%ld", index];
        str = [str stringByAppendingString:@" user"];
        NSError *error = NULL;
        if ([self isZoomUserWithUserID:index error:&error]) {
            NSLog(@"%@", str);
        } else {
            NSLog(@"%@", error);
        }
    }
}
@end
