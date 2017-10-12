//
//  ContactsModel.h
//  登陆动画
//
//  Created by 杭城小刘 on 2017/10/8.
//  Copyright © 2017年 杭城小刘. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContactsModel : NSObject

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *phone;

+(ContactsModel *)contactWithName:(NSString *)name phone:(NSString *)phone;



@end
