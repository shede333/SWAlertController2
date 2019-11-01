//
//  SWAlertCheckboxItem.m
//  SWAlertController
//
//  Created by shaowei on 2019/11/1.
//

#import "SWAlertCheckboxItem.h"

#import <Masonry/Masonry.h>

@interface SWAlertCheckboxItem()

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIButton *checkboxBtn;

@property (nonatomic, copy) void (^ __nullable handler)(BOOL);

@end

@implementation SWAlertCheckboxItem

- (instancetype)init{
    self = [super init];
    if (self) {
        [self setupUI];
        [self setupData];
    }
    return self;
}

- (void)setupUI{
    [self.containerView addSubview:self.checkboxBtn];
    [self.checkboxBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.checkboxBtn.superview);
        make.top.equalTo(self.checkboxBtn.superview).offset(8);
        make.bottom.equalTo(self.checkboxBtn.superview).offset(-8);
    }];
}

- (void)setupData{
    //设置默认值
    self.checkboxBtn.titleLabel.font = SWSystemFont(15);
    [self.checkboxBtn setTitleColor:SWColorHex(0x666666) forState:UIControlStateNormal];
    [self.checkboxBtn addTarget:self
                         action:@selector(actionCheckbox:)
               forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - action

- (void)actionCheckbox:(UIButton *)sender{
    sender.selected = !sender.isSelected;
    if (self.handler) {
        self.handler(sender.isSelected);
    }
}

#pragma mark - Function - Public

+ (instancetype)checkboxWithTitle:(NSString *)title isSelected:(BOOL)isSelected normalImage:(UIImage *)normalImage selectedImage:(UIImage *)selectedImage handler:(void (^ __nullable)(BOOL isSelected))handler{
    SWAlertCheckboxItem *item = [[SWAlertCheckboxItem alloc] init];
    item.handler = handler;
    [item.checkboxBtn setTitle:title?:@"" forState:UIControlStateNormal];
    [item.checkboxBtn setImage:normalImage forState:UIControlStateNormal];
    [item.checkboxBtn setImage:selectedImage forState:UIControlStateSelected];
    [item.checkboxBtn setSelected:isSelected];
    
    NSAssert(normalImage, @"normalImage is nil");
    NSAssert(selectedImage, @"selectedImage is nil");
    
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

- (UIButton *)checkboxBtn{
    if (!_checkboxBtn) {
        _checkboxBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _checkboxBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
        _checkboxBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_checkboxBtn setAdjustsImageWhenHighlighted:NO];
    }
    return _checkboxBtn;
}


@end
