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
#define kDeepGrayColor [UIColor colorWithRed:101/255.0 green:101/255.0  blue:101/255.0 alpha:1.0]
#define kLightGrayColor  [UIColor colorWithRed:238.0/255.0 green:238.0/255.0  blue:238.0/255.0 alpha:1.0]
#define kBorderGrayColor  [UIColor colorWithRed:195.0/255.0 green:195.0/255.0  blue:195.0/255.0 alpha:1.0]
#define kBgGrayColor  [UIColor colorWithRed:242/255.0 green:242/255.0  blue:242/255.0 alpha:1.0]
#define kBlackColor  [UIColor colorWithRed:40/255.0 green:40/255.0 blue:40/255.0 alpha:1.0]
#define kRandomColor [UIColor colorWithRed:arc4random_uniform(256) / 255.0 green:arc4random_uniform(256) / 255.0 blue:arc4random_uniform(256) / 255.0 alpha:1.0]

#define kFemaleColor [UIColor colorWithRed:239.0 / 255.0 green:144.0 / 255.0 blue:141.0 / 255.0 alpha:1.0]
#define kMaleColor [UIColor colorWithRed:110.0 / 255.0 green:156.0 / 255.0 blue:247.0 / 255.0 alpha:1.0]
#define kMainColor ([(NSString *)[HYCacheHelper cacheValueForKey:@"kHYGuideGenderCacheKey" cacheType:HYCacheDisk] isEqualToString: @"male"] ? kMaleColor : kFemaleColor)

// 尺寸相关
#define kScreenBounds [UIScreen mainScreen].bounds
#define KScreenWidthScale kScreenW / 375
#define kScreenHeightScale kScreenH/667

#define kStatusBarHeight 20
#define kNavHeight  44

// 字体相关
#define kTextSizeMini 10
#define kTextSizeTiny 12
#define kTextSizeExtraSmall 13
#define kTextSizeSlightSmall 14
#define kTextSizeSmall 15
#define kTextSizeMedium 16
#define kTextSizeBig 18
#define kTextSizeLarge 20
#define kTextSizeHuge 35

#endif /* HYConstantsHeader_h */
