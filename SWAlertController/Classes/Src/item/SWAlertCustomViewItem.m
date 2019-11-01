//
//  SWAlertCustomViewItem.m
//  SWAlertController
//
//  Created by shaowei on 2019/4/24.
//

#import "SWAlertCustomViewItem.h"
#import <Masonry/Masonry.h>

@interface SWAlertCustomViewItem()

@property (nonatomic, strong) UIView *containerView;
//@property (nonatomic, strong) UIView *customView;

@end

@implementation SWAlertCustomViewItem

- (void)updateCustomView:(UIView *)customView height:(CGFloat)height{
    [self.containerView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    [self.containerView addSubview:customView];
    [customView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(customView.superview);
        make.height.mas_equalTo(height);
    }];
}

- (void)updateAutoLayoutCustomView:(UIView *)customView{
    [self.containerView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    [self.containerView addSubview:customView];
    [customView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(customView.superview);
    }];
}

#pragma mark - Function - Public

+ (instancetype)customWithView:(UIView *)customView height:(CGFloat)height{
    SWAlertCustomViewItem *item = [[SWAlertCustomViewItem alloc] init];
    [item updateCustomView:customView height:height];
    return item;
}

+ (instancetype)customWithAutoLayoutView:(UIView *)customView {
    SWAlertCustomViewItem *item = [[SWAlertCustomViewItem alloc] init];
    [item updateAutoLayoutCustomView:customView];
    return item;
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


@end
