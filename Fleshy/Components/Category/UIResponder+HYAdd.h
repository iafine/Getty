//
//  UIResponder+HYAdd.h
//  Fleshy
//
//  Created by Hyyy on 2017/10/31.
//  Copyright © 2017年 Hyyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIResponder (HYAdd)

- (void)hy_routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo;

@end
