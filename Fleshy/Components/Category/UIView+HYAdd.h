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
 类似安卓Toast，显示在底部
 */
- (void)hy_showToast:(NSString *)message;

- (void)hy_showLoading;

- (void)hy_hideLoading;

@end
