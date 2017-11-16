//
//  UIView+HYAdd.m
//  Fleshy
//
//  Created by Hyyy on 2017/11/8.
//  Copyright © 2017年 Hyyy. All rights reserved.
//

#import "UIView+HYAdd.h"
#import "HYTopAlertView.h"

@implementation UIView (HYAdd)

- (void)hy_shakeAnimation {
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    [basicAnimation setDuration:0.05];
    [basicAnimation setRepeatCount:4];
    [basicAnimation setAutoreverses:YES];
    [basicAnimation setFromValue:[NSValue valueWithCGPoint:
                             CGPointMake([self center].x - 10.0f, [self center].y)]];
    [basicAnimation setToValue:[NSValue valueWithCGPoint:
                           CGPointMake([self center].x + 10.0f, [self center].y)]];
    [[self layer] addAnimation:basicAnimation forKey:@"position"];
}

/************************* MBProgressHUD扩展 *****************************/

+ (void)hy_showToast:(NSString *)title message:(NSString *)message {
    HYTopAlertView *topAlert = [[HYTopAlertView alloc] initAlertWithTitle:title subTitle:message];
    [topAlert show];
}

- (void)hy_showLoading {
    [MBProgressHUD showHUDAddedTo:self animated:YES];
}

- (void)hy_hideLoading {
    [MBProgressHUD hideHUDForView:self animated:YES];
}

@end
