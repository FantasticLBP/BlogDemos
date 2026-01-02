//
//  WeexViewController.m
//  WeexAPM
//
//  Created by Unix_Kernel on 12/23/25.
//

#import "WeexViewController.h"
#import <WeexSDK/WeexSDK.h>
#import <WeexSDK/WXApmForInstance.h>

@interface WeexViewController ()
@property (nonatomic, strong) WXSDKInstance *weexInstance;
@end

@implementation WeexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Weex APM";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupWeexSDK];
        
    // 2. 加载 localhost 上的 Weex 页面
    [self loadWeexPage];
}

#pragma mark - 初始化 Weex SDK
- (void)setupWeexSDK {
    
}

#pragma mark - 加载 Weex 页面
- (void)loadWeexPage {
    // 初始化 Weex 实例
    self.weexInstance = [WXSDKInstance new];
    self.weexInstance.viewController = self;
    self.weexInstance.frame = self.view.bounds;
    self.weexInstance.pageName = @"logicCalculation";
    
    // 监听 Weex 页面创建成功回调
    __weak typeof(self) weakSelf = self;
    self.weexInstance.onCreate = ^(UIView *view) {
        if (view) {
            [weakSelf.view addSubview:view];
            // 适配屏幕宽高
            view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        }
    };

    // 监听加载失败回调
    self.weexInstance.onFailed = ^(NSError *error) {
        NSLog(@"Weex渲染错误：%@", error.localizedDescription);
    };
    
    // 监听加载完成回调
    self.weexInstance.renderFinish = ^(UIView * _Nonnull view) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (view) {
           [strongSelf.view addSubview:view];
           // 打印自动生成的instanceId（仅读取）
           NSLog(@"渲染成功，instanceId：%@", strongSelf.weexInstance);
           // APM采集数据（此时instance非null，数据不会为空）
        }
    };
    
    // 核心：加载 localhost 上的 Weex JS Bundle
    // 真机测试需替换为电脑局域网 IP（如 192.168.1.100）
    NSString *weexUrl = @"http://192.168.31.246:8081/dist/index.js";
    [self.weexInstance renderWithURL:[NSURL URLWithString:weexUrl]
                             options:@{@"bundleUrl": weexUrl}
                               data:nil];
}



#pragma mark - 内存管理
- (void)dealloc {
    // 销毁 Weex 实例，避免内存泄漏
    [self.weexInstance destroyInstance];
}


@end
