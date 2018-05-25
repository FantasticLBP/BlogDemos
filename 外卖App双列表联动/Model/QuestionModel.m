//
//  QuestionModel.m
//  hzfb-patient
//
//  Created by 杭城小刘 on 2017/9/4.
//  Copyright © 2017年 杭城小刘. All rights reserved.
//

#import "QuestionModel.h"

@implementation QuestionModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"questionId" : @"id"};
}

@end
