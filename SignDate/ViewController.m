//
//  ViewController.m
//  SignDate
//
//  Created by 郭嘉 on 15/9/7.
//  Copyright (c) 2015年 郭嘉. All rights reserved.
//

#import "ViewController.h"
#import "LDCalendarView.h"
#import "NSDate+extend.h"

@interface ViewController ()

@property (nonatomic, strong)LDCalendarView    *calendarView;//日历控件
@property (nonatomic, strong)NSMutableArray *seletedDays;//选择的日期
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)ShowSignDate:(id)sender {
    //日期选择
    if (!_calendarView) {
        _calendarView = [[LDCalendarView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT)];
        [self.view addSubview:_calendarView];
        
        __weak typeof(self) weakSelf = self;
        _calendarView.complete = ^(NSArray *result) {
            if (result) {
                weakSelf.seletedDays = [result mutableCopy];
            }
        };
    }
    NSLog(@"%@",self.showStr);
    [self.calendarView show];
    self.calendarView.defaultDates = _seletedDays;
}
- (NSString *)showStr {
    NSMutableString *str = [NSMutableString string];
    
    [str appendString:@"已选择日期:\r\n"];
    //从小到大排序
    [self.seletedDays sortUsingComparator:^NSComparisonResult(NSNumber *obj1, NSNumber *obj2) {
        return [obj1 compare:obj2];
    }];
    for (NSNumber *interval in self.seletedDays) {
        NSString *partStr = [NSDate stringWithTimestamp:interval.doubleValue/1000.0 format:@"MM.dd"];
        [str appendFormat:@"%@ ",partStr];
    }
    return [str copy];
}


@end
