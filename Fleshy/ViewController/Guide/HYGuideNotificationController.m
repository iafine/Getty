//
//  HYGuideNotificationController.m
//  Fleshy
//
//  Created by Hyyy on 2017/11/27.
//  Copyright © 2017年 Hyyy. All rights reserved.
//

#import "HYGuideNotificationController.h"

@interface HYGuideNotificationController ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) UIButton *notificationBtn;

@end

@implementation HYGuideNotificationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.descLabel];
    [self.view addSubview:self.notificationBtn];
    [self layoutSubViews];
}

- (void)layoutSubViews {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(80);
        make.left.equalTo(self.view.mas_left).offset(30);
        make.right.equalTo(self.view.mas_right).offset(-30);
        make.height.mas_equalTo(35);
    }];
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(15);
        make.left.equalTo(self.view.mas_left).offset(30);
        make.right.equalTo(self.view.mas_right).offset(-30);
    }];
    [self.notificationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.bottom.equalTo(self.view.mas_bottom).offset(-50);
        make.size.mas_equalTo(CGSizeMake(120, 120));
    }];
}

#pragma mark - Events
- (void)touchedDownNotificationBtnHandler {
    CGFloat scale = 0.9;
    [UIView animateWithDuration:0.15 animations:^{
        self.notificationBtn.transform = CGAffineTransformMakeScale(scale, scale);
    }];
}

- (void)clickedNotificationBtnHandler {
    [UIView animateWithDuration:0.15 animations:^{
        self.notificationBtn.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        // 执行动作响应，注册通知
        [HYLocalNotification registerNotificationCompleteHandler:^(BOOL granted, NSError * _Nullable error) {
            if (granted) {
                // 引导页消失
                [self dismissNotificationPage];
            }else {
                // 打开权限提示页面
                [self addNotAllowNotificationPage];
            }
        }];
    }];
}

#pragma mark - Private Methods
- (void)addNotAllowNotificationPage {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"您没有允许显示通知，会影响App功能。请前往设置页开启此功能。" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *finishAction = [UIAlertAction actionWithTitle:@"前往设置页面" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        // 跳转到APP设置页
        [[UIApplication sharedExtensionApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:^(BOOL success) {

        }];
    }];
    [alertVC addAction:finishAction];
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (void)dismissNotificationPage {
    [self.navigationController removeFromParentViewController];
    [UIView animateWithDuration:0.5 animations:^{
        self.navigationController.view.transform = CGAffineTransformMakeScale(0.1, 0.1);
        self.navigationController.view.alpha = 0;
    } completion:^(BOOL finished) {
        // dismiss引导页
        [self removeFromParentViewController];
        [self.view removeFromSuperview];
    }];
}

#pragma mark - Setter and Getter
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:kTextSizeBig];
        _titleLabel.textColor = kTitleColor;
        _titleLabel.text = @"开启推送，享受更好地体验";
    }
    return _titleLabel;
}

- (UILabel *)descLabel {
    if (!_descLabel) {
        _descLabel = [UILabel new];
        _descLabel.textAlignment = NSTextAlignmentCenter;
        _descLabel.font = [UIFont systemFontOfSize:kTextSizeMedium];
        _descLabel.textColor = kDescColor;
        _descLabel.text = @"由于App需要获取推送权限才能更好地服务于用户，再次声明，开启推送并不会收集个人信息和广告推送，请放心使用！";
        _descLabel.numberOfLines = 0;
    }
    return _descLabel;
}

- (UIButton *)notificationBtn {
    if (!_notificationBtn) {
        _notificationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_notificationBtn setTitle:@"开启推送" forState:UIControlStateNormal];
        [_notificationBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _notificationBtn.backgroundColor = kMainColor;
        _notificationBtn.layer.cornerRadius = 60;
        _notificationBtn.layer.masksToBounds = YES;
        [_notificationBtn addTarget:self action:@selector(touchedDownNotificationBtnHandler) forControlEvents:UIControlEventTouchDown];
        [_notificationBtn addTarget:self action:@selector(clickedNotificationBtnHandler) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchUpOutside];
    }
    return _notificationBtn;
}

@end
