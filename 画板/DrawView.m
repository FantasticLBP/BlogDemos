

//
//  DrawView.m
//  画板
//
//  Created by 杭城小刘 on 2017/12/11.
//  Copyright © 2017年 杭城小刘. All rights reserved.
//

#import "DrawView.h"
#import "MyBezierPath.h"


@interface DrawView()

@property (nonatomic, strong) NSMutableArray *paths;

@property (nonatomic, strong) MyBezierPath *path;

@property (nonatomic, assign) CGFloat lineWidth;

@property (nonatomic, strong) UIColor *lineColor;

@end

@implementation DrawView

-(void)awakeFromNib{
    [super awakeFromNib];
    
    self.lineColor = [UIColor blackColor];
    self.lineWidth = 5;
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [self addGestureRecognizer:panGesture];
}

-(void)panAction:(UITapGestureRecognizer *)gesture{
    
    CGPoint currentPoint = [gesture locationInView:self];
    
    if (gesture.state == UIGestureRecognizerStateBegan) {
        MyBezierPath *path = [MyBezierPath bezierPath];
        self.path = path;
        [self.paths addObject:self.path];
    
        path.color = self.lineColor;
        
        [self.path setLineWidth:self.lineWidth];
        
        [self.path moveToPoint:currentPoint];
        
    }else if(gesture.state == UIGestureRecognizerStateChanged){
        [self.path addLineToPoint:currentPoint];
        [self setNeedsDisplay];
    }
    
}


-(void)drawRect:(CGRect)rect{
    //取出所有的路径来画线
    for (MyBezierPath *path in self.paths) {
        if ([path isKindOfClass:[UIImage class]]) {
            UIImage *image = (UIImage *)path;
            [image drawInRect:rect];
        }else{
            [path.color set];
            [path stroke];
        }
        
    }
}

#pragma mark -- setter

-(void)setImage:(UIImage *)image{
    _image = image;
    [self.paths addObject:image];
    [self setNeedsDisplay];
}

#pragma mark -- public method

//清屏
-(void)clearScreen{
    [self.paths removeAllObjects];
    [self setNeedsDisplay];
    
}

//撤销
-(void)revoke{
    [self.paths removeLastObject];
    [self setNeedsDisplay];
}

//橡皮擦
-(void)erease{
    self.lineColor = [UIColor whiteColor];
}

//设置颜色
-(void)setPenColor:(UIColor *)color{
    self.lineColor = color;
    [self setNeedsDisplay];
}

//设置线条宽度
-(void)setPenWidth:(CGFloat)width{
    self.lineWidth = width;
    [self setNeedsDisplay];
}

#pragma mark -- lazy load

-(NSMutableArray *)paths{
    if (!_paths) {
        _paths = [NSMutableArray array];
    }
    return _paths;
}

-(UIBezierPath *)path{
    if (!_path) {
        _path = [UIBezierPath bezierPath];
    }
    return _path;
}


@end
