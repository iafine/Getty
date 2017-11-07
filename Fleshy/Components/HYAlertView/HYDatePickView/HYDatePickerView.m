//
//  HYDatePickerView.m
//  Fleshy
//
//  Created by Hyyy on 2017/11/7.
//  Copyright © 2017年 Hyyy. All rights reserved.
//

#import "HYDatePickerView.h"

#define kHYContentWidth kScreenWidth - 60    // 内容视图宽度
#define kHYContentHeight 260   // 内容视图高度

@interface HYDatePickerView ()

@property (nonatomic, strong) UIView *contentView;   // 内容视图 (下面所有的控件都放在此处)
@property (nonatomic, strong) UILabel *titleLabel;  // 标题
@property (nonatomic, strong) UIButton *okBtn;      // 确定按钮
@property (nonatomic, strong) UIDatePicker *pickerView;     // 选择控件

@end

@implementation HYDatePickerView

- (instancetype)initWithTitle:(NSString *)title {
    self = [super initWithFrame:kScreenBounds];
    if (self) {
        // 初始化基础控件
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        [self addSubview:self.contentView];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.pickerView];
        [self.contentView addSubview:self.okBtn];
        
        self.contentView.center = self.center;
        self.titleLabel.text = title;
    }
    return self;
}

#pragma mark - Public Methods
- (void)show {
    [[[UIApplication sharedApplication] keyWindow] addSubview:self];
    self.contentView.transform = CGAffineTransformMakeScale(0.01, 0.01);
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.contentView.transform = CGAffineTransformIdentity;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    } completion:^(BOOL finished){
        // do something once the animation finishes, put it here
    }];
}

- (void)dismiss {
    self.contentView.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.contentView.transform = CGAffineTransformMakeScale(0.01, 0.01);
    } completion:^(BOOL finished){
        [self removeFromSuperview];
    }];
}

#pragma mark - Events
- (void)clickedOKBtnHandler {
    if ([self.delegate respondsToSelector:@selector(didSelectdDate:)]) {
        [self.delegate didSelectdDate:self.pickerView.date];
    }
    [self dismiss];
}

- (void)pickerViewValueChange {
//    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
//    fmt.dateFormat = @"HH:mm";
//    NSString *dateStr = [fmt stringFromDate:self.pickerView.date];
//    self.titleLabel.text = dateStr;
}

#pragma mark - Setter and Getter
- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kHYContentWidth, kHYContentHeight)];
        _contentView.backgroundColor = [UIColor whiteColor];
        _contentView.layer.cornerRadius = 6;
        _contentView.layer.masksToBounds = YES;
    }
    return _contentView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kHYContentWidth, 40)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.backgroundColor = kMainColor;
        _titleLabel.textColor = [UIColor whiteColor];
    }
    return _titleLabel;
}

- (UIDatePicker *)pickerView {
    if (!_pickerView) {
        _pickerView = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 60, kHYContentWidth, kHYContentHeight - 40 - 40)];
        _pickerView.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
        _pickerView.datePickerMode = UIDatePickerModeTime;
        [_pickerView addTarget:self action:@selector(pickerViewValueChange) forControlEvents:UIControlEventValueChanged];
    }
    return _pickerView;
}

- (UIButton *)okBtn {
    if (!_okBtn) {
        _okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _okBtn.frame = CGRectMake(0, kHYContentHeight - 40, kHYContentWidth, 40);
        [_okBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_okBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _okBtn.backgroundColor = kMainColor;
        [_okBtn addTarget:self action:@selector(clickedOKBtnHandler) forControlEvents:UIControlEventTouchUpInside];
    }
    return _okBtn;
}

@end
