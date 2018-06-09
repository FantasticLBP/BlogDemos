//
//  ViewController.m
//  复制层应用2
//
//  Created by 刘斌鹏 on 2018/6/5.
//  Copyright © 2018年 杭城小刘. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    CAReplicatorLayer *replicatorLayer = (CAReplicatorLayer *)self.view.layer;
    replicatorLayer.instanceCount = 2;
    replicatorLayer.instanceTransform = CATransform3DMakeRotation(M_PI, 1, 0, 0);
    replicatorLayer.instanceRedOffset -= 0.1;
    replicatorLayer.instanceGreenOffset -= 0.1;
    replicatorLayer.instanceBlueOffset -= 0.1;
    replicatorLayer.instanceAlphaOffset -= 0.3;
    
}



@end
