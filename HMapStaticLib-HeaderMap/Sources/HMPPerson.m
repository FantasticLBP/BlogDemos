//
//  Person.m
//  HMapStaticLib
//
//  Created by Unix_Kernel on 6/28/24.
//

#import "HMPPerson.h"
#import "HMPCat.h"

@implementation HMPPerson

- (void)work {
    NSLog(@"Person work");
}

- (void)show {
    NSLog(@"I have a cat which is named %@", self.cat.name);
}

@end
