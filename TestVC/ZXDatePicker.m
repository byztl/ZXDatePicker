//
//  ZXDataPicker.m
//  WSL
//
//  Created by byztl on 2017/8/5.
//  Copyright © 2017年 com.netmarch. All rights reserved.
//

#define ZXToolViewHeight     40
#define ZXToolBtnWidth       70
#define ZXPickerViewHeight   200
#define screenWidth SCREEN_WIDTH
#define screenHeight SCREEN_HEIGHT
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#import "ZXDatePicker.h"
static UIView *datePickerView;
static UIDatePicker *datePicker;
static void (^timeBlock)(NSString *);
static  NSDateFormatter *dateFormatter;

@interface ZXDatePicker ()

@end
@implementation ZXDatePicker

+(void)datePickerViewWithType:(DatePicerType)datePickerType andChoiceBlock: (void (^)(NSString *choiceDate))choiceBlock{
    timeBlock = choiceBlock;
    [ZXDatePicker setupDatepickerWitHtype:datePickerType];
}
//日期选择器
+(void)setupDatepickerWitHtype:(DatePicerType)dateType{
    //日期选择器
    datePickerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    datePickerView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.2];
    [[UIApplication sharedApplication].keyWindow addSubview:datePickerView];
    //    datePickerView_.hidden = true;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapMaskViewAction:)];
    [datePickerView addGestureRecognizer:tap];
    
    datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, screenHeight, screenWidth, ZXPickerViewHeight)];
    datePicker.backgroundColor = [UIColor whiteColor];
//    datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
    datePicker.datePickerMode = UIDatePickerModeDate;
    dateFormatter = [[NSDateFormatter alloc] init];
    datePicker.datePickerMode = UIDatePickerModeCountDownTimer;
    switch (dateType) {
        case DatePicerTypeDefault:
             [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            break;
        case DatePicerTypeTime:
            datePicker.datePickerMode = UIDatePickerModeTime;
            break;
        case DatePicerTypeDateAndTime:
             [dateFormatter setDateFormat:@"MM-dd HH:mm"];
            datePicker.datePickerMode = UIDatePickerModeDateAndTime;
            break;
        case DatePicerTypeCountDownTimer:
            datePicker.datePickerMode = UIDatePickerModeCountDownTimer;
            break;
        default:
            break;
    }
    
    //    datePicker_.maximumDate = [NSDate date];
    [datePickerView addSubview:datePicker];
    
    UIView * toolView = [[UIView alloc] initWithFrame:CGRectMake(0, screenHeight + ZXToolViewHeight, screenWidth, ZXToolViewHeight)];
    toolView.backgroundColor = [UIColor whiteColor];
    [datePickerView addSubview:toolView];
    UIButton * cancleBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    cancleBtn.frame = CGRectMake(0, 0, ZXToolBtnWidth, ZXToolViewHeight);
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancleBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [cancleBtn addTarget:self action:@selector(cancleBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [toolView addSubview:cancleBtn];
    
    UIButton * confirmBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    confirmBtn.frame = CGRectMake(screenWidth - ZXToolBtnWidth, 0, ZXToolBtnWidth, ZXToolViewHeight);
    [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    confirmBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [confirmBtn addTarget:self action:@selector(confirmBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [toolView addSubview:confirmBtn];
    
    //动画的实现
    [UIView animateWithDuration:0.25 animations:^{
        datePicker.frame = CGRectMake(0, screenHeight - ZXPickerViewHeight, screenWidth, ZXPickerViewHeight);
        toolView.frame = CGRectMake(0, screenHeight - ZXPickerViewHeight - ZXToolViewHeight, screenWidth, ZXToolViewHeight);
    }];
}

//点击了背景
+ (void)tapMaskViewAction:(UITapGestureRecognizer *)tap {
    [datePickerView removeFromSuperview];
    [ZXDatePicker deleteAll];
}

//点击了取消
+ (void)cancleBtnAction:(UIButton *)button {
    [datePickerView removeFromSuperview];
    [ZXDatePicker deleteAll];
}

//点击了确定
+ (void)confirmBtnAction:(UIButton *)button {
    [datePickerView removeFromSuperview];
    NSString *dataStr  = [dateFormatter stringFromDate:datePicker.date];
    timeBlock(dataStr);
    [ZXDatePicker deleteAll];
}

//删除所有的全局变量,防止循环引用
+(void)deleteAll{
    datePicker = nil;
    datePickerView = nil;
    timeBlock = nil;
}


@end
