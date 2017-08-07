//
//  ViewController.m
//  TestVC
//
//  Created by byztl on 2017/8/5.
//  Copyright © 2017年 byztl. All rights reserved.
//

#import "ViewController.h"
#import "ZXDatePicker.h"
#import <objc/runtime.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *arr = [self filterPropertys];
    NSLog(@"%@",arr);
}
- (IBAction)timePick:(id)sender {
    [ZXDatePicker datePickerViewWithType:DatePicerTypeDateAndTime andChoiceBlock:^(NSString *choiceDate) {
        self.timeLabel.text = choiceDate;
    }];
}


- (NSArray *)filterPropertys
{
    NSMutableArray *props = [NSMutableArray array];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (i = 0; i<outCount; i++)
    {
        objc_property_t property = *properties;
        const char* char_f =property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        [props addObject:propertyName];
    }
    free(properties);
    return props;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
