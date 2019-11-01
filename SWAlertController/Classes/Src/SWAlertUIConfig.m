//
//  SWAlertUIConfig.m
//  SWAlertController
//
//  Created by shaowei on 2019/11/1.
//

#import "SWAlertUIConfig.h"

@implementation SWAlertUIConfig

- (instancetype)init{
    self = [super init];
    if (self) {
        //设置默认值
        self.hubWidth = 270.0f;
        self.hubCornerRadius = 14;
        self.otherBgColor = [[UIColor blackColor] colorWithAlphaComponent:0.45f];
        self.hubContentBgColor = [UIColor whiteColor];
        self.titleColor = SWColor_Title;
        self.titleFont = [UIFont boldSystemFontOfSize:17];
    }
    return self;
}

@end
