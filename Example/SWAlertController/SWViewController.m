//
//  SWViewController.m
//  SWAlertController
//
//  Created by shede333 on 11/01/2019.
//  Copyright (c) 2019 shede333. All rights reserved.
//

#import "SWViewController.h"
#import <SWAlertController/SWAlertKit.h>
#import <YYKit/YYKit.h>

#define LocalLog(_text) [self showLog:_text]

@interface SWViewController ()

@property (weak, nonatomic) IBOutlet UITextView *logView;

@end

@implementation SWViewController

- (void)viewDidLoad{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
}

- (void)showLog:(NSString *)logText{
    NSLog(@"%@", logText);
    if (self.logView.text.length > 0) {
        logText = [NSString stringWithFormat:@"%@\n%@", logText, self.logView.text];
    }
    self.logView.text = logText;
}

#pragma mark - action

- (IBAction)actionShowAlert:(id)sender {
    SWAlertController *alertVC = [SWAlertController alertControllerWithTitle:@"Hello"];
    
    //普通message的widget
    NSString *message = @"这是一个带title+message的普通示例，支持点击哟";
    SWAlertMessageItem *messageItem = [SWAlertMessageItem messageWithText:message
                                                                  handler:^(SWAlertMessageItem * _Nonnull item) {
        LocalLog(@"点击了：messageItem");
    }];
    [alertVC addWidgetItem:messageItem];
    
    //添加 “取消”、“确定”按钮
    SWAlertActionItem *cancelAction = [SWAlertActionItem actionWithTitle:@"取消"
                                                                   style:SWAlertActionItemStyleCancel
                                                                 handler:^(SWAlertActionItem * _Nonnull action) {
        LocalLog(@"点击：取消按钮");
    }];
    SWAlertActionItem *confirmAction = [SWAlertActionItem actionWithTitle:@"确定"
                                                                    style:SWAlertActionItemStyleDefault
                                                                  handler:^(SWAlertActionItem * _Nonnull action) {
        LocalLog(@"点击：确定按钮");
    }];
    [alertVC addAction:cancelAction];
    [alertVC addAction:confirmAction];
    
    //显示Alert弹框
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (IBAction)actionShowMutiAlert:(id)sender {
    NSString *logText = @"显示了定制UI后的弹框，支持多种类型的widget，用户也可以自己定义新的widget";
    LocalLog(logText);
    
    SWAlertUIConfig *uiConfig = [SWAlertUIConfig new];
    //蓝色的标题
    uiConfig.titleColor = [UIColor blueColor];
    //半透明墨绿色的HUB背景色
    uiConfig.hubContentBgColor = [UIColorHex(0xCCE8CF) colorWithAlphaComponent:0.7];
    SWAlertController *alertVC = [SWAlertController alertControllerWithTitle:@"Hello, blue"
                                                                    uiConfig:uiConfig];
    //普通message的widget
    NSString *message = logText;
    SWAlertMessageItem *messageItem = [SWAlertMessageItem messageWithText:message
                                                                  handler:^(SWAlertMessageItem * _Nonnull item) {
        LocalLog(@"点击：messageItem");
    }];
    messageItem.label.textAlignment = NSTextAlignmentLeft;
    messageItem.label.backgroundColor = [UIColor whiteColor];
    messageItem.label.font = [UIFont systemFontOfSize:14];
    messageItem.label.layer.masksToBounds = YES;
    messageItem.label.layer.cornerRadius = 6;
    messageItem.topSpace = 10;
    [alertVC addWidgetItem:messageItem];
    
    //标题Label+详情Label的控件
    SWAlertKVContentItem *kvItem = [SWAlertKVContentItem kvContentWithTitle:@"标题Label:"
                                                                     detail:@"详情Label"];
    kvItem.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    kvItem.detailLabel.textColor = [UIColor redColor];
    [alertVC addWidgetItem:kvItem];
    
    //webview控件，也支持url、本地html文件或者字符串；
    NSString *url = @"https://www.qq.com";
    SWAlertWebViewItem *webItem = [SWAlertWebViewItem webviewWithURL:url
                                                              height:150
                                                     clickURLHandler:^BOOL(NSURL * _Nonnull url) {
        NSString *tmpLog = [NSString stringWithFormat:@"点击了URL: %@", url];
        LocalLog(tmpLog);
        return NO; //支持url跳转，则返回NO
    }];
    [alertVC addWidgetItem:webItem];
    
    //自定义view 控件
    NSArray *allTitle = @[@"123", @"自定义view", @"abc"];
    UISegmentedControl *scView = [[UISegmentedControl alloc] initWithItems:allTitle];
    scView.selectedSegmentIndex = 1;
    SWAlertCustomViewItem *cvItem = [SWAlertCustomViewItem customWithView:scView
                                                                   height:40];
    cvItem.topSpace = 15;
    [alertVC addWidgetItem:cvItem];
    
    //添加 “取消”、“确定”按钮
    SWAlertActionItem *cancelAction = [SWAlertActionItem actionWithTitle:@"取消"
                                                                   style:SWAlertActionItemStyleCancel
                                                                 handler:^(SWAlertActionItem * _Nonnull action) {
        LocalLog(@"点击：取消按钮");
    }];
    SWAlertActionItem *confirmAction = [SWAlertActionItem actionWithTitle:@"确定"
                                                                    style:SWAlertActionItemStyleDefault
                                                                  handler:^(SWAlertActionItem * _Nonnull action) {
        LocalLog(@"点击：确定按钮");
    }];
    [alertVC addAction:cancelAction];
    [alertVC addAction:confirmAction];
    
    //显示Alert弹框
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (IBAction)actionShowTextScrollAlert:(id)sender {
    SWAlertController *alertVC = [SWAlertController alertControllerWithTitle:@"Hello"];
    
    //普通message的widget
    NSString *message = @"这个message的高度超过最大值后(默认200)，会显示成类似textView的滑动格式，上下滑动试试看。\n\n";
    message = [message stringByAppendingString:message];
    message = [message stringByAppendingString:message];
    message = [message stringByAppendingString:message];
    message = [message stringByAppendingString:message];
    //这里的handler必须为nil
    SWAlertMessageItem *messageItem = [SWAlertMessageItem messageWithText:message
                                                                  handler:nil];
    messageItem.maxHeight = 100; //maxHeight默认为200；
    messageItem.topSpace = 10;
    messageItem.label.font = [UIFont systemFontOfSize:14];
    [alertVC addWidgetItem:messageItem];
    
    //添加 “取消”、“确定”按钮
    SWAlertActionItem *cancelAction = [SWAlertActionItem actionWithTitle:@"取消"
                                                                   style:SWAlertActionItemStyleCancel
                                                                 handler:^(SWAlertActionItem * _Nonnull action) {
        LocalLog(@"点击：取消按钮");
    }];
    SWAlertActionItem *confirmAction = [SWAlertActionItem actionWithTitle:@"确定"
                                                                    style:SWAlertActionItemStyleDefault
                                                                  handler:^(SWAlertActionItem * _Nonnull action) {
        LocalLog(@"点击：确定按钮");
    }];
    [alertVC addAction:cancelAction];
    [alertVC addAction:confirmAction];
    
    //显示Alert弹框
    [self presentViewController:alertVC animated:YES completion:nil];
}


@end
