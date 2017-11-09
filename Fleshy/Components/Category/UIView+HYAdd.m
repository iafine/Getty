//
//  UIView+HYAdd.m
//  Fleshy
//
//  Created by Hyyy on 2017/11/8.
//  Copyright © 2017年 Hyyy. All rights reserved.
//

#import "UIView+HYAdd.h"

@implementation UIView (HYAdd)

- (void)shakeAnimation {
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    [basicAnimation setDuration:0.05];
    [basicAnimation setRepeatCount:4];
    [basicAnimation setAutoreverses:YES];
    [basicAnimation setFromValue:[NSValue valueWithCGPoint:
                             CGPointMake([self center].x - 10.0f, [self center].y)]];
    [basicAnimation setToValue:[NSValue valueWithCGPoint:
                           CGPointMake([self center].x + 10.0f, [self center].y)]];
    [[self layer] addAnimation:basicAnimation forKey:@"position"];
}

@end
