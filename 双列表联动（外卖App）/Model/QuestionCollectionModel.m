//
//  QuestionCollectionModel.m
//  hzfb-patient
//
//  Created by 杭城小刘 on 2017/9/22.
//  Copyright © 2017年 杭城小刘. All rights reserved.
//

#import "QuestionCollectionModel.h"

@implementation QuestionCollectionModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"questions" : [QuestionModel class] };
}

@end
