//
//  HYPlanEditCell.h
//  Fleshy
//
//  Created by Hyyy on 2017/11/28.
//  Copyright © 2017年 Hyyy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, HYPlanEditCellStyle) {
    HYPlanEditCellStyleLabel,
    HYPlanEditCellStyleEdit,
};

@protocol HYPlanEditCellDelegate <NSObject>

- (void)textFieldDidChange:(UITextField *)textField;

@end

@interface HYPlanEditCell : UITableViewCell

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, copy) NSDictionary *cellData; // cell显示数据
@property (nonatomic, weak) id<HYPlanEditCellDelegate> delegate;

+ (NSString *)ID;

+ (CGFloat)cellHeight;

+ (instancetype)cellWithTableView:(UITableView *)tableView cellStyle:(HYPlanEditCellStyle)cellStyle;


@end
