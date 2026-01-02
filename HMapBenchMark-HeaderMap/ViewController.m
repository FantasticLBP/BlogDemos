//
//  ViewController.m
//  HMapBenchMark-HeaderMap
//
//  Created by Unix_Kernel on 7/9/25.
//  Copyright © 2025 杭城小刘. All rights reserved.
//

#import "HMapStaticLib_HeaderMap.h"
#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    HMPCat *cat = [[HMPCat alloc] initWithName:@"PiPi"];
    HMPPerson *person = [[HMPPerson alloc] init];
    person.cat = cat;
    [person show];

    HMPStudent *student = [[HMPStudent alloc] initWithName:@"杭城小刘"];
    NSLog(@"%@", student.name);
    
    HMPSubject *subject = [[HMPSubject alloc] init];
    NSLog(@"%@", subject);
    
    HMPGame *game = [[HMPGame alloc] init];
    HMPBasketball *basketball = [[HMPBasketball alloc] init];
    HMPPlayer *player = [[HMPPlayer alloc] init];
    NSLog(@"%@ %@ %@", game, basketball, player);
}

@end
