//
//  UIView+HYAdd.h
//  Fleshy
//
//  Created by Hyyy on 2017/11/8.
//  Copyright © 2017年 Hyyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (HYAdd)

/**
 抖动效果
 */
- (void)hy_shakeAnimation;

/************************* MBProgressHUD扩展 *****************************/

/**
 顶部显示警告
 */
+ (void)hy_showToast:(NSString *)title message:(NSString *)message;

- (void)hy_showLoading;

- (void)hy_hideLoading;

@end
