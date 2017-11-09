//
//  UIResponder+HYAdd.m
//  Fleshy
//
//  Created by Hyyy on 2017/10/31.
//  Copyright © 2017年 Hyyy. All rights reserved.
//

#import "UIResponder+HYAdd.h"

@implementation UIResponder (HYAdd)

- (void)hy_routerEventWithName:(NSString *)eventName userInfo:(id)userInfo {
    [[self nextResponder] hy_routerEventWithName:eventName userInfo:userInfo];
}

@end
