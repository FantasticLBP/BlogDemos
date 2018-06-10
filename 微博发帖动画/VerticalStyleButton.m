//
//  verticalStyleButton.m
//  微博发帖动画
//
//  Created by 刘斌鹏 on 2018/6/10.
//  Copyright © 2018年 杭城小刘. All rights reserved.
//

#import "verticalStyleButton.h"

@implementation VerticalStyleButton

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self setupUI];
}

- (void)setupUI{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.imageView.contentMode = UIViewContentModeCenter;
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}

//去掉点击高亮效果
-(void)setHighlighted:(BOOL)highlighted{
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.imageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height *0.8);
    self.titleLabel.frame = CGRectMake(0, self.frame.size.height *0.8, self.frame.size.width, self.frame.size.height *0.2);
}

@end
