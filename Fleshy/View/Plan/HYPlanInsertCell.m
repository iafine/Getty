//
//  HYPlanInsertCell.m
//  Fleshy
//
//  Created by Hyyy on 2017/11/28.
//  Copyright © 2017年 Hyyy. All rights reserved.
//

#import "HYPlanInsertCell.h"

@interface HYPlanInsertCell ()

@property (nonatomic, assign) HYPlanInsertCellStyle cellStyle;

@end

@implementation HYPlanInsertCell

#pragma mark - LifeCycle
+ (instancetype)cellWithTableView:(UITableView *)tableView cellStyle:(HYPlanInsertCellStyle)cellStyle {
    // 修改cell类型为定义类型
    HYPlanInsertCell *cell = [tableView dequeueReusableCellWithIdentifier:[HYPlanInsertCell ID]];
    if (cell == nil){
        cell = [[HYPlanInsertCell alloc] init];
        cell.cellStyle = cellStyle;
        
        // 初始化
        [cell initCellUI];
        [cell initCellLayout];
    }
    return cell;
}

/**
 *  初始化视图
 */
- (void)initCellUI {
    if (self.cellStyle == HYPlanInsertCellStyleEdit) {
        [self.contentView addSubview:self.textField];
    }else {
        [self.contentView addSubview:self.titleLabel];
    }
}

- (void)initCellLayout {
    if (self.cellStyle == HYPlanInsertCellStyleEdit) {
        [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top);
            make.left.equalTo(self.contentView.mas_left).offset(20);
            make.right.equalTo(self.contentView.mas_right).offset(-20);
            make.bottom.equalTo(self.contentView.mas_bottom);
        }];
    }else {
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top);
            make.left.equalTo(self.contentView.mas_left).offset(20);
            make.right.equalTo(self.contentView.mas_right).offset(-20);
            make.bottom.equalTo(self.contentView.mas_bottom);
        }];
    }
}

#pragma mark - Public Methods
+ (NSString *)ID{
    return NSStringFromClass([self class]);
}

+ (CGFloat)cellHeight{
    return 44;
}

#pragma mark - Events
- (void)textFieldDidChange {
    if ([self.delegate respondsToSelector:@selector(textFieldDidChange:)]) {
        [self.delegate textFieldDidChange:self.textField];
    }
}

#pragma mark - Setter and Getter
- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.borderStyle = UITextBorderStyleNone;
        _textField.textAlignment = NSTextAlignmentLeft;
        _textField.font = [UIFont systemFontOfSize:kTextSizeSlightSmall];
        _textField.textColor = kTitleColor;
        [_textField addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    }
    return _textField;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:kTextSizeSlightSmall];
        _titleLabel.textColor = kTitleColor;
    }
    return _titleLabel;
}

@end
