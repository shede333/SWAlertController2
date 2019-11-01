//
//  SWAlertUIConfig.h
//  SWAlertController
//
//  Created by shaowei on 2019/11/1.
//

#import <Foundation/Foundation.h>

/**
 SWAlertController的UI配置类
 */
@interface SWAlertUIConfig : NSObject

/**
 HUB弹出框的宽度，默认270
 */
@property (nonatomic, assign) CGFloat hubWidth;

/**
 HUB弹出框的圆角半径，默认5
 */
@property (nonatomic, assign) CGFloat hubCornerRadius;

/**
 HUB弹出框m内容view的背景色
 */
@property (nonatomic, strong) UIColor *hubContentBgColor;

/**
 HUB弹出框其余部分的背景色，默认黑色(alpha=0.4)
 */
@property (nonatomic, strong) UIColor *otherBgColor;

/**
 标题Label的文字颜色
 */
@property (nonatomic, strong) UIColor *titleColor;

/**
 标题Label的字体
 */
@property (nonatomic, strong) UIFont *titleFont;

@end
