//
//  SWAlertKVContentItem.h
//  SWAlertController
//
//  Created by shaowei on 2019/11/1.
//

#import <Foundation/Foundation.h>
#import "SWAlertControllerItemProtocol.h"

NS_ASSUME_NONNULL_BEGIN
/**
 表示一行有两个Label（“title, detail”）的UI
 */
@interface SWAlertKVContentItem : NSObject<SWAlertControllerItemProtocol>

/// 顶部距离上面控件的距离，默认为0
@property (nonatomic, assign) CGFloat topSpace;

/**
 左边的标题Label
 */
@property (nonatomic, strong, readonly) UILabel *titleLabel;

/**
 右边的内容Label
 */
@property (nonatomic, strong, readonly) UILabel *detailLabel;

/**
 创建实例的工厂方法

 @param title 标题label的内容
 @param detail 详情label的内容
 @return 实例对象
 */
+ (instancetype)kvContentWithTitle:(NSString *)title detail:(NSString *)detail;

/**
 设置detailLabelj距左边的空间大小，默认125

 @param offset detailLabelj距左边的空间大小
 */
- (void)setDetailLabelToLeftOffset:(CGFloat)offset;

@end

NS_ASSUME_NONNULL_END
