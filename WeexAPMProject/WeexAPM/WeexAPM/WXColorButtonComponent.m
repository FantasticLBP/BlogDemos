//
//  WXColorButtonComponent.m
//  WeexAPM
//
//  Created by Unix_Kernel on 12/24/25.
//

// WXColorButtonComponent.m
#import "WXColorButtonComponent.h"

@implementation WXColorButtonComponent

// 【关键修改1】重写loadView方法创建自定义视图（替代直接赋值self.view）
- (UIView *)loadView {
    // 1. 创建原生按钮（这是view的真正创建入口）
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.layer.cornerRadius = 8; // 圆角
    button.clipsToBounds = YES;
    
    // 2. 绑定点击事件（JS侧的click事件）
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    return button; // 返回创建的视图，Weex会自动赋值给self.view
}

// 【关键修改2】初始化方法仅处理参数，不再创建view
- (instancetype)initWithRef:(NSString *)ref
                      type:(NSString *)type
                    styles:(NSDictionary *)styles
                 attributes:(NSDictionary *)attributes
                     events:(NSArray *)events
               weexInstance:(WXSDKInstance *)weexInstance {
    if (self = [super initWithRef:ref type:type styles:styles attributes:attributes events:events weexInstance:weexInstance]) {
        // 初始化时暂存属性，等待view创建后在viewDidLoad中处理
        // （loadView执行后会调用viewDidLoad）
    }
    return self;
}

// 【关键修改3】在viewDidLoad中处理属性（view已创建完成）
- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *button = (UIButton *)self.view; // 此时self.view已由loadView创建完成
    
    // 处理JS传入的属性（文本、背景色）
    // 文本
    NSString *title = [self _getAttribute:@"title" defaultValue:@"默认按钮"];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    // 背景色
    NSString *bgColor = [self _getAttribute:@"bgColor" defaultValue:@"#FF6600"];
    [button setBackgroundColor:[self _hexColor:bgColor]];
}

// 布局适配（无修改）
- (void)layoutDidFinish {
    [super layoutDidFinish];
    self.view.frame = self.calculatedFrame; // 应用Weex计算的布局
}

// 属性更新（无修改，仅确认view类型）
- (void)updateAttributes:(NSDictionary *)attributes {
    [super updateAttributes:attributes];
    UIButton *button = (UIButton *)self.view;
    // 更新文本
    if (attributes[@"title"]) {
        [button setTitle:attributes[@"title"] forState:UIControlStateNormal];
    }
    // 更新背景色
    if (attributes[@"bgColor"]) {
        [button setBackgroundColor:[self _hexColor:attributes[@"bgColor"]]];
    }
}

// 辅助：获取属性（无修改）
- (NSString *)_getAttribute:(NSString *)key defaultValue:(NSString *)defaultValue {
    return self.attributes[key] ?: defaultValue;
}

// 辅助：16进制颜色转UIColor（无修改）
- (UIColor *)_hexColor:(NSString *)hexStr {
    hexStr = [hexStr stringByReplacingOccurrencesOfString:@"#" withString:@""];
    if (hexStr.length != 6) return [UIColor orangeColor];
    
    unsigned int rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexStr];
    [scanner scanHexInt:&rgbValue];
    
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0
                           green:((rgbValue & 0xFF00) >> 8)/255.0
                            blue:(rgbValue & 0xFF)/255.0
                           alpha:1.0];
}

// 按钮点击事件（无修改）
- (void)buttonClicked:(UIButton *)button {
    [self fireEvent:@"click" params:@{@"msg": @"按钮被点击", @"title": button.titleLabel.text}];
}

@end
