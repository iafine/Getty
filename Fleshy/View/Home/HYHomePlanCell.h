//
//  HYHomePlanCell.h
//  Fleshy
//
//  Created by Hyyy on 2017/10/26.
//  Copyright © 2017年 Hyyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HYHomePlanCell : UITableViewCell

+ (NSString *)ID;

+ (CGFloat)cellHeight;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) HYPlan *cellData; // cell显示数据

@end
