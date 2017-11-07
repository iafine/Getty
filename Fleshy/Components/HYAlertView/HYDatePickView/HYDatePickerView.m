//
//  HYDatePickerView.m
//  Fleshy
//
//  Created by Hyyy on 2017/11/7.
//  Copyright © 2017年 Hyyy. All rights reserved.
//

#import "HYDatePickerView.h"

@interface HYDatePickerView ()<UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) UIView *contentView;   // 内容视图 (下面所有的控件都放在此处)
@property (nonatomic, strong) UIView *toolView; // 工具栏视图
@property (nonatomic, strong) UIButton *cancelBtn;  // 取消按钮
@property (nonatomic, strong) UIButton *okBtn;      // 确定按钮
@property (nonatomic, strong) UIPickerView *pickerView;     // 选择控件

@end

@implementation HYDatePickerView

- (instancetype)initWithTitle:(NSString *)title {
    self = [super initWithFrame:kScreenBounds];
    if (self) {
        // 初始化基础控件
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        [self addSubview:self.contentView];
        [self.contentView addSubview:self.toolView];
        [self.contentView addSubview:self.pickerView];
        [self.toolView addSubview:self.cancelBtn];
        [self.toolView addSubview:self.okBtn];
    }
    return self;
}

#pragma mark - Public Methods
- (void)show {
    [[[UIApplication sharedApplication] keyWindow] addSubview:self];
    [UIView animateWithDuration:0.3 animations:^{
        CGRect newFrame = CGRectMake(0, CGRectGetMinY(self.contentView.frame) - CGRectGetHeight(self.contentView.frame), CGRectGetWidth(self.contentView.frame), CGRectGetHeight(self.contentView.frame));
        self.contentView.frame = newFrame;
        
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    }];
}

- (void)dismiss {
    [UIView animateWithDuration:0.3 animations:^{
        CGRect newFrame = CGRectMake(0, CGRectGetMinY(self.contentView.frame) + CGRectGetHeight(self.contentView.frame), CGRectGetWidth(self.contentView.frame), CGRectGetHeight(self.contentView.frame));
        self.contentView.frame = newFrame;
        
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - UIPickerViewDelegate
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 10;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [NSString stringWithFormat:@"测试%ld", row];
}

#pragma mark - Events
- (void)clickedCancelBtnHandler {
    [self dismiss];
}

- (void)clickedOKBtnHandler {
    [self dismiss];
}

#pragma mark - Setter and Getter
- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, 260)];
        _contentView.backgroundColor = [UIColor whiteColor];
    }
    return _contentView;
}

- (UIView *)toolView {
    if (!_toolView) {
        _toolView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    }
    return _toolView;
}

- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _cancelBtn.frame = CGRectMake(0, 0, 60, 40);
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(clickedCancelBtnHandler) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (UIButton *)okBtn {
    if (!_okBtn) {
        _okBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _okBtn.frame = CGRectMake(kScreenWidth - 60, 0, 60, 40);
        [_okBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_okBtn addTarget:self action:@selector(clickedOKBtnHandler) forControlEvents:UIControlEventTouchUpInside];
    }
    return _okBtn;
}

- (UIPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 60, kScreenWidth, 260 - 40)];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
    }
    return _pickerView;
}

@end
