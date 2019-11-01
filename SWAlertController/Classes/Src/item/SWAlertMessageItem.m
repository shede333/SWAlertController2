//
//  SWAlertMessageItem.m
//  SWAlertController
//
//  Created by shaowei on 2019/11/1.
//

#import "SWAlertMessageItem.h"
#import "SWAlertController.h"

#import <Masonry/Masonry.h>
#import <YYKit/YYKit.h>

@interface SWAlertMessageItem()

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIView *ctRootView;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIButton *button;

@property (nonatomic, copy) void (^ __nullable handler)(SWAlertMessageItem *);

/**
 实现SWAlertControllerItemProtocol协议
 */
@property (nonatomic, copy) SWAlertController * (^alertCtrlGetterBlock)(void);

@end

@implementation SWAlertMessageItem

- (instancetype)init{
    self = [super init];
    if (self) {
        //设置默认值
        self.maxHeight = 200;
        
        [self setupUI];
        [self setupData];
    }
    return self;
}

- (void)setupUI{
    UIView *rootView = [UIView new];
    self.ctRootView = rootView;
    rootView.backgroundColor = [UIColor clearColor];
    [self.containerView addSubview:rootView];
    [rootView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.equalTo(rootView.superview);
        make.height.mas_equalTo(self.maxHeight).priorityLow(); //降低优先级，是为了让label的“greaterThanOrEqualTo”优先生效
    }];
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    [rootView addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.equalTo(scrollView.superview);
    }];
    
    //label
    [scrollView addSubview:self.label];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.label.superview);
        make.width.equalTo(self.label.superview);
        make.height.greaterThanOrEqualTo(rootView.mas_height);
    }];
    
    //button
    [self.containerView addSubview:self.button];
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.button.superview);
    }];
}

- (void)setupData{
    //设置默认值
    self.label.textColor = SWColor_Title;
    self.label.font = SWSystemFont(13);
    self.label.textAlignment = NSTextAlignmentCenter; //默认居中对齐
    
    self.isDismissWhenClick = NO;
    
    [self.button addTarget:self action:@selector(actionMessage:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - Function重写

- (void)setMaxHeight:(CGFloat)maxHeight{
    _maxHeight = maxHeight;
    if (self.ctRootView) {
        [self.ctRootView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(maxHeight).priorityLow();
        }];
    }
}

- (void)setHandler:(void (^)(SWAlertMessageItem *))handler{
    _handler = [handler copy];
    self.button.hidden = _handler?NO:YES;
}

#pragma mark - action

- (void)actionMessage:(UIButton *)sender{
    if (self.isDismissWhenClick ) {
        //dismiss alert弹框
        @weakify(self)
        SWAlertController *alertController = self.alertCtrlGetterBlock();
        [alertController dismissViewControllerAnimated:YES completion:^{
            @strongify(self)
            if (self.handler) {
                self.handler(self);
            }
        }];
    }else{
        if (self.handler) {
            self.handler(self);
        }
    }
}

#pragma mark - Function - Public

+ (instancetype)messageWithText:(NSString *)text handler:(void (^ __nullable)(SWAlertMessageItem *item))handler{
    SWAlertMessageItem *item = [[SWAlertMessageItem alloc] init];
    item.label.text = text;
    item.handler = handler;
    return item;
}

- (void)setEnabled:(BOOL)enabled{
    self.button.enabled = enabled;
}

#pragma mark - SWAlertControllerItemProtocol

- (UIView *)view{
    return self.containerView;
}

#pragma mark - Custom Accessors

- (UIView *)containerView{
    if (!_containerView) {
        _containerView = [[UIView alloc] init];
        _containerView.backgroundColor = [UIColor clearColor];
    }
    return _containerView;
}

- (UILabel *)label{
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.backgroundColor = [UIColor clearColor];
        _label.numberOfLines = 0; //多行
    }
    return _label;
}

- (UIButton *)button{
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.hidden = YES; //默认隐藏，只有设置了handler才会显示
    }
    return _button;
}


@end
