//
//  SWAlertActionItem.h
//  SWAlertController
//
//  Created by shaowei on 2019/11/1.
//

#import <Foundation/Foundation.h>
#import "SWAlertControllerItemProtocol.h"

typedef NS_ENUM(NSInteger, SWAlertActionItemStyle) {
    SWAlertActionItemStyleDefault = 0,
    SWAlertActionItemStyleCancel //字体会加粗
//    SWAlertActionItemStyleDestructive
};

NS_ASSUME_NONNULL_BEGIN

/**
 代表底部的一个按钮UI；
 注意：点击按钮后会dismiss弹框，dismiss消失的动画完成后才会真正的回调handlerBlock；
 */
@interface SWAlertActionItem : NSObject<SWAlertControllerItemProtocol>

/**
 按钮
 */
@property (nonatomic, strong, readonly) UIButton *button;

/**
 标题的类型（SWAlertActionItemStyle）
 */
@property (nonatomic, assign, readonly) SWAlertActionItemStyle style;

/**
 按钮点击事件的回调block
 */
@property (nonatomic, copy, readonly) void (^ __nullable handler)(SWAlertActionItem *);

/**
 创建实例的工厂方法

 @param title 按钮的标题
 @param style 标题的类型（SWAlertActionItemStyle）
 @param handler 按钮点击事件的回调block
 @return 实例对象
 */
+ (instancetype)actionWithTitle:(nullable NSString *)title style:(SWAlertActionItemStyle)style handler:(void (^ __nullable)(SWAlertActionItem *action))handler;

/**
 是否能响应点击事件，默认YES
 
 @param enabled YES则能够响应事件
 */
- (void)setEnabled:(BOOL)enabled;

@end

NS_ASSUME_NONNULL_END
