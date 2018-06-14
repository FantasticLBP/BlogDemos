//
//  PersonInject.h
//  native-JS
//
//  Created by 刘斌鹏 on 2018/6/14.
//  Copyright © 2018年 杭城小刘. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol PersonInjectExport<JSExport>

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *hobby;

- (id)sayHi;

@end


@interface PersonInject : NSObject<PersonInjectExport>

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *hobby;

- (id)sayHi;

@end
