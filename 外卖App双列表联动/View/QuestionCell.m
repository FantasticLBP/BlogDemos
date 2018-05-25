
//
//  QuestionCell.m
//  hzfb-patient
//
//  Created by 杭城小刘 on 2017/9/22.
//  Copyright © 2017年 杭城小刘. All rights reserved.
//

#import "QuestionCell.h"
#import "UIColor+FlatUI.h"

@interface QuestionCell()

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UILabel *questionLabel;

@property (nonatomic, strong) UILabel *periodLabel;

@property (nonatomic, strong) UIView *line;

@end

@implementation QuestionCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    [self addSubview:self.bgView];
    [self addSubview:self.line];
    [self.bgView addSubview:self.questionLabel];
    [self.bgView addSubview:self.periodLabel];
}

-(void)setModel:(QuestionModel *)model{
    _model = model;
    self.periodLabel.text = [NSString stringWithFormat:@"孕%zd周%zd天",model.dueWeek,(model.dueDay % 7)];
    self.questionLabel.text = model.question;
}





-(void)layoutSubviews{
    self.bgView.frame = CGRectMake(10, 10, self.frame.size.width - 20, self.frame.size.height - 10);
    
    self.line.frame = CGRectMake(0, 0, 1, self.frame.size.height);
    
    self.questionLabel.frame = CGRectMake(14, 5, self.frame.size.width - 20 - 14  - 14, 21);
    
    self.periodLabel.frame = CGRectMake(14, 30, self.frame.size.width - 20 - 14  - 14, 21);
}



#pragma mark -- lazy load

-(UIView *)bgView{
    if (!_bgView) {
        _bgView = [UIView new];
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.layer.borderWidth = 1;
        _bgView.layer.borderColor = [UIColor colorFromHexCode:@"e6e6e6"].CGColor;
        _bgView.layer.cornerRadius = 8;
        _bgView.layer.masksToBounds = YES;
    }
    return _bgView;
}

-(UILabel *)questionLabel{
    if (!_questionLabel) {
        _questionLabel = [UILabel new];
        _questionLabel.textColor = [UIColor blackColor];
        _questionLabel.font = [UIFont systemFontOfSize:15];
        _questionLabel.textAlignment = NSTextAlignmentLeft;
        _questionLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _questionLabel;
}

-(UILabel *)periodLabel{
    if (!_periodLabel) {
        _periodLabel = [UILabel new];
        _periodLabel.textColor = [UIColor colorFromHexCode:@"cccccc"];
        _periodLabel.font = [UIFont systemFontOfSize:14];
        _periodLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _periodLabel;
}

-(UIView *)line{
    if (!_line) {
        _line = [UIView new];
        _line.backgroundColor = [UIColor colorFromHexCode:@"e6e6e6"];
    }
    return _line;
}

@end
