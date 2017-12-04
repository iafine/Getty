//
//  HYPlanEditController.h
//  Fleshy
//
//  Created by Hyyy on 2017/11/28.
//  Copyright © 2017年 Hyyy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, HYPlanDetailOperate) {
    HYPlanDetailOperateInsert,  // 添加页面
    HYPlanDetailOperateUpdate,    // 更新页面
};

@interface HYPlanEditController : UIViewController

@property (nonatomic, strong) HYPlan *plan;

@property (nonatomic, assign) HYPlanDetailOperate operateType;

@end
