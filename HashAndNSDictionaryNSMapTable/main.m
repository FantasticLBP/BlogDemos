//
//  main.m
//  HashAndNSDictionaryNSMapTable
//
//  Created by Unix_Kernel on 7/9/24.
//  Copyright © 2024 杭城小刘. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Worker : NSObject<NSCopying>
@property (nonatomic, copy) NSString *name;

- (instancetype)initWithName:(NSString *)name;
@end

@implementation Worker
- (instancetype)initWithName:(NSString *)name {
    if (self = [super init]) {
        _name = name;
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    Worker *p = [[self class] allocWithZone:zone];
    p.name = self.name;
    return p;
}
@end



int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Worker *person1 = [[Worker alloc] initWithName:@"张三"];
        Worker *person2 = [[Worker alloc] initWithName:@"李四"];
        Worker *person3 = [[Worker alloc] initWithName:@"王麻子"];
        NSLog(@"person1 - %@, person2 - %@, person3 - %@", person1, person2, person3);

        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:0];
        NSMapTable *table1 = [[NSMapTable alloc] initWithKeyOptions:NSPointerFunctionsWeakMemory valueOptions:NSPointerFunctionsStrongMemory capacity:2];
        NSMapTable *table2 = [[NSMapTable alloc] initWithKeyOptions:NSPointerFunctionsCopyIn valueOptions:NSPointerFunctionsStrongMemory capacity:2];

        Worker *p1 = [[Worker alloc] initWithName:@"Key"];
        NSLog(@"Before p1 - %@", p1);
        [dic setObject:@[person1, person2] forKey:p1];
        NSLog(@"After p1 - %@", p1);

        [dic setObject:@[person1, person2, person3] forKey:p1];

        [table1 setObject:@[person1, person2] forKey:p1];
        [table1 setObject:@[person1, person2, person3] forKey:p1];

        [table2 setObject:@[person1, person2] forKey:p1];
        [table2 setObject:@[person1, person2, person3] forKey:p1];

        NSLog(@"%@", dic);
        NSLog(@"%@", table1);
        NSLog(@"%@", table2);
        
        /*
        id rs = [NSObject valueForKey:@"isa"];
        NSLog(@"%@", rs);
        */
    }
    return 0;
}
