//
//  VCView.m
//  手势解锁
//
//  Created by 杭城小刘 on 2017/10/27.
//  Copyright © 2017年 杭城小刘. All rights reserved.
//

#import "VCView.h"
#import "GestureView.h"

@interface VCView()

@property (nonatomic, strong) GestureView *bgView;

@end

@implementation VCView

-(void)drawRect:(CGRect)rect{
    UIImage *image = [UIImage imageNamed:@"Home_refresh_bg"];
    [image drawInRect:rect];
}


-(void)awakeFromNib{
    [super awakeFromNib];
    [self addSubview:self.bgView];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.bgView.frame = CGRectMake((self.frame.size.width - BGViewWidth)/2, (self.frame.size.height - BGViewWidth)/2, BGViewWidth, BGViewWidth);
}



#pragma mark -- lazy load

-(GestureView *)bgView{
    if (!_bgView) {
        _bgView = [GestureView new];
        _bgView.backgroundColor = [UIColor clearColor];
    }
    return _bgView;
}

@end
