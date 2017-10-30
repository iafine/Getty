//
//  HYGuideCTHeaderCell.m
//  Fleshy
//
//  Created by Hyyy on 2017/10/30.
//  Copyright © 2017年 Hyyy. All rights reserved.
//

#import "HYGuideCTHeaderCell.h"

@interface HYGuideCTHeaderCell ()
@end

@implementation HYGuideCTHeaderCell

#pragma mark - LifeCycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
        [self initLayout];
    }
    return self;
}

- (void)initUI {
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 5;
}

- (void)initLayout {
}

#pragma mark - Public Methods
+ (NSString *)cellID {
    return NSStringFromClass([self class]);
}

#pragma mark - Setter and Getter
- (void)setCellData:(NSDictionary *)cellData {
    _cellData = cellData;
    
}

@end
