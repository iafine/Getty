//
//  HYPlanDetailController.h
//  Fleshy
//
//  Created by Hyyy on 2017/11/28.
//  Copyright © 2017年 Hyyy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, HYPlanDetailOperate) {
    HYPlanDetailOperateView,    // 查看页面
    HYPlanDetailOperateInsert,  // 添加页面
    HYPlanDetailOperateEdit,    // 编辑页面
};

@interface HYPlanDetailController : UIViewController

@property (nonatomic, strong) HYPlan *plan;

@property (nonatomic, assign) HYPlanDetailOperate operateType;

@end
