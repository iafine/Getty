//
//  HYDatePickerView.h
//  Fleshy
//
//  Created by Hyyy on 2017/11/7.
//  Copyright © 2017年 Hyyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HYDatePickerViewDelegate <NSObject>

- (void)didSelectdDate:(NSDate *)date;

@end

@interface HYDatePickerView : UIView

@property (nonatomic, weak) id<HYDatePickerViewDelegate> delegate;

- (instancetype)initWithTitle:(NSString *)title;

- (void)show;

@end
