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
#define kBgGrayColor  [UIColor colorWithRed:153/255.0 green:153/255.0  blue:153/255.0 alpha:1.0]
#define kBlackColor  [UIColor colorWithRed:40/255.0 green:40/255.0 blue:40/255.0 alpha:1.0]
#define kRandomColor [UIColor colorWithRed:arc4random_uniform(256) / 255.0 green:arc4random_uniform(256) / 255.0 blue:arc4random_uniform(256) / 255.0 alpha:1.0]

#define kFemaleColor [UIColor colorWithRed:239.0 / 255.0 green:144.0 / 255.0 blue:141.0 / 255.0 alpha:1.0]
#define kMaleColor [UIColor colorWithRed:110.0 / 255.0 green:156.0 / 255.0 blue:247.0 / 255.0 alpha:1.0]
//#define kMainColor ([(NSString *)[HYCacheHelper cacheValueForKey:@"kHYGuideGenderCacheKey" cacheType:HYCacheDisk] isEqualToString: @"male"] ? kMaleColor : kFemaleColor)

#define kTitleColor [UIColor colorWithRed:0.27 green:0.27 blue:0.27 alpha:1.00]
#define kDescColor  [UIColor colorWithRed:0.71 green:0.71 blue:0.71 alpha:1.00]
#define kMainColor  [UIColor colorWithRed:0.42 green:0.63 blue:0.97 alpha:1.00]
#define kSeperatorColor  [UIColor colorWithRed:0.90 green:0.90 blue:0.90 alpha:1.00]
#define kTableBackgroundColor [UIColor colorWithRed:0.97 green:0.98 blue:0.98 alpha:1.00]

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
#define kTextSizeHuge 36

#endif /* HYConstantsHeader_h */
