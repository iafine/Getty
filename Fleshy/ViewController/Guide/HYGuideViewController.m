//
//  HYGuideViewController.m
//  Fleshy
//
//  Created by Hyyy on 2017/10/27.
//  Copyright © 2017年 Hyyy. All rights reserved.
//

#import "HYGuideViewController.h"
#import "HYGuideGenderView.h"

@interface HYGuideViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) HYGuideGenderView *guideGenderView;   // 性别引导页面

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
}

#pragma mark - Setter and Getter
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64)];
        _scrollView.pagingEnabled = YES;
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

@end
