//
//  HYHomePushAnimator.m
//  Fleshy
//
//  Created by Hyyy on 2017/11/20.
//  Copyright © 2017年 Hyyy. All rights reserved.
//

#import "HYHomePushAnimator.h"
#import "HYHomeViewController.h"
#import "HYPlanDetailController.h"
#import "HYTimelineCollectionCell.h"

@implementation HYHomePushAnimator

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    // 获取源控制器和目标控制器
    HYHomeViewController *homeVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    HYPlanDetailController *detailVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    
    // 获取cell的截图
    UIView *snapshotView = [homeVC.selectedCell.radiusBgView snapshotViewAfterScreenUpdates:NO];
    snapshotView.frame = [containerView convertRect:homeVC.selectedCell.radiusBgView.frame fromView:homeVC.selectedCell];
    homeVC.selectedCell.radiusBgView.hidden = YES;
    
    // 设置目标控制器
    detailVC.view.frame = [transitionContext finalFrameForViewController:detailVC];
    detailVC.view.alpha = 0;
    
    [containerView addSubview:detailVC.view];
    [containerView addSubview:snapshotView];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0f usingSpringWithDamping:1.0f initialSpringVelocity:1.0f options:UIViewAnimationOptionCurveLinear animations:^{
        snapshotView.frame = detailVC.view.frame;
        detailVC.view.alpha = 1;
    } completion:^(BOOL finished) {
        homeVC.selectedCell.radiusBgView.hidden = NO;
        [snapshotView removeFromSuperview];
        
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

@end
