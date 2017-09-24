//
//  PregnancyPeriodCell.m
//  hzfb-patient
//
//  Created by 杭城小刘 on 2017/9/22.
//  Copyright © 2017年 杭城小刘. All rights reserved.
//

#import "PregnancyPeriodCell.h"
#import "UIColor+FlatUI.h"

@interface PregnancyPeriodCell()

@property (nonatomic, strong) UILabel *numLabel;

@property (nonatomic, strong) UILabel *unitLabel;

@property (nonatomic, strong) UIView *lineView;

@end

@implementation PregnancyPeriodCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    [self.contentView addSubview:self.numLabel];
    [self.contentView addSubview:self.unitLabel];
    [self.contentView addSubview:self.lineView];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.numLabel.frame = CGRectMake(0, 15, self.frame.size.width, 30);
    self.unitLabel.frame = CGRectMake(0, 45, self.frame.size.width, self.frame.size.height - 15 - 30);
    self.lineView.frame = CGRectMake(self.frame.size.width - 3, 19, 3, self.frame.size.height - 2 *19);
}

-(void)setSelected:(BOOL)selected animated:(BOOL)animated{
    [super setSelected:selected animated:animated];
    self.contentView.backgroundColor = selected ? [UIColor colorFromHexCode:@"fef5f5"] : [UIColor whiteColor];
    self.numLabel.textColor =  selected ? [UIColor colorFromHexCode:@"fd688a"] : [UIColor colorFromHexCode:@"808080"];
    self.unitLabel.textColor = selected ? [UIColor colorFromHexCode:@"fd688a"] : [UIColor colorFromHexCode:@"cccccc"];
    self.lineView.backgroundColor = [UIColor colorFromHexCode:@"fd688a"];
    self.lineView.hidden = !selected;
}




#pragma mark -- setter
-(void)setWeek:(NSInteger)week{
    _week = week;
    self.numLabel.text = [NSString stringWithFormat:@"%zd",week];
}

#pragma mark -- lazy load
-(UILabel *)numLabel{
    if (!_numLabel) {
        _numLabel = [UILabel new];
        _numLabel.textAlignment = NSTextAlignmentCenter;
        _numLabel.font = [UIFont systemFontOfSize:17];
        _numLabel.textColor = [UIColor colorFromHexCode:@"808080"];
    }
    return _numLabel;
}

-(UILabel *)unitLabel{
    if (!_unitLabel) {
        _unitLabel = [UILabel new];
        _unitLabel.textAlignment = NSTextAlignmentCenter;
        _unitLabel.font = [UIFont systemFontOfSize:13];
        _unitLabel.textColor = [UIColor colorFromHexCode:@"cccccc"];
        _unitLabel.text = @"孕周";
    }
    return _unitLabel;
}

-(UIView *)lineView{
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = [UIColor colorFromHexCode:@"fd688a"];
    }
    return _lineView;
}

@end
