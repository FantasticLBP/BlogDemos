
//
//  PersonInject.m
//  native-JS
//
//  Created by 刘斌鹏 on 2018/6/14.
//  Copyright © 2018年 杭城小刘. All rights reserved.
//

#import "PersonInject.h"

@implementation PersonInject

- (id)sayHi{
    return [NSString stringWithFormat:@"我叫%@，我喜欢%@",self.name,self.hobby];
}

@end
