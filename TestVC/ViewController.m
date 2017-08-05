//
//  ViewController.m
//  TestVC
//
//  Created by byztl on 2017/8/5.
//  Copyright © 2017年 byztl. All rights reserved.
//

#import "ViewController.h"
#import "ZXDatePicker.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)timePick:(id)sender {
    [ZXDatePicker datePickerViewWithType:DatePicerTypeDateAndTime andChoiceBlock:^(NSString *choiceDate) {
        self.timeLabel.text = choiceDate;
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
