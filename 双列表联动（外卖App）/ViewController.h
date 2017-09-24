//
//  ViewController.h
//  双列表联动（外卖App）
//
//  Created by 杭城小刘 on 2017/9/24.
//  Copyright © 2017年 杭城小刘. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,CollectionType) {
    
    CollectionType_Miss = 0,
    
    CollectionType_Wrong,
    
    CollectionType_Science
};


@interface ViewController : UIViewController

@property (nonatomic,  assign) CollectionType collectionType;

@end
