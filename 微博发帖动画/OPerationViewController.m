
//
//  OPerationViewController.m
//  微博发帖动画
//
//  Created by 刘斌鹏 on 2018/6/10.
//  Copyright © 2018年 杭城小刘. All rights reserved.
//

#import "OPerationViewController.h"
#import "MuneItem.h"
#import "VerticalStyleButton.h"

#define BoundWith [UIScreen mainScreen].bounds.size.width
#define BoundHeight [UIScreen mainScreen].bounds.size.height


@interface OPerationViewController ()
@property (nonatomic, strong) NSMutableArray *btnArray;
@property(nonatomic, strong) NSTimer *timer;
@property(nonatomic,assign) int btnIndex;

@end

@implementation OPerationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupUI];
    //添加定时器
    self.timer =  [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(update) userInfo:nil repeats:YES];
}

- (void)setupUI{
    
    CGFloat btnWH = 100;
    
    int cloumn = 3;
    CGFloat margin = ([UIScreen mainScreen].bounds.size.width - cloumn * btnWH) / (cloumn + 1);
    CGFloat x = 0;
    CGFloat y = 0;
    int curCloumn = 0;
    int curRow = 0;
    CGFloat oriY = 300;
    
    for(int i = 0 ;i < self.items.count; i++){
        
        VerticalStyleButton *btn = [VerticalStyleButton buttonWithType:UIButtonTypeCustom];
        //当前所在的列
        curCloumn = i % cloumn;
        //当前所在的行
        curRow = i / cloumn;
        
        x = margin + (btnWH + margin) * curCloumn;
        y =(btnWH + margin) * curRow + oriY;
        btn.frame = CGRectMake(x, y, btnWH, btnWH);
        
        MuneItem *item = self.items[i];
        //设置按钮图片
        [btn setImage:item.image forState:UIControlStateNormal];
        //设置按钮的文字
        [btn setTitle:item.title forState:UIControlStateNormal];
        
        [self.view addSubview:btn];
        //开始时让所有按钮都移动到最底部
        btn.transform = CGAffineTransformMakeTranslation(0, self.view.bounds.size.height);
        [self.btnArray addObject:btn];
        
        //监听按钮点击
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        [btn addTarget:self action:@selector(btnClick1:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.frame = CGRectMake(BoundWith/2 - 30/2,BoundHeight - 50 , 30, 30);
    [cancelButton setImage:[UIImage imageNamed:@"tabbar_compose_background_icon_close"] forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(closeCurrentPage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelButton];
}

- (void)update{
    if (self.btnIndex == self.btnArray.count) {
        [self.timer invalidate];
        return ;
    }
    
    VerticalStyleButton *button = self.btnArray[self.btnIndex];
    //弹簧动画
    [UIView animateWithDuration:0.3 delay:0.2 usingSpringWithDamping:0.8 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
        button.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
       
    }];
     self.btnIndex++;
}


- (void)btnClick:(UIButton *)button{
    [UIView animateWithDuration:0.25 animations:^{
        button.transform = CGAffineTransformMakeScale(1.2, 1.2);
    }];
}

- (void)btnClick1:(UIButton *)button{
    [UIView animateWithDuration:0.25 animations:^{
        button.alpha = 0;
        button.transform = CGAffineTransformMakeScale(2, 2);
    }];
}

- (void)closeCurrentPage{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark -- setter && getter

-(NSMutableArray *)btnArray{
    
    if (_btnArray == nil) {
        _btnArray = [NSMutableArray array];
    }
    return _btnArray;
}
@end
