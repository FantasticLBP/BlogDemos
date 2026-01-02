//
//  Person.h
//  HMapStaticLib
//
//  Created by Unix_Kernel on 6/28/24.
//

#import <Foundation/Foundation.h>
#import "HSPCat.h"

NS_ASSUME_NONNULL_BEGIN

@interface HSPPerson : NSObject

@property (nonatomic, strong) HSPCat *cat;

- (void)show;

@end

NS_ASSUME_NONNULL_END
