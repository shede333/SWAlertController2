//
//  SWAlertController.h
//  SWAlertController
//
//  Created by shaowei on 2019/11/1.
//

#import <UIKit/UIKit.h>
#import "SWAlertActionItem.h"
#import "SWAlertUIConfig.h"
#import "SWAlertControllerItemProtocol.h"

NS_ASSUME_NONNULL_BEGIN

/**
 Alert弹框，参考的“UIAlertController”设计的，但是支持的功能更多
 */
@interface SWAlertController : UIViewController

/**
 创建实例的工厂方法（使用alert弹框的UI配置）
 
 @param title alert弹框的顶部标题
 @return 实例对象
 */
+ (instancetype)alertControllerWithTitle:(nullable NSString *)title;

/**
 创建实例的工厂方法

 @param title alert弹框的顶部标题
 @param uiConfig alert弹框的UI配置
 @return 实例对象
 */
+ (instancetype)alertControllerWithTitle:(nullable NSString *)title uiConfig:(nullable SWAlertUIConfig *)uiConfig;

/**
 底部增加一个点击按钮

 @param action SWAlertActionItem
 */
- (void)addAction:(SWAlertActionItem *)action;

/**
 增加控件（实现了SWAlertControllerItemProtocol协议）

 @param itemWidget 实现了SWAlertControllerItemProtocol协议的控件
 */
- (void)addWidgetItem:(id<SWAlertControllerItemProtocol>)itemWidget;

@end

NS_ASSUME_NONNULL_END
