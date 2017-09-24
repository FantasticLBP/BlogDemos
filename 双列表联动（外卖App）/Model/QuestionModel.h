//
//  QuestionModel.h
//  hzfb-patient
//
//  Created by 杭城小刘 on 2017/9/4.
//  Copyright © 2017年 杭城小刘. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYModel.h"


@interface QuestionModel : NSObject

@property (nonatomic, assign) NSInteger questionId;

@property (nonatomic, assign) NSInteger dueDay;

@property (nonatomic, assign) NSInteger dueWeek;

@property (nonatomic, strong) NSString *question;

@property (nonatomic, strong) NSString *source;

@property (nonatomic, strong) NSString *a;

@property (nonatomic, strong) NSString *aHint;

@property (nonatomic, strong) NSString *b;

@property (nonatomic, strong) NSString *bHint;

@property (nonatomic, strong) NSString *c;

@property (nonatomic, strong) NSString *cHint;

@property (nonatomic, strong) NSString *d;

@property (nonatomic, strong) NSString *dHint;

@property (nonatomic, assign) NSInteger rightAnswer;

@property (nonatomic, assign) NSInteger status;
















@end
