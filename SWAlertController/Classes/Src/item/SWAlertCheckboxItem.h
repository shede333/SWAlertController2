//
//  SWAlertCheckboxItem.h
//  SWAlertController
//
//  Created by shaowei on 2019/11/1.
//

#import <Foundation/Foundation.h>
#import "SWAlertControllerItemProtocol.h"

NS_ASSUME_NONNULL_BEGIN
/**
 代表一个【复选框】UI
 */
@interface SWAlertCheckboxItem : NSObject<SWAlertControllerItemProtocol>

/// 顶部距离上面控件的距离，默认为0
@property (nonatomic, assign) CGFloat topSpace;

/**
 显示内容的Button
 */
@property (nonatomic, strong, readonly) UIButton *checkboxBtn;

/**
 【复选框】选中按钮的点击回调block
 */
@property (nonatomic, copy, readonly) void (^ __nullable handler)(BOOL);

/**
 创建实例的工厂方法

 @param title 【复选框】的标题
 @param isSelected 【复选框】的初始选中状态
 @param normalImage 【复选框】没有选中时的图片
 @param selectedImage 【复选框】被选中时的图片
 @param handler 【复选框】按钮的点击事件回调block
 @return 实例对象
 */
+ (instancetype)checkboxWithTitle:(NSString *)title isSelected:(BOOL)isSelected normalImage:(UIImage *)normalImage selectedImage:(UIImage *)selectedImage handler:(void (^ __nullable)(BOOL isSelected))handler;


@end

NS_ASSUME_NONNULL_END
