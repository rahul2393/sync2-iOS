//
//  LogBaseViewController.m
//  Sync2
//
//  Created by Sanchit Mittal on 23/08/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LogBaseViewController.h"
#import "SDKManager.h"
#import "ActionSheetPicker.h"

#define KEY_FROMDATE @"fromDate"

#define KEY_TODATE @"toDate"


@implementation LogBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dateLabelFormatter = [[NSDateFormatter alloc] init];
    [_dateLabelFormatter setDateFormat:@"MMM dd, h:mm a"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateViewWithSensorData)
                                                 name:@"sensorDataUpdated"
                                               object:nil];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self filterLogList];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setLogs:(NSArray *)logs {
    _logs = logs;
    [self logsChanged];
}

- (void)setFromDate:(NSDate *)fromDate {
    [[NSUserDefaults standardUserDefaults] setObject:fromDate forKey:KEY_FROMDATE];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSDate *)fromDate {
    NSDate *fromDate = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_FROMDATE];
    if (!fromDate) {
//        Setting initial `from` as today's 12am
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier: NSCalendarIdentifierGregorian];
        NSDate *date = [calendar dateBySettingHour:0 minute:0 second:0 ofDate:[NSDate date] options:0];
        [[NSUserDefaults standardUserDefaults] setObject:date forKey:KEY_FROMDATE];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        return date;
    }
    return fromDate;
}

- (void)setToDate:(NSDate *)toDate {
    [[NSUserDefaults standardUserDefaults] setObject:toDate forKey:KEY_TODATE];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSDate *)toDate {
    NSDate *toDate = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_TODATE];
    if (!toDate) {
//        Setting initial `to` as today's 11:59:59 pm
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier: NSCalendarIdentifierGregorian];
        NSDate *date = [calendar dateBySettingHour:23 minute:59 second:59 ofDate:[NSDate date] options:0];
        [[NSUserDefaults standardUserDefaults] setObject:date forKey:KEY_TODATE];
        [[NSUserDefaults standardUserDefaults] synchronize];

        return date;
    }
    return toDate;
}

- (void)filterLogList {
    self.logs = [[[SDKManager sharedManager] sensorsData] filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(Event*  _Nullable log, NSDictionary<NSString *,id> * _Nullable bindings) {
        
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:(log.timestamp / 1000.0)];
        
        if([date compare: self.fromDate] == NSOrderedDescending &&  [date compare:self.toDate] == NSOrderedAscending) {
            return true;
        }
        return false;
    }]];
    
    [self updateDateLabel];
}


- (void)datesSelected:(id)sender onSuccessHandler:(void (^)())onSuccessBlock {
    __block NSDate *localFromDate = nil;
    
    [ActionSheetDatePicker showPickerWithTitle:@"From" datePickerMode:UIDatePickerModeDateAndTime selectedDate:[NSDate date] doneBlock:^(ActionSheetDatePicker *picker, id selectedDate, id origin) {
        localFromDate = selectedDate;
        [ActionSheetDatePicker showPickerWithTitle:@"To" datePickerMode:UIDatePickerModeDateAndTime selectedDate:selectedDate minimumDate:selectedDate maximumDate:[NSDate distantFuture] doneBlock:^(ActionSheetDatePicker *picker, id selectedDate, id origin) {
            self.fromDate = localFromDate;
            self.toDate = selectedDate;
            [self filterLogList];
            if (onSuccessBlock != nil) {
                onSuccessBlock();
            }
            
        } cancelBlock:^(ActionSheetDatePicker *picker) {
            
        } origin:sender];
    } cancelBlock:^(ActionSheetDatePicker *picker) {
        
    } origin:sender];
}

# pragma mark - Methods to be overridden

- (void)logsChanged {
    
}

- (void)updateDateLabel {
    
}

- (void)updateViewWithSensorData {
    
}

@end
