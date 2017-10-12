//
//  ContactsModel.m
//  登陆动画
//
//  Created by 杭城小刘 on 2017/10/8.
//  Copyright © 2017年 杭城小刘. All rights reserved.
//

#import "ContactsModel.h"

@implementation ContactsModel


+(ContactsModel *)contactWithName:(NSString *)name phone:(NSString *)phone{
    ContactsModel *model = [[self alloc] init];
    model.name = name;
    model.phone = phone;
    return model;
}

@end
