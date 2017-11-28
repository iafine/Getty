//
//  HYDatePickerView.h
//  Fleshy
//
//  Created by Hyyy on 2017/11/7.
//  Copyright © 2017年 Hyyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HYDatePickerView;
@protocol HYDatePickerViewDelegate <NSObject>

- (void)datePicker:(HYDatePickerView *)pickerView didSelectdDate:(NSDate *)date;

@end

@interface HYDatePickerView : UIView

@property (nonatomic, weak) id<HYDatePickerViewDelegate> delegate;

- (instancetype)initDatePickerView;

- (void)show;

@end
