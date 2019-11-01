//
//  SWViewController.m
//  SWAlertController
//
//  Created by shede333 on 11/01/2019.
//  Copyright (c) 2019 shede333. All rights reserved.
//

#import "SWViewController.h"
#import <SWAlertController/SWAlertKit.h>

@interface SWViewController ()

@end

@implementation SWViewController

- (void)viewDidLoad{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
}

#pragma mark - action

- (IBAction)actionShowAlert:(id)sender {
    SWAlertController *alertVC = [SWAlertController alertControllerWithTitle:@"Hello"];
    
    NSString *message = @"这是一个带title+message的普通示例";
    SWAlertMessageItem *messageItem = [SWAlertMessageItem messageWithText:message
                                                                  handler:^(SWAlertMessageItem * _Nonnull item) {
        NSLog(@"点击：messageItem");
    }];
    [alertVC addWidgetItem:messageItem];
    
    //添加 “取消”、“确定”按钮
    SWAlertActionItem *cancelAction = [SWAlertActionItem actionWithTitle:@"取消"
                                                                   style:SWAlertActionItemStyleCancel
                                                                 handler:^(SWAlertActionItem * _Nonnull action) {
        NSLog(@"点击：取消按钮");
    }];
    SWAlertActionItem *confirmAction = [SWAlertActionItem actionWithTitle:@"确定"
                                                                    style:SWAlertActionItemStyleDefault
                                                                  handler:^(SWAlertActionItem * _Nonnull action) {
        NSLog(@"点击：确定按钮");
    }];
    [alertVC addAction:cancelAction];
    [alertVC addAction:confirmAction];
    
    //显示Alert弹框
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (IBAction)actionShowMutiAlert:(id)sender {
}

- (IBAction)actionShowTextScrollAlert:(id)sender {
}


@end
