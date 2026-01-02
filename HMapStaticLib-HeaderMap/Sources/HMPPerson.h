//
//  Person.h
//  HMapStaticLib
//
//  Created by Unix_Kernel on 6/28/24.
//

#import <Foundation/Foundation.h>
#import "HMPCat.h"

NS_ASSUME_NONNULL_BEGIN

@interface HMPPerson : NSObject

@property (nonatomic, strong) HMPCat *cat;

- (void)show;

@end

NS_ASSUME_NONNULL_END
