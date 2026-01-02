//
//  WXLogicCalculationModule.m
//  WeexAPM
//
//  Created by Unix_Kernel on 12/24/25.
//

#import "WXLogicCalculationModule.h"

@implementation WXLogicCalculationModule

//WX_EXPORT_MODULE(logicCalculation)

WX_EXPORT_METHOD(@selector(add:num2:callback:))
- (void)add:(NSNumber *)num1 num2:(NSNumber *)num2 callback:(WXModuleCallback)callback {
    // 子线程执行运算，避免阻塞主线程
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        CGFloat result = [num1 floatValue] + [num2 floatValue];
        // 回调JS（参数1：返回结果，参数2：错误信息）
        if (callback) {
            callback(@{@"code": @0, @"msg": @"success", @"result": @(result)});
        }
    });
}

// 3. 暴露乘法方法给JS
WX_EXPORT_METHOD(@selector(multiply:num2:callback:))
- (void)multiply:(NSNumber *)num1 num2:(NSNumber *)num2 callback:(WXModuleCallback)callback {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        CGFloat result = [num1 floatValue] * [num2 floatValue];
        if (callback) {
            callback(@{@"code": @0, @"msg": @"success", @"result": @(result)});
        }
    });
}


@end
