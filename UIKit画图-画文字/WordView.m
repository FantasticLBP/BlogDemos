
//
//  WordView.m
//  UIKit画图-画文字
//
//  Created by 杭城小刘 on 2017/10/17.
//  Copyright © 2017年 杭城小刘. All rights reserved.
//

#import "WordView.h"

@implementation WordView

-(void)drawRect:(CGRect)rect{

    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:60];
    dict[NSBackgroundColorAttributeName] = [UIColor yellowColor];
    dict[NSForegroundColorAttributeName] = [UIColor blackColor];
    dict[NSStrokeColorAttributeName] = [UIColor redColor];
    dict[NSStrokeWidthAttributeName] = @3.0;
    
    //设置阴影效果
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowOffset = CGSizeMake(10, 10);
    shadow.shadowColor = [UIColor brownColor];
    shadow.shadowBlurRadius = 1;
    dict[NSShadowAttributeName] = shadow;
    
    [self.word drawAtPoint:CGPointZero withAttributes:dict];
}

-(void)setWord:(NSString *)word{
    _word = word;
    [self setNeedsDisplay];
}

@end
