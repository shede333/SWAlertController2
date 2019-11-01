//
//  SWAlertActionItem.m
//  SWAlertController
//
//  Created by shaowei on 2019/11/1.
//

#import "SWAlertActionItem.h"
#import "SWAlertController.h"

#import <Masonry/Masonry.h>
#import <YYKit/YYKit.h>

@interface SWAlertActionItem()

@property (nonatomic, strong) UIButton *button;

@property (nonatomic, assign) SWAlertActionItemStyle style;
@property (nonatomic, copy) void (^ __nullable handler)(SWAlertActionItem *);

/**
 实现SWAlertControllerItemProtocol协议
 */
@property (nonatomic, copy) SWAlertController * (^alertCtrlGetterBlock)(void);

@end

@implementation SWAlertActionItem

- (instancetype)init{
    self = [super init];
    if (self) {
        self.enabled = YES;
        [self setupUI];
        [self setupData];
    }
    return self;
}

- (void)setupUI{

}

- (void)setupData{
    //设置默认值
    UIColor *titleColor = SWColorHex(0x007AFF);
    [self.button setTitleColor:titleColor forState:UIControlStateNormal];
    [self.button setTitleColor:[titleColor colorWithAlphaComponent:0.5f]
                  forState:UIControlStateHighlighted];
    [self.button addTarget:self action:@selector(actionButton:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - action

- (void)actionButton:(UIButton *)sender{
    @weakify(self)
    SWAlertController *alertController = self.alertCtrlGetterBlock();
    [alertController dismissViewControllerAnimated:YES completion:^{
        @strongify(self)
        if (self.handler) {
            self.handler(self);
        }
    }];
    
}

#pragma mark - Function - Public

+ (instancetype)actionWithTitle:(nullable NSString *)title style:(SWAlertActionItemStyle)style handler:(void (^ __nullable)(SWAlertActionItem *action))handler{
    SWAlertActionItem *item = [[SWAlertActionItem alloc] init];
    [item.button setTitle:title forState:UIControlStateNormal];
    item.style = style;
    item.handler = handler;
    
    switch (style) {
        case SWAlertActionItemStyleDefault:{
            item.button.titleLabel.font = SWSystemFont(17);
        }
            break;
        case SWAlertActionItemStyleCancel:{
            item.button.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        }
            break;
    }
    
    return item;
}

- (void)setEnabled:(BOOL)enabled{
    self.button.enabled = enabled;
}

#pragma mark - SWAlertControllerItemProtocol

- (UIView *)view{
    return self.button;
}

#pragma mark - Custom Accessors

- (UIButton *)button{
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _button;
}

@end
