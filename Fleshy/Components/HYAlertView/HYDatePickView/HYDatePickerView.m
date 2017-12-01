//
//  HYDatePickerView.m
//  Fleshy
//
//  Created by Hyyy on 2017/11/7.
//  Copyright © 2017年 Hyyy. All rights reserved.
//

#import "HYDatePickerView.h"

#define kHYContentWidth kScreenWidth    // 内容视图宽度
#define kHYContentHeight 260   // 内容视图高度

@interface HYDatePickerView ()

@property (nonatomic, strong) UIView *contentView;   // 内容视图 (下面所有的控件都放在此处)
@property (nonatomic, strong) UIDatePicker *pickerView;     // 选择控件

@property (nonatomic, strong) UIButton *cancelBtn;  // 取消按钮
@property (nonatomic, strong) UILabel *titleLabel;  // 标题
@property (nonatomic, strong) UIButton *okBtn;      // 确定按钮

@end

@implementation HYDatePickerView

- (instancetype)initDatePickerView {
    self = [super initWithFrame:kScreenBounds];
    if (self) {
        // 初始化基础控件
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        [self addSubview:self.contentView];

        [self.contentView addSubview:self.cancelBtn];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.okBtn];
        [self.contentView addSubview:self.pickerView];
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismiss];
}

#pragma mark - Public Methods
- (void)show {
    [[[UIApplication sharedApplication] keyWindow] addSubview:self];
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        self.contentView.frame = CGRectMake(0, (kScreenHeight - kHYContentHeight), kHYContentWidth, kHYContentHeight);
    } completion:^(BOOL finished){
    }];
}

- (void)dismiss {
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.contentView.frame = CGRectMake(0, (kScreenHeight + kHYContentHeight), kHYContentWidth, kHYContentHeight);
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    } completion:^(BOOL finished){
        [self removeFromSuperview];
    }];
}

#pragma mark - Events
- (void)clickedCancelBtnHandler {
    [self dismiss];
}

- (void)clickedOKBtnHandler {
    NSDate *newDate = [self.pickerView.date hy_newDateBySecondZero];
    if ([self.delegate respondsToSelector:@selector(datePicker:didSelectdDate:)]) {
        [self.delegate datePicker:self didSelectdDate:newDate];
    }
    [self dismiss];
}

- (void)pickerViewValueChange {
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"HH:mm";
    NSString *dateStr = [fmt stringFromDate:self.pickerView.date];
    self.titleLabel.text = dateStr;
}

#pragma mark - Setter and Getter
- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, (kScreenHeight + kHYContentHeight), kHYContentWidth, kHYContentHeight)];
        _contentView.backgroundColor = [UIColor whiteColor];
    }
    return _contentView;
}

- (UIDatePicker *)pickerView {
    if (!_pickerView) {
        _pickerView = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 60, kHYContentWidth, kHYContentHeight - 60)];
        _pickerView.datePickerMode = UIDatePickerModeTime;
        [_pickerView addTarget:self action:@selector(pickerViewValueChange) forControlEvents:UIControlEventValueChanged];
    }
    return _pickerView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 5, kHYContentWidth - 140, 40)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = kTitleColor;
        _titleLabel.font = [UIFont systemFontOfSize:kTextSizeSlightSmall];
    }
    return _titleLabel;
}

- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelBtn.frame = CGRectMake(5, 5, 60, 40);
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:kTitleColor forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:kTextSizeSmall];
        [_cancelBtn addTarget:self action:@selector(clickedCancelBtnHandler) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (UIButton *)okBtn {
    if (!_okBtn) {
        _okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _okBtn.frame = CGRectMake(kHYContentWidth - 60 - 5, 5, 60, 40);
        [_okBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_okBtn setTitleColor:kMainColor forState:UIControlStateNormal];
        _okBtn.titleLabel.font = [UIFont boldSystemFontOfSize:kTextSizeSmall];
        [_okBtn addTarget:self action:@selector(clickedOKBtnHandler) forControlEvents:UIControlEventTouchUpInside];
    }
    return _okBtn;
}

@end
