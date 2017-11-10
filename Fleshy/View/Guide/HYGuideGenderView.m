//
//  HYGuideGenderView.m
//  Fleshy
//
//  Created by Hyyy on 2017/10/27.
//  Copyright © 2017年 Hyyy. All rights reserved.
//

#import "HYGuideGenderView.h"

NSString *const HYGuideGenderNextEvent = @"HYGuideGenderNextEvent";
// 选中性别的缓存key
static NSString *const kHYGuideGenderCacheKey = @"kHYGuideGenderCacheKey";

@interface HYGuideGenderView ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *tipLabel;

@property (nonatomic, strong) UIImageView *maleImageView;
@property (nonatomic, strong) UIImageView *femaleImageView;

@property (nonatomic, strong) UIButton *nextBtn;

@end

@implementation HYGuideGenderView

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
    [self addSubview:self.titleLabel];
    [self addSubview:self.tipLabel];
    [self addSubview:self.maleImageView];
    [self addSubview:self.femaleImageView];
    [self addSubview:self.nextBtn];
}

- (void)initLayout {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(15);
        make.top.equalTo(self.mas_top).offset(15);
        make.height.mas_equalTo(@44);
    }];
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(15);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(@30);
    }];
    [self.maleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tipLabel.mas_bottom).offset(40);
        make.centerX.equalTo(self.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(150, 150));
    }];
    [self.femaleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.maleImageView.mas_bottom).offset(40);
        make.centerX.equalTo(self.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(150, 150));
    }];
    [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(-30);
        make.centerX.equalTo(self.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(200, 40));
    }];
}

#pragma mark - Events
- (void)clickedNextBtnHandler {
    [self hy_routerEventWithName:HYGuideGenderNextEvent userInfo:nil];
}

- (void)clickedMaleImageViewHandler {
    self.nextBtn.backgroundColor = kMaleColor;
    
    [HYCacheHelper setCacheValue:@"male" cacheKey:kHYGuideGenderCacheKey cacheType:HYCacheDisk];
}

- (void)clickedFemaleImageViewHandler {
    self.nextBtn.backgroundColor = kFemaleColor;
    
    [HYCacheHelper setCacheValue:@"female" cacheKey:kHYGuideGenderCacheKey cacheType:HYCacheDisk];
}

#pragma mark - Setter and Getter
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:kTextSizeLarge weight:UIFontWeightBold];
        _titleLabel.textColor = kBlackColor;
        _titleLabel.adjustsFontSizeToFitWidth = YES;
        _titleLabel.text = @"选择性别";
    }
    return _titleLabel;
}

- (UILabel *)tipLabel {
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.font = [UIFont systemFontOfSize:kTextSizeSlightSmall];
        _tipLabel.textColor = kDeepGrayColor;
        _tipLabel.adjustsFontSizeToFitWidth = YES;
        _tipLabel.text = @"配合性别，可以获取更好的展示体验";
    }
    return _tipLabel;
}

- (UIImageView *)maleImageView {
    if (!_maleImageView) {
//        _maleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"guide_gender_male"]];
        _maleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
        _maleImageView.layer.cornerRadius = 150/2;
        _maleImageView.backgroundColor = kMaleColor;
        _maleImageView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickedMaleImageViewHandler)];
        [_maleImageView addGestureRecognizer:tapGR];
    }
    return _maleImageView;
}

- (UIImageView *)femaleImageView {
    if (!_femaleImageView) {
//        _femaleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"guide_gender_female"]];
        _femaleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
        _femaleImageView.layer.cornerRadius = 150/2;
        _femaleImageView.backgroundColor = kFemaleColor;
        _femaleImageView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickedFemaleImageViewHandler)];
        [_femaleImageView addGestureRecognizer:tapGR];
    }
    return _femaleImageView;
}

- (UIButton *)nextBtn {
    if (!_nextBtn) {
        _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _nextBtn.backgroundColor = [UIColor clearColor];
        [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
        [_nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _nextBtn.titleLabel.font = [UIFont systemFontOfSize:kTextSizeBig];
        _nextBtn.layer.cornerRadius = 20;
        _nextBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
        [_nextBtn addTarget:self action:@selector(clickedNextBtnHandler) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextBtn;
}

@end
