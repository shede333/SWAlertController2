//
//  SWAlertController.m
//  SWAlertController
//
//  Created by shaowei on 2019/11/1.
//

#import "SWAlertController.h"

#import <Masonry/Masonry.h>
#import <YYKit/YYKit.h>


@interface SWAlertController ()

@property (nonatomic, strong) SWAlertUIConfig *uiConfig;

@property (nonatomic, strong) NSMutableArray<SWAlertActionItem *> *actionItemList;
@property (nonatomic, strong) NSMutableArray<id<SWAlertControllerItemProtocol>> *widgetItemList;

@property (nonatomic, strong) UIView *otherBgView;
@property (nonatomic, strong) UIView *hubView;
@property (nonatomic, strong) UIView *hubContentView;

@end

@implementation SWAlertController

- (instancetype)init{
    self = [super init];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationOverFullScreen;
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSAssert([self.actionItemList count] > 0, @"至少要添加一个action");
    
    [self setupUI];
    [self reLayoutUI];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.hubView.transform = CGAffineTransformMakeScale(1.25, 1.25);
    [UIView animateWithDuration:0.12f
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
        self.hubView.transform = CGAffineTransformIdentity;
    } completion:NULL];
}

- (void)setupUI{
    self.view.backgroundColor = [UIColor clearColor];
    
    //背景色
    self.otherBgView = [[UIView alloc] init];
    self.otherBgView.backgroundColor = self.uiConfig.otherBgColor;
    [self.view addSubview:self.otherBgView];
    
    //HUB框
    self.hubView = [[UIView alloc] init];
    self.hubView.backgroundColor = [UIColor clearColor];
    self.hubView.layer.cornerRadius = self.uiConfig.hubCornerRadius;
    self.hubView.layer.masksToBounds = YES;
    [self.view addSubview:self.hubView];
    
    //毛玻璃效果(废弃毛玻璃效果)
    UIView *effectRootView = [[UIView alloc] init];
    effectRootView.backgroundColor = [UIColor clearColor];
    [self.hubView addSubview:effectRootView];
    UIView *eWhiteView = [[UIView alloc] init];
    eWhiteView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5f];
    [effectRootView addSubview:eWhiteView];
    [eWhiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(eWhiteView.superview);
    }];
//    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
//    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
//    [effectRootView addSubview:effectView];
//    [effectView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(effectView.superview);
//    }];
    
    //HUB内容view
    self.hubContentView = [[UIView alloc] init];
    self.hubContentView.backgroundColor = self.uiConfig.hubContentBgColor;
    [self.hubView addSubview:self.hubContentView];
    
    //布局
    [self.hubContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.hubContentView.superview);
    }];
    [effectRootView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(effectRootView.superview);
    }];
    [self.otherBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.otherBgView.superview);
    }];
    [self.hubView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.hubView.superview);
    }];
}

- (void)reLayoutUI{
    UIView *lastView = nil;
    
    //title
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = NSTextAlignmentCenter; //居中对齐
    titleLabel.numberOfLines = 0; //多行
    titleLabel.textColor = self.uiConfig.titleColor;
    titleLabel.font = self.uiConfig.titleFont;
    titleLabel.text = self.title;
    [self.hubContentView addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(titleLabel.superview).insets(UIEdgeInsetsMake(0, 15, 0, 15));
        make.top.mas_equalTo(15);
    }];
    lastView = titleLabel;
    
    //widget item
    for (id<SWAlertControllerItemProtocol> widgetItem in self.widgetItemList) {
        UIView *itemView = [widgetItem view];
        [self.hubContentView addSubview:itemView];
        
        CGFloat topSpace = [widgetItem respondsToSelector:@selector(topSpace)]?[widgetItem topSpace]:0;
        CGFloat leftSpace = [widgetItem respondsToSelector:@selector(leftSpace)]?[widgetItem leftSpace]:15;
        CGFloat rightSpace = [widgetItem respondsToSelector:@selector(rightSpace)]?[widgetItem rightSpace]:15;
        
        [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lastView.mas_bottom).offset(topSpace);
            make.left.equalTo(itemView.superview).offset(leftSpace);
            make.right.equalTo(itemView.superview).offset(-rightSpace);
        }];
        lastView = itemView;
    }
    
    //水平分割线
    UIView *hLineView = [[UIView alloc] init];
    hLineView.backgroundColor = SWColor_Line;
    [self.hubContentView addSubview:hLineView];
    [hLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(hLineView.superview);
        make.height.mas_equalTo(0.5f);
        make.top.equalTo(lastView.mas_bottom).offset(10);
    }];
    lastView = hLineView;
    
    //action
    UIView *actionContainerView = [[UIView alloc] init];
    actionContainerView.backgroundColor = [UIColor clearColor];
    [self.hubContentView addSubview:actionContainerView];
    [self layoutActionItemIn:actionContainerView]; //布局
    [actionContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(hLineView.superview);
        make.top.equalTo(lastView.mas_bottom);
        make.bottom.equalTo(actionContainerView.superview);
    }];
    lastView = actionContainerView;
    
    [self.hubContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.uiConfig.hubWidth);
    }];
}

- (void)layoutActionItemIn:(UIView *)containerView{
    //水平方向布局
    NSInteger widgetIndex = 0;
    UIView *lastBtnView = nil;
    for (SWAlertActionItem *actionItem in self.actionItemList) {
        UIView *btnView = [actionItem view];
        [containerView addSubview:btnView];
        if ([self.actionItemList count] == 1) { //1个button
            [btnView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(44);
                make.edges.equalTo(btnView.superview);
            }];
        }else{ //多个button
            if (widgetIndex == 0) { //第1个
                [btnView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.height.mas_equalTo(44);
                    make.left.top.bottom.equalTo(btnView.superview);
                }];
            }else{
                if (widgetIndex == ([self.actionItemList count] - 1)){ //最后一个
                    [btnView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.height.equalTo(lastBtnView);
                        make.left.equalTo(lastBtnView.mas_right);
                        make.right.top.bottom.equalTo(btnView.superview);
                        make.width.equalTo(lastBtnView.mas_width);
                    }];
                }else{ //中间的
                    [btnView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.height.equalTo(lastBtnView);
                        make.left.equalTo(lastBtnView.mas_right);
                        make.top.bottom.equalTo(btnView.superview);
                        make.width.equalTo(lastBtnView.mas_width);
                    }];
                }
                //加垂直分割线
                UIView *vLineView = [[UIView alloc] init];
                vLineView.backgroundColor = SWColor_Line;
                [containerView addSubview:vLineView];
                [vLineView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.width.mas_equalTo(0.5);
                    make.top.bottom.equalTo(vLineView.superview);
                    make.left.equalTo(lastBtnView.mas_right);
                }];
            }
        }
        widgetIndex += 1;
        lastBtnView = btnView;
    }
}

- (void)setItemDismissCompletion:(id<SWAlertControllerItemProtocol>)widgetItem{
    if ([widgetItem respondsToSelector:@selector(setAlertCtrlGetterBlock:)]) {
        __weak typeof(self) weakSelf = self;
        [widgetItem setAlertCtrlGetterBlock:^SWAlertController * _Nonnull{
            return weakSelf;
        }];
    }
}

#pragma mark - Function - Public

+ (instancetype)alertControllerWithTitle:(nullable NSString *)title{
    return [self alertControllerWithTitle:title uiConfig:nil];
}

+ (instancetype)alertControllerWithTitle:(nullable NSString *)title uiConfig:(nullable SWAlertUIConfig *)uiConfig{
    SWAlertController *alertController = [[SWAlertController alloc] init];
    alertController.title = title;
    alertController.uiConfig = uiConfig?:[[SWAlertUIConfig alloc] init];
    
    return alertController;
}

- (void)addWidgetItem:(id<SWAlertControllerItemProtocol>)widgetItem{
    NSAssert(widgetItem, @"itemWidget is nil");
    [self.widgetItemList addObject:widgetItem];
    
    [self setItemDismissCompletion:widgetItem];
}

- (void)addAction:(SWAlertActionItem *)actionItem{
    NSAssert(actionItem, @"actionItem is nil");
    [self.actionItemList addObject:actionItem];
    
    [self setItemDismissCompletion:actionItem];
}

#pragma mark - Custom Accessors

- (NSMutableArray<SWAlertActionItem *> *)actionItemList{
    if (!_actionItemList) {
        _actionItemList = [NSMutableArray array];
    }
    return _actionItemList;
}

- (NSMutableArray<id<SWAlertControllerItemProtocol>> *)widgetItemList{
    if (!_widgetItemList) {
        _widgetItemList = [NSMutableArray array];
    }
    return _widgetItemList;
}

@end
