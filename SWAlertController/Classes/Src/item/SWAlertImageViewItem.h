//
//  SWAlertImageViewItem.h
//  SWAlertController
//
//  Created by shaowei on 2019/10/28.
//

#import <Foundation/Foundation.h>
#import "SWAlertControllerItemProtocol.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, SWAIVIImageAlignment) {
    SWAIVIImageAlignmentHCenter = 0, //水平居中
    SWAIVIImageAlignmentHLeft, //水平居左
    SWAIVIImageAlignmentHRight, //水平居右
};

/// 代表一张图片的item，支持水平居中、居左、居右布局，可以响应点击事件
@interface SWAlertImageViewItem : NSObject<SWAlertControllerItemProtocol>

/// UIImageView，可以设置一些其他属性
@property (nonatomic, strong, readonly) UIImageView *imageView;

/// 点击Image后，是否会dismiss弹框（enable=YES才会有效）；默认值NO
@property (nonatomic, assign) BOOL isDismissWhenClickImage;

/// （推荐）初始化方法，默认居中布局
/// @param image UIImage
/// @param handler 点击image后的响应block（注意：默认不会调用dismiss方法）
+ (instancetype)imageViewWithImage:(UIImage *)image handler:(void (^ __nullable)(SWAlertImageViewItem *item))handler;

/// 更新image
/// @param image UIImage
- (void)updateImage:(UIImage *)image;

/// 更新image的布局方式，相当于edgeInsets为UIEdgeInsetsZero
/// @param imageAlignment SWAIVIImageAlignment
- (void)updateImageAlignment:(SWAIVIImageAlignment)imageAlignment ;

/// 更新image的布局方式
/// @param imageAlignment SWAIVIImageAlignment
/// @param edgeInsets 边缘大小；居中时，支持top,bottom; 居左时，支持left,top,bottom; 居右时，支持right,top,bottom;
- (void)updateImageAlignment:(SWAIVIImageAlignment)imageAlignment edgeInsets:(UIEdgeInsets)edgeInsets;

@end

NS_ASSUME_NONNULL_END
