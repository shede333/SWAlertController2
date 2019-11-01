//
//  SWAlertImageViewItem.m
//  SWAlertController
//
//  Created by shaowei on 2019/10/28.
//

#import "SWAlertImageViewItem.h"
#import "SWAlertController.h"

#import <Masonry/Masonry.h>
#import <YYKit/YYKit.h>

@interface SWAlertImageViewItem()

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIButton *button;

@property (nonatomic, copy) void (^ __nullable handler)(SWAlertImageViewItem *);

/// 实现SWAlertControllerItemProtocol协议
@property (nonatomic, copy) SWAlertController * (^alertCtrlGetterBlock)(void);

@end

@implementation SWAlertImageViewItem


- (instancetype)init{
    self = [super init];
    if (self) {
        [self setupUI];
        [self setupData];
    }
    return self;
}

- (void)setupUI{
    [self.containerView addSubview:self.imageView];
    //image默认居中
    [self updateImageAlignment:SWAIVIImageAlignmentHCenter];
    
    //button的位置和image一样
    [self.view addSubview:self.button];
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.imageView);
    }];
}

- (void)setupData{
    [self.button addTarget:self action:@selector(actionImageView) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - action

- (void)actionImageView{
    if (self.isDismissWhenClickImage ) {
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

#pragma mark - Function - Private

- (void)setHandler:(void (^)(SWAlertImageViewItem *))handler{
    _handler = [handler copy];
    
    if (handler && (!_button)) {
        
    }
    _button.hidden = handler?NO:YES;
}

#pragma mark - Function - Public

+ (instancetype)imageViewWithImage:(UIImage *)image handler:(void (^ __nullable)(SWAlertImageViewItem *item))handler{
    SWAlertImageViewItem *item = [[SWAlertImageViewItem alloc] init];
    [item updateImage:image];
    item.handler = handler;
    return item;
}

- (void)updateImage:(UIImage *)image{
    self.imageView.image = image;
}

- (void)updateImageAlignment:(SWAIVIImageAlignment)imageAlignment {
    [self updateImageAlignment:imageAlignment edgeInsets:UIEdgeInsetsZero];
}

- (void)updateImageAlignment:(SWAIVIImageAlignment)imageAlignment edgeInsets:(UIEdgeInsets)edgeInsets{
    switch (imageAlignment) {
        case SWAIVIImageAlignmentHCenter:{
            [self.imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self.imageView.superview);
                make.top.equalTo(self.imageView.superview).offset(edgeInsets.top);
                make.bottom.equalTo(self.imageView.superview).offset(-edgeInsets.bottom);
            }];
        }
            break;
        case SWAIVIImageAlignmentHLeft:{
            [self.imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.imageView.superview).offset(edgeInsets.top);
                make.bottom.equalTo(self.imageView.superview).offset(-edgeInsets.bottom);
                make.left.equalTo(self.imageView.superview).offset(edgeInsets.left);
            }];
        }
            break;
        case SWAIVIImageAlignmentHRight:{
            [self.imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.imageView.superview).offset(edgeInsets.top);
                make.bottom.equalTo(self.imageView.superview).offset(-edgeInsets.bottom);
                make.right.equalTo(self.imageView.superview).offset(-edgeInsets.right);
            }];
        }
            break;
    }
}

#pragma mark - SWAlertControllerItemProtocol

- (UIView *)view{
    return self.containerView;
}

#pragma mark - Custom Accessors

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}

- (UIView *)containerView{
    if (!_containerView) {
        _containerView = [[UIView alloc] init];
        _containerView.backgroundColor = [UIColor clearColor];
    }
    return _containerView;
}

- (UIButton *)button{
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.hidden = YES; //默认隐藏，只有设置了handler才会显示
    }
    return _button;
}

@end
