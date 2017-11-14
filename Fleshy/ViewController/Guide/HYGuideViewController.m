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
#import "HYGuideFinishView.h"
#import "HYPlan.h"
#import "HYPerformance.h"
#import "HYPlan+Database.h"

NSString *const HYGuideChangeColorEvent = @"HYGuideChangeColorEvent";

@interface HYGuideViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) HYGuideGenderView *guideGenderView;   // 性别引导页面
@property (nonatomic, strong) HYGuideChooseTimeView *chooseTimeView;    // 时间选择页面
@property (nonatomic, strong) HYGuideFinishView *finishView;        // 完成页面

@property (nonatomic, strong) HYPlan *plan;

@end

@implementation HYGuideViewController

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kPageBgColor;
    
//    UIImageView *titleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav_icon"]];
//    titleImageView.contentMode = UIViewContentModeScaleAspectFit;
//    self.navigationItem.titleView = titleImageView;
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.guideGenderView];
    [self.scrollView addSubview:self.chooseTimeView];
    [self.scrollView addSubview:self.finishView];
}

#pragma mark - Events
- (void)hy_routerEventWithName:(NSString *)eventName userInfo:(id)userInfo {
    if ([HYGuideGenderNextEvent isEqualToString:eventName]) {
        [self.scrollView setContentOffset:CGPointMake(kScreenWidth, 0) animated:YES];
        
        [self refreshView];
    }else if ([HYGuideChooseTimeNextEvent isEqualToString:eventName]) {
        [self.scrollView setContentOffset:CGPointMake(kScreenWidth * 2, 0) animated:YES];
        
        [self.finishView reloadData:userInfo];
    }else if ([HYGuideFinishBtnEvent isEqualToString:eventName]) {
        // 引导页消失，刷新数据
        self.plan = (HYPlan *)userInfo;
        [self generatePlanData];
        
        [self.navigationController removeFromParentViewController];
        [UIView animateWithDuration:0.5 animations:^{
            self.navigationController.view.transform = CGAffineTransformMakeScale(0.1, 0.1);
            self.navigationController.view.alpha = 0;
        } completion:^(BOOL finished) {
            [self removeFromParentViewController];
            [self.view removeFromSuperview];
        }];
    }else {
        [super hy_routerEventWithName:eventName userInfo:userInfo];
    }
}

#pragma mark - Private Methods
- (void)refreshView {
    [self.chooseTimeView refreshView];
}

- (void)generatePlanData {
    // 生成一条计划数据，然后创建多条执行数据与之对应
    [self.view hy_showLoading];
    [HYPlan databasae_insertPlan:self.plan block:^(BOOL isSuccess, NSString *message) {
        if (isSuccess) {
            [HYPlan database_queryPlan:self.plan.planName block:^(BOOL isSuccess, HYPlan *plan, NSString *message) {
                NSLog(@"%@", plan);
            }];
        }
    }];
//    for (int i = 1; i <= self.plan.durationDays; i++) {
//        HYPerformance *performance = [[HYPerformance alloc] init];
//        performance.planId = self.plan.planId;
//        performance.performDate = [self.plan.startTime dateByAddingDays:i];
//    }
    [self.view hy_hideLoading];
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

- (HYGuideFinishView *)finishView {
    if (!_finishView) {
        _finishView = [[HYGuideFinishView alloc] initWithFrame:CGRectMake(kScreenWidth * 2, 0, kScreenWidth, kScreenHeight - 64)];
    }
    return _finishView;
}

- (HYPlan *)plan {
    if (!_plan) {
        _plan = [[HYPlan alloc] init];
    }
    return _plan;
}

@end
