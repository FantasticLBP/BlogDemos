//
//  ViewController.m
//  HMapBenchMark-HeaderSearchMap
//
//  Created by Unix_Kernel on 7/9/25.
//  Copyright © 2025 杭城小刘. All rights reserved.
//

#import "HMapStaticLib_HeaderSearchPath.h"
#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    HSPCat *cat = [[HSPCat alloc] initWithName:@"PiPi"];
    HSPPerson *person = [[HSPPerson alloc] init];
    person.cat = cat;
    [person show];

    HSPStudent *student = [[HSPStudent alloc] initWithName:@"杭城小刘"];
    NSLog(@"%@", student.name);
    
    HSPSubject *subject = [[HSPSubject alloc] init];
    NSLog(@"%@", subject);
    
    HSPGame *game = [[HSPGame alloc] init];
    HSPBasketball *basketball = [[HSPBasketball alloc] init];
    HSPPlayer *player = [[HSPPlayer alloc] init];
    NSLog(@"%@ %@ %@", game, basketball, player);
}


@end

