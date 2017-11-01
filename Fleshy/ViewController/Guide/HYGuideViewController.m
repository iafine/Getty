//
//  HYGuideViewController.m
//  Fleshy
//
//  Created by Hyyy on 2017/10/27.
//  Copyright © 2017年 Hyyy. All rights reserved.
//

#import "HYGuideViewController.h"
#import "HYGuideGenderView.h"
#import "HYGuideChooseTimeView.h"

NSString *const HYGuideChangeColorEvent = @"HYGuideChangeColorEvent";

@interface HYGuideViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) HYGuideGenderView *guideGenderView;   // 性别引导页面
@property (nonatomic, strong) HYGuideChooseTimeView *chooseTimeView;    // 时间选择页面

@end

@implementation HYGuideViewController

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UIImageView *titleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav_icon"]];
//    titleImageView.contentMode = UIViewContentModeScaleAspectFit;
//    self.navigationItem.titleView = titleImageView;
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.guideGenderView];
    [self.scrollView addSubview:self.chooseTimeView];
}

#pragma mark - Events
- (void)hy_routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo {
    if ([HYGuideGenderNextEvent isEqualToString:eventName]) {
        [self.scrollView setContentOffset:CGPointMake(kScreenWidth, 0) animated:YES];
        
        [self refreshView];
    }else if ([HYGuideChooseTimeNextEvent isEqualToString:eventName]) {
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        
    }else {
        [super hy_routerEventWithName:eventName userInfo:userInfo];
    }
}

#pragma mark - Private Methods
- (void)refreshView {
    [self.chooseTimeView refreshView];
}

#pragma mark - Setter and Getter
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64)];
        _scrollView.scrollEnabled = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.scrollsToTop = NO;
        _scrollView.bounces = NO;
        _scrollView.contentSize = CGSizeMake(kScreenWidth * 3, kScreenHeight - 64);
        _scrollView.delegate = self;
        _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    return _scrollView;
}

- (HYGuideGenderView *)guideGenderView {
    if (!_guideGenderView) {
        _guideGenderView = [[HYGuideGenderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64)];
    }
    return _guideGenderView;
}

- (HYGuideChooseTimeView *)chooseTimeView {
    if (!_chooseTimeView) {
        _chooseTimeView = [[HYGuideChooseTimeView alloc] initWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight - 64)];
    }
    return _chooseTimeView;
}

@end
