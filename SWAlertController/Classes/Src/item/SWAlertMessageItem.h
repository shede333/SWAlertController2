//
//  SWAlertMessageItem.h
//  SWAlertController
//
//  Created by shaowei on 2019/11/1.
//

#import <Foundation/Foundation.h>
#import "SWAlertControllerItemProtocol.h"

NS_ASSUME_NONNULL_BEGIN
/**
 代表多行提示文案UI；默认不响应点击事件（即enabled=NO）
 注意：isDismissWhenClick=YES && enabled=YES时，点击Message后会dismiss弹框；
 */
@interface SWAlertMessageItem : NSObject<SWAlertControllerItemProtocol>

/// 顶部距离上面控件的距离，默认为0
@property (nonatomic, assign) CGFloat topSpace;

/**
 显示内容的Label；
 默认13号字体，字体颜色：SWColor_Title
 */
@property (nonatomic, strong, readonly) UILabel *label;

/**
 点击Message后，是否会dismiss弹框（enable=YES才会有效）；默认值NO
 */
@property (nonatomic, assign) BOOL isDismissWhenClick;

/**
 label的最大高度，当超过最大高度时，会保持maxHeight变成scrollView的形式；默认值200；
 */
@property (nonatomic, assign) CGFloat maxHeight;

/**
 点击Message文案的回调block
 */
@property (nonatomic, copy, readonly) void (^ __nullable handler)(SWAlertMessageItem *);

/**
 创建实例的工厂方法

 @param text 文案详情
 @param handler 点击Message文案的回调block
 @return 实例对象
 */
+ (instancetype)messageWithText:(NSString *)text handler:(void (^ __nullable)(SWAlertMessageItem *item))handler;

/**
 是否能响应点击事件，默认YES

 @param enabled YES则能够响应事件
 */
- (void)setEnabled:(BOOL)enabled;

@end

NS_ASSUME_NONNULL_END
