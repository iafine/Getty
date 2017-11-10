//
//  HYMainViewController.m
//  Fleshy
//
//  Created by Hyyy on 2017/11/10.
//  Copyright © 2017年 Hyyy. All rights reserved.
//

#import "HYMainViewController.h"
#import "HYHomeViewController.h"
#import "HYGuideViewController.h"

@interface HYMainViewController ()

@property (nonatomic, strong) HYHomeViewController *homeVC;
@property (nonatomic, strong) UINavigationController *guideVC;

@end

@implementation HYMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addChildViewController:self.homeVC];
    [self.view addSubview:self.homeVC.view];
    
    // 如果还没有制定过计划，显示计划引导页面
    [self addChildViewController:self.guideVC];
    [self.view addSubview:self.guideVC.view];
    
}

#pragma mark - Setter and Getter
- (HYHomeViewController *)homeVC {
    if (!_homeVC) {
        _homeVC = [[HYHomeViewController alloc] init];
    }
    return _homeVC;
}

- (UINavigationController *)guideVC {
    if (!_guideVC) {
        _guideVC = [[UINavigationController alloc] initWithRootViewController:[HYGuideViewController new]];
    }
    return _guideVC;
}

@end
