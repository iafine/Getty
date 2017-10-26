//
//  HYConstantsHeader.h
//  Fleshy
//
//  Created by Hyyy on 2017/10/26.
//  Copyright © 2017年 Hyyy. All rights reserved.
//

#ifndef HYConstantsHeader_h
#define HYConstantsHeader_h

// 颜色相关
#define kPageBgColor [UIColor whiteColor]
#define kRandomColor [UIColor colorWithRed:arc4random_uniform(256) / 255.0 green:arc4random_uniform(256) / 255.0 blue:arc4random_uniform(256) / 255.0 alpha:1.0]

// 尺寸相关
#define kScreenBounds [UIScreen mainScreen].bounds
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define KScreenWidthScale kScreenW / 375
#define kScreenHeightScale kScreenH/667


#endif /* HYConstantsHeader_h */
