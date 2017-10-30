//
//  HYGuideCTHeaderCell.h
//  Fleshy
//
//  Created by Hyyy on 2017/10/30.
//  Copyright © 2017年 Hyyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYGuideCTHeaderCell : UICollectionViewCell

+ (NSString *)cellID;

@property (nonatomic, copy) NSDictionary *cellData;

@end
