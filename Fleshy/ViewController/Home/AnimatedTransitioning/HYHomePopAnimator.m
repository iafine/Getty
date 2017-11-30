//
//  HYHomePopAnimator.m
//  Fleshy
//
//  Created by Hyyy on 2017/11/20.
//  Copyright © 2017年 Hyyy. All rights reserved.
//

#import "HYHomePopAnimator.h"
#import "HYHomeViewController.h"
#import "HYPlanEditController.h"
#import "HYHomePlanCell.h"

@implementation HYHomePopAnimator

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    // 获取源控制器和目标控制器
//    HYPlanEditController *detailVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
//    HYHomeViewController *homeVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
//    UIView *containerView = [transitionContext containerView];
//
//    // 设置源控制器
//    UIView *snapshotView = [detailVC.view snapshotViewAfterScreenUpdates:NO];
//    snapshotView.backgroundColor = [UIColor clearColor];
//    snapshotView.frame = [containerView convertRect:detailVC.view.frame fromView:detailVC.view];
//
//    // 设置目标控制器
//    homeVC.view.frame = [transitionContext finalFrameForViewController:homeVC];
//    homeVC.selectedCell.radiusBgView.hidden = YES;
//
//    [containerView addSubview:homeVC.view];
//    [containerView addSubview:detailVC.view];
//
//    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0f usingSpringWithDamping:0.6f initialSpringVelocity:1.0f options:UIViewAnimationOptionCurveLinear animations:^{
//        snapshotView.frame = homeVC.selectedCell.radiusBgView.frame;
//        homeVC.view.alpha = 1;
//    } completion:^(BOOL finished) {
//        [snapshotView removeFromSuperview];
//        homeVC.selectedCell.radiusBgView.hidden = NO;
//        
//        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
//    }];
    
}
@end
