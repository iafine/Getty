//
//  UINavigationController+HYAdd.m
//  Fleshy
//
//  Created by Hyyy on 2017/10/27.
//  Copyright © 2017年 Hyyy. All rights reserved.
//

#import "UINavigationBar+HYAdd.h"

@implementation UINavigationBar (HYAdd)

+ (void)hy_basicAppearance {
    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];    // 设置导航栏背景颜色
    [[UINavigationBar appearance] setTintColor:kTitleColor];    // 设置导航栏左右按钮tint颜色
    [[UINavigationBar appearance] setShadowImage:[UIImage new]];    // 去掉导航栏底部阴影线
    
    NSDictionary *textAttributes =  @{ NSFontAttributeName : [UIFont boldSystemFontOfSize:17],
                                       NSForegroundColorAttributeName : kTitleColor };
    [[UINavigationBar appearance] setTitleTextAttributes:textAttributes];   // 定制导航栏title字体
}

@end
