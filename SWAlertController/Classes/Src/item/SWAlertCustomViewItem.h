//
//  SWAlertCustomViewItem.h
//  SWAlertController
//
//  Created by shaowei on 2019/4/24.
//

#import <Foundation/Foundation.h>
#import "SWAlertControllerItemProtocol.h"

NS_ASSUME_NONNULL_BEGIN

/**
 使用外部传入的自定义的view
 */
@interface SWAlertCustomViewItem : NSObject<SWAlertControllerItemProtocol>

/// 顶部距离上面控件的距离，默认为0
@property (nonatomic, assign) CGFloat topSpace;

/**
 创建实例的工厂方法
 
 @param customView 用于显示的UIView
 @param height view的固定高度
 @return 实例对象
 */
+ (instancetype)customWithView:(UIView *)customView height:(CGFloat)height;

/**
 创建实例的工厂方法

 @param customView 用于显示的View，此view的高度需要需要自己使用自动布局撑起来
 @return 实例对象
 */
+ (instancetype)customWithAutoLayoutView:(UIView *)customView;

@end

NS_ASSUME_NONNULL_END
