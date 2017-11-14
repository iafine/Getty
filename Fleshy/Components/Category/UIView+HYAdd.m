//
//  UIView+HYAdd.m
//  Fleshy
//
//  Created by Hyyy on 2017/11/8.
//  Copyright © 2017年 Hyyy. All rights reserved.
//

#import "UIView+HYAdd.h"

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

- (void)hy_showToast:(NSString *)message {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    
    // Set the text mode to show only text.
    hud.mode = MBProgressHUDModeText;
    hud.label.text = message;
    // Move to bottm center.
    hud.offset = CGPointMake(0.f, MBProgressMaxOffset);
    
    [hud hideAnimated:YES afterDelay:3.f];
}

- (void)hy_showLoading {
    [MBProgressHUD showHUDAddedTo:self animated:YES];
}

- (void)hy_hideLoading {
    [MBProgressHUD hideHUDForView:self animated:YES];
}

@end
