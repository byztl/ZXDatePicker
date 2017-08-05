//
//  ZXDataPicker.h
//  WSL
//
//  Created by byztl on 2017/8/5.
//  Copyright © 2017年 com.netmarch. All rights reserved.
//

typedef enum {
    DatePicerTypeDefault = 0,
    DatePicerTypeTime = 1,
    DatePicerTypeDateAndTime = 2,
    DatePicerTypeCountDownTimer = 3
}DatePicerType;

#import <UIKit/UIKit.h>


@interface ZXDatePicker : UIView
+(void)datePickerViewWithType:(DatePicerType) datePickerType andChoiceBlock: (void (^)(NSString *choiceDate))choiceBlock;
@end
