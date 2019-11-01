//
//  SWAlertWebViewItem.m
//  SWAlertController
//
//  Created by shaowei on 2019/7/4.
//

#import "SWAlertWebViewItem.h"

#import <WebKit/WebKit.h>
#import <YYKit/YYKit.h>
#import <Masonry/Masonry.h>

@interface SWAlertWebViewItem()<WKNavigationDelegate>

@property (nonatomic, strong) UIView *view;
@property (nonatomic, strong) WKWebView *wkWebView;
@property (nonatomic, strong) UIActivityIndicatorView *loadingView;

@property (nonatomic, copy) BOOL (^ __nullable clickURLHandlerBlock)(NSURL *url);

@end

@implementation SWAlertWebViewItem

- (void)dealloc{
    [self.loadingView stopAnimating];
}

- (instancetype)init{
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    [self.view addSubview:self.wkWebView];
    [self.view addSubview:self.loadingView];
    [self.wkWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.wkWebView.superview);
    }];
    [self.loadingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.loadingView.superview);
    }];
}

#pragma mark - Function - Public

+ (instancetype)webviewWithURL:(NSString *)urlStr height:(CGFloat)height clickURLHandler:(BOOL (^ __nullable)(NSURL *url))clickURLHandler{
    SWAlertWebViewItem *item = [[SWAlertWebViewItem alloc] init];
    if (urlStr) {
        [item loadRequest:urlStr];
    }
    [item setViewHeight:height];
    item.clickURLHandlerBlock = clickURLHandler;
    return item;
}

- (void)loadRequest:(NSString *)urlStr{
    NSURL *urlObj = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:urlObj];
    [self.wkWebView loadRequest:request];
}

- (void)loadHTMLString:(NSString *)htmlString {
    [self.loadingView startAnimating];
    [self.wkWebView loadHTMLString:htmlString baseURL:nil];
}

- (void)loadHTMLWithFilePath:(NSString *)htmlFilePath {
    NSString *htmlContent = [[NSString alloc] initWithContentsOfFile:htmlFilePath
                                                            encoding:NSUTF8StringEncoding
                                                               error:nil];
    if (!htmlContent) {
        htmlContent = @"<h1>File could not be found!</h1><h1>找不到指定文件！</h1>";
    }
    [self loadHTMLString:htmlContent];
}

- (void)setViewHeight:(CGFloat)height{
    [self.wkWebView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height);
    }];
}

#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [self.loadingView stopAnimating];
}

- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    [self.loadingView stopAnimating];
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    if (navigationAction.navigationType == WKNavigationTypeLinkActivated) {
        BOOL isHandle = NO; //是否被处理过了
        if (self.clickURLHandlerBlock) {
            isHandle = self.clickURLHandlerBlock(navigationAction.request.URL);
        }
        if (isHandle) {
            //此URL已经被处理过了
            decisionHandler(WKNavigationActionPolicyCancel);
        }else{
            decisionHandler(WKNavigationActionPolicyAllow);
        }
        return;
    }
    
    decisionHandler(WKNavigationActionPolicyAllow);
}

#pragma mark - Custom Accessors

- (UIView *)view{
    if (!_view) {
        _view = [[UIView alloc] init];
        _view.backgroundColor = [UIColor whiteColor];
    }
    return _view;
}

- (WKWebView *)wkWebView{
    if (!_wkWebView) {
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        config.allowsInlineMediaPlayback = YES;
        
        _wkWebView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:config];
        _wkWebView.backgroundColor = [UIColor whiteColor];;
        _wkWebView.opaque = NO;
        _wkWebView.navigationDelegate = self;
//        _wkWebView.UIDelegate = self;
    }
    return _wkWebView;
}

- (UIActivityIndicatorView *)loadingView{
    if (!_loadingView) {
        _loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    }
    return _loadingView;
}

@end
