//
//  HYTopAlertView.m
//  Fleshy
//
//  Created by Hyyy on 2017/11/16.
//  Copyright © 2017年 Hyyy. All rights reserved.
//

#import "HYTopAlertView.h"

static HYTopAlertView *_topAlert;

@interface HYTopAlertView ()

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UILabel *subTipLabel;

@end

@implementation HYTopAlertView

#pragma mark - Life Cycle
- (instancetype)initAlertWithTitle:(NSString *)title subTitle:(NSString *)subTitle {
    self = [super initWithFrame:kScreenBounds];
    if (self) {
        self.tipLabel.text = title;
        self.subTipLabel.text = subTitle;
        
        [self addSubview:self.contentView];
        [self.contentView addSubview:self.tipLabel];
        [self.contentView addSubview:self.subTipLabel];
    }
    return self;
}

- (void)show {
    [UIApplication sharedApplication].keyWindow.windowLevel = UIWindowLevelStatusBar + 1;
    [[[UIApplication sharedApplication] keyWindow] addSubview:self];
    
    CGRect newFrame = CGRectMake(0, 0, kScreenWidth, kStatusBarHeight + kNavHeight);
    [UIView animateWithDuration:0.5 delay:0.0 usingSpringWithDamping:0.9 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
        self.contentView.frame = newFrame;
    } completion:^(BOOL finished) {
        // 1.5秒过后，弹出框消失
        [self performSelector:@selector(dismiss) withObject:nil afterDelay:1.5];
    }];
}

- (void)dismiss {
    CGRect oldFrame = CGRectMake(0, -(kStatusBarHeight + kNavHeight), kScreenWidth, kStatusBarHeight + kNavHeight);
    [UIView animateWithDuration:0.3 animations:^{
        self.contentView.frame = oldFrame;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [UIApplication sharedApplication].keyWindow.windowLevel = UIWindowLevelNormal;
    }];
}

#pragma mark - Setter and Getter
- (UIView *)contentView {
    if (!_contentView) {
        CGRect topAlertRect = CGRectMake(0, -(kStatusBarHeight + kNavHeight), kScreenWidth, kStatusBarHeight + kNavHeight);
        _contentView = [[UIView alloc] initWithFrame:topAlertRect];
        _contentView.backgroundColor = kMainColor;
    }
    return _contentView;
}

- (UILabel *)tipLabel {
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, kScreenWidth - 30, 30)];
        _tipLabel.textColor = [UIColor whiteColor];
        _tipLabel.textAlignment = NSTextAlignmentLeft;
        _tipLabel.font = [UIFont systemFontOfSize:17.f];
    }
    return _tipLabel;
}

- (UILabel *)subTipLabel {
    if (!_subTipLabel) {
        _subTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 40, kScreenWidth - 30, 20)];
        _subTipLabel.textColor = [UIColor whiteColor];
        _subTipLabel.textAlignment = NSTextAlignmentLeft;
        _subTipLabel.font = [UIFont systemFontOfSize:14.f];
    }
    return _subTipLabel;
}

@end
