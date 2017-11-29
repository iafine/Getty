//
//  HYListPickView.h
//  Fleshy
//
//  Created by Hyyy on 2017/11/28.
//  Copyright © 2017年 Hyyy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HYListPickView;
@protocol HYListPickViewDelegate <NSObject>

- (void)listPicker:(HYListPickView *)pickerView didSelectdRow:(NSString *)rowString;

@end

@interface HYListPickView : UIView

@property (nonatomic, weak) id<HYListPickViewDelegate> delegate;

- (instancetype)initDatePickerView:(NSString *)title dataArray:(NSArray *)dataArray;

- (void)show;

@end
