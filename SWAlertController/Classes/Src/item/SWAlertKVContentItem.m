//
//  SWAlertKVContentItem.m
//  SWAlertController
//
//  Created by shaowei on 2019/11/1.
//

#import "SWAlertKVContentItem.h"
#import <Masonry/Masonry.h>

@interface SWAlertKVContentItem()

@property (nonatomic, strong) UIView *containerView;

/**
 左边的标题Label
 */
@property (nonatomic, strong) UILabel *titleLabel;

/**
 右边的内容Label
 */
@property (nonatomic, strong) UILabel *detailLabel;

@end

@implementation SWAlertKVContentItem

- (instancetype)init{
    self = [super init];
    if (self) {        
        [self setupUI];
        [self setupData];
    }
    return self;
}

- (void)setupUI{
    [self.containerView addSubview:self.titleLabel];
    [self.containerView addSubview:self.detailLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.superview);
        make.top.equalTo(self.titleLabel.superview).offset(8);
        make.bottom.equalTo(self.titleLabel.superview).offset(-8);
    }];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLabel);
        make.right.equalTo(self.detailLabel.superview);
        make.left.equalTo(self.detailLabel.superview).offset(125);
    }];
}

- (void)setupData{
    //设置默认值
    self.titleLabel.textColor = SWColor_Title;
    self.titleLabel.font = SWSystemFont(14);
    
    self.detailLabel.textColor = SWColor_Title;
    self.detailLabel.font = SWSystemFont(19);
}

#pragma mark - Function - Public

+ (instancetype)kvContentWithTitle:(NSString *)title detail:(NSString *)detail{
    SWAlertKVContentItem *item = [[SWAlertKVContentItem alloc] init];
    item.titleLabel.text = title?:@"";
    item.detailLabel.text = detail?:@"";
    
    return item;
}

- (void)setDetailLabelToLeftOffset:(CGFloat)offset{
    [self.detailLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.detailLabel.superview).offset(offset);
    }];
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

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = [UIColor clearColor];
    }
    return _titleLabel;
}

- (UILabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc] init];
        _detailLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _detailLabel;
}

@end
