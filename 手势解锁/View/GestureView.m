//
//  GestureView.m
//  手势解锁
//
//  Created by 杭城小刘 on 2017/10/29.
//  Copyright © 2017年 杭城小刘. All rights reserved.
//

#import "GestureView.h"

//c语言的枚举值需要以K开头
@interface GestureView()

@property (nonatomic, strong) NSMutableArray *selectedButttons;

@property (nonatomic, assign) CGPoint freePoint;

@end

@implementation GestureView


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    CGFloat btnWH = 80;
    int columns = 3;
    int rows = 3;
    
    
    for (int i=0; i<9; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat x = (i%3)*btnWH +  (i%3)*((BGViewWidth- columns * btnWH)/2) ;
        CGFloat y = (i/3)*btnWH +  (i/3)*((BGViewWidth- rows * btnWH)/2) ;
        button.frame = CGRectMake(x, y, btnWH, btnWH);
        button.tag = i;
        [button setImage:[UIImage imageNamed:@"gesture_node_normal"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"gesture_node_highlighted"] forState:UIControlStateSelected];
        button.userInteractionEnabled = NO;
        [self
         addSubview:button];
    }
    
    
}


-(void)awakeFromNib{
    [super awakeFromNib];
    [self setupUI];
}

-(void)drawRect:(CGRect)rect{
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    if (self.selectedButttons.count <= 0) {
        return ;
    }
    for (NSUInteger index = 0; index < self.selectedButttons.count; index++) {
        UIButton *button = self.selectedButttons[index];
        if (index == 0) {
            [path moveToPoint:button.center];
        }else{
            [path addLineToPoint:button.center];
        }
    }
    [path addLineToPoint:self.freePoint];
    
    [[UIColor greenColor] set];
    [path setLineWidth:10];
    [path setLineJoinStyle:kCGLineJoinRound];
    [path stroke];
}




//需求：手指移到按钮上或滑过的时候按钮要有颜色区分
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint currentPoint = [self touchPointInCurrentView:touches];
    UIButton *button = [self btnRectContainsPoint:currentPoint];
    if (button) {
        button.selected = YES;
        [self.selectedButttons addObject:button];
    }
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint currentPoint = [self touchPointInCurrentView:touches];
    UIButton *button = [self btnRectContainsPoint:currentPoint];
    self.freePoint = currentPoint;
    if (button && !button.selected) {
        button.selected = YES;
        [self.selectedButttons addObject:button];
    }
    [self setNeedsDisplay];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSMutableString *string = [NSMutableString string];
    for (UIButton *button in self.selectedButttons) {
        [string appendString:[NSString stringWithFormat:@"%zd",button.tag]];
        button.selected = NO;
    }
    NSLog(@"选中的是->%@",string);
    [self.selectedButttons removeAllObjects];
    [self setNeedsDisplay];
}

#pragma mark -- private method

//拆分函数：按照函数的功能划分

-(CGPoint)touchPointInCurrentView:(NSSet *)touches{
    UITouch *touch = [touches anyObject];
    return [touch locationInView:self];
}

-(UIButton *)btnRectContainsPoint:(CGPoint)point{
    for (UIButton *button in self.subviews) {
        if (CGRectContainsPoint(button.frame, point)) {
            return button;
        }
    }
    return nil;
}

#pragma mark -- lazy load

-(NSMutableArray *)selectedButttons{
    if (!_selectedButttons) {
        _selectedButttons = [NSMutableArray array];
    }
    return _selectedButttons;
}


@end
