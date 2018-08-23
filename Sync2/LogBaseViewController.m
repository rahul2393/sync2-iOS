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

@implementation LogBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Setting initial `from` as today's 12am and `to` date as current time.
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier: NSCalendarIdentifierGregorian];
    _fromDate = [calendar dateBySettingHour:0 minute:0 second:0 ofDate:[NSDate date] options:0];
    _toDate = [NSDate date];
    
    _dateLabelFormatter = [[NSDateFormatter alloc] init];
    [_dateLabelFormatter setDateFormat:@"MMM dd, h:mm a"];
    
    [self filterLogList];
    
    [self updateDateLabel];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateViewWithSensorData)
                                                 name:@"sensorDataUpdated"
                                               object:nil];
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setLogs:(NSArray *)logs {
    _logs = logs;
    [self logsChanged];
}


- (void)filterLogList {
    self.logs = [[[SDKManager sharedManager] sensorsData] filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(Event*  _Nullable log, NSDictionary<NSString *,id> * _Nullable bindings) {
        
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:(log.timestamp / 1000.0)];
        
        if([date compare: _fromDate] == NSOrderedDescending &&  [date compare:_toDate] == NSOrderedAscending) {
            return true;
        }
        return false;
    }]];
    
    [self updateDateLabel];
}

- (void)datesSelected:(id)sender {
    __block NSDate *localFromDate = nil;
    
    [ActionSheetDatePicker showPickerWithTitle:@"From" datePickerMode:UIDatePickerModeDateAndTime selectedDate:[NSDate date] doneBlock:^(ActionSheetDatePicker *picker, id selectedDate, id origin) {
        localFromDate = selectedDate;
        [ActionSheetDatePicker showPickerWithTitle:@"To" datePickerMode:UIDatePickerModeDateAndTime selectedDate:selectedDate minimumDate:selectedDate maximumDate:[NSDate distantFuture] doneBlock:^(ActionSheetDatePicker *picker, id selectedDate, id origin) {
            self.fromDate = localFromDate;
            self.toDate = selectedDate;
            [self filterLogList];
        } cancelBlock:^(ActionSheetDatePicker *picker) {
            
        }
                                            origin:sender];
    } cancelBlock:^(ActionSheetDatePicker *picker) {
        
    }
                                        origin:sender];
}

# pragma mark - Methods to be overridden

- (void)logsChanged {
    
}

- (void)updateDateLabel {
    
}

- (void)updateViewWithSensorData {
    
}

@end
