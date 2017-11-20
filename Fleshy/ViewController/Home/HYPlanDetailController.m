//
//  HYPlanDetailController.m
//  Fleshy
//
//  Created by Hyyy on 2017/11/20.
//  Copyright © 2017年 Hyyy. All rights reserved.
//

#import "HYPlanDetailController.h"
#import "HYHomeViewController.h"
#import "HYHomePopAnimator.h"

@interface HYPlanDetailController ()<UINavigationControllerDelegate>

@end

@implementation HYPlanDetailController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = self.bgColor;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:0];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.navigationController.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
    if (self.navigationController.delegate == self) {
        self.navigationController.delegate = nil;
    }
}

#pragma mark - UINavigationControllerDelegate
- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC {
    if ([toVC isKindOfClass:[HYHomeViewController class]]) {
        return [[HYHomePopAnimator alloc] init];
    }else {
        return nil;
    }
}

@end
