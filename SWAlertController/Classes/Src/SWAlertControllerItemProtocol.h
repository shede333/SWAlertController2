//
//  SWAlertControllerItemProtocol.h
//  SWAlertController
//
//  Created by shaowei on 2019/5/10.
//  Copyright © 2019 OKCoin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class SWAlertController;

/**
 SWAlertController的item控件需要实现的协议
 */
@protocol SWAlertControllerItemProtocol <NSObject>

@required

/**
 获取：用于显示的view

 @return 用于显示的view
 */
- (UIView *)view;

@optional

/**
 设置block，此block用于获取SWAlertController对象

 @param block 用于获取SWAlertController对象的block
 */
- (void)setAlertCtrlGetterBlock:(SWAlertController * (^)(void))block;

/**
 获取：view距离上面👆控件的顶部空间大小
 不实现此协议，则使用默认值0

 @return view距离上面控件的顶部空间大小
 */
- (CGFloat)topSpace;

/**
 获取：view距离父view左边👈空间大小
 不实现此协议，则使用默认值15

 @return view距离父view左边👈空间大小
 */
- (CGFloat)leftSpace;

/**
 获取：view距离父view右边👉空间大小
 不实现此协议，则使用默认值15
 
 @return view距离父view右边👉空间大小
 */
- (CGFloat)rightSpace;

@end

NS_ASSUME_NONNULL_END
