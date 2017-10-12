//
//  AddViewController.h
//  登陆动画
//
//  Created by 杭城小刘 on 2017/10/8.
//  Copyright © 2017年 杭城小刘. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContactsModel.h"

@class AddViewController;

@protocol AddViewControllerDelegate<NSObject>

@optional

-(void)addViewController:(AddViewController *)addViewController didClickAddButtonWithContact:(ContactsModel *)model;

@end

@interface AddViewController : UIViewController

@property (nonatomic, weak) id<AddViewControllerDelegate> delegate;

@end
