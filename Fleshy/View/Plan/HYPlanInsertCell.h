//
//  HYPlanInsertCell.h
//  Fleshy
//
//  Created by Hyyy on 2017/11/28.
//  Copyright © 2017年 Hyyy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, HYPlanInsertCellStyle) {
    HYPLanInsertCellStyleLabel,
    HYPlanInsertCellStyleEdit,
};

@protocol HYPlanInsertCellDelegate <NSObject>

- (void)textFieldDidChange:(UITextField *)textField;

@end

@interface HYPlanInsertCell : UITableViewCell

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, copy) NSDictionary *cellData; // cell显示数据
@property (nonatomic, weak) id<HYPlanInsertCellDelegate> delegate;

+ (NSString *)ID;

+ (CGFloat)cellHeight;

+ (instancetype)cellWithTableView:(UITableView *)tableView cellStyle:(HYPlanInsertCellStyle)cellStyle;


@end
