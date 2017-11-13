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

@property (nonatomic, strong) UINavigationController *homeNavVC;
@property (nonatomic, strong) UINavigationController *guideNavVC;

@end

@implementation HYMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addChildViewController:self.homeNavVC];
    [self.view addSubview:self.homeNavVC.view];
    
    // 如果还没有制定过计划，显示计划引导页面
    [self addChildViewController:self.guideNavVC];
    [self.view addSubview:self.guideNavVC.view];    
}

#pragma mark - Setter and Getter
- (UINavigationController *)homeNavVC {
    if (!_homeNavVC) {
        _homeNavVC = [[UINavigationController alloc] initWithRootViewController:[HYHomeViewController new]];
    }
    return _homeNavVC;
}

- (UINavigationController *)guideNavVC {
    if (!_guideNavVC) {
        _guideNavVC = [[UINavigationController alloc] initWithRootViewController:[HYGuideViewController new]];
    }
    return _guideNavVC;
}

@end
