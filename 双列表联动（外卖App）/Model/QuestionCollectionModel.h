//
//  QuestionCollectionModel.h
//  hzfb-patient
//
//  Created by 杭城小刘 on 2017/9/22.
//  Copyright © 2017年 杭城小刘. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYModel.h"
#import "QuestionModel.h"

@interface QuestionCollectionModel : NSObject

@property (nonatomic, strong) NSArray<QuestionModel *> *questions;

///孕周
@property (nonatomic, assign) NSInteger tag;

@end
