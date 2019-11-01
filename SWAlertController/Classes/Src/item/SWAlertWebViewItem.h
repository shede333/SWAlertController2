//
//  SWAlertWebViewItem.h
//  SWAlertController
//
//  Created by shaowei on 2019/7/4.
//

#import <Foundation/Foundation.h>
#import "SWAlertControllerItemProtocol.h"

NS_ASSUME_NONNULL_BEGIN

/**
 内部使用webview来加载html内容
 */
@interface SWAlertWebViewItem : NSObject<SWAlertControllerItemProtocol>

/**
 创建实例的工厂方法

 @param urlStr (可选)webview需要加载的url网址，如果为空则不加载url
 @param height webview的高度
 @param clickURLHandler 点击webview上的url超链接的回调；如果处理了url，则返回YES
 @return 实例对象
 */
+ (instancetype)webviewWithURL:(NSString *)urlStr height:(CGFloat)height clickURLHandler:(BOOL (^ __nullable)(NSURL *url))clickURLHandler;

/**
 加载url请求

 @param urlStr url字符串，例如: https://www.baidu.com
 */
- (void)loadRequest:(NSString *)urlStr;

/**
 加载html字符串

 @param htmlString html字符串
 */
- (void)loadHTMLString:(NSString *)htmlString;

/**
 加载htmlFilePath路径里的html内容

 @param htmlFilePath 文件路径
 */
- (void)loadHTMLWithFilePath:(NSString *)htmlFilePath;

//- (void)setViewHeight:(CGFloat)height;

@end

NS_ASSUME_NONNULL_END
