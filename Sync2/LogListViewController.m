//
//  LogListViewController.m
//  Sync2
//
//  Created by Sanchit Mittal on 26/07/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import "LogListViewController.h"
#import "LogInformationViewController.h"
#import "ActionSheetPicker.h"
#import "Device.h"
#import "SDKManager.h"

@import SixgillSDK;
@interface LogListViewController ()
@property NSDate* fromDate;
@property NSDate* toDate;
@property (nonatomic) NSArray* logs;
@property NSDateFormatter *dateLabelFormatter;
-(void) updateDateLabel;
-(void) filterLogList;
@end

@implementation LogListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    
    // Setting initial `from` as today's 12am and `to` date as current time.
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier: NSCalendarIdentifierGregorian];
    _fromDate = [calendar dateBySettingHour:0 minute:0 second:0 ofDate:[NSDate date] options:0];
    _toDate = [NSDate date];
    
    _dateLabelFormatter = [[NSDateFormatter alloc] init];
    [_dateLabelFormatter setDateFormat:@"MMM dd, h:mm a"];
    [self updateDateLabel];
    
    [self filterLogList];
    
    
    // Setting tableview constraints
    switch (UIDevice.currentDevice.screenType) {
        case iPhoneX:
        case iPhones_6Plus_6sPlus_7Plus_8Plus:
            self.tableViewHeightConstraint.constant = 440;
            break;
        case iPhones_6_6s_7_8:
            self.tableViewHeightConstraint.constant = 352;
            break;
        case iPhones_5_5s_5c_SE:
            self.tableViewHeightConstraint.constant = 264;
            break;
        default:
            break;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(filterLogList)
                                                 name:@"sensorDataUpdated"
                                               object:nil];
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setLogs:(NSArray *)logs {
    _logs = logs;
    dispatch_async(dispatch_get_main_queue(),^{
        [self.tableview reloadData];
        self.eventCountLabel.text = [NSString stringWithFormat:@"%lu Events", (unsigned long)self.logs.count];
    });
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.logs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LogListCellIdentifier" forIndexPath:indexPath];
    
    Event *d = self.logs[indexPath.row];
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:(d.timestamp / 1000.0)];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"h:mm:ss a, MMMM dd, yyyy"];
    cell.textLabel.text = [dateFormatter stringFromDate:date];

    return cell;
}

#pragma mark - Table view data source

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LogInformationViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"LogInformationViewControllerIdentifier"];
    vc.event = self.logs[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - IBAction

- (IBAction)selectDateTapped:(id)sender {
    __block NSDate *localFromDate = nil;

    [ActionSheetDatePicker showPickerWithTitle:@"From" datePickerMode:UIDatePickerModeDateAndTime selectedDate:[NSDate date] doneBlock:^(ActionSheetDatePicker *picker, id selectedDate, id origin) {
        localFromDate = selectedDate;
        [ActionSheetDatePicker showPickerWithTitle:@"To" datePickerMode:UIDatePickerModeDateAndTime selectedDate:selectedDate minimumDate:selectedDate maximumDate:[NSDate distantFuture] doneBlock:^(ActionSheetDatePicker *picker, id selectedDate, id origin) {
            _fromDate = localFromDate;
            _toDate = selectedDate;
            [self filterLogList];
        } cancelBlock:^(ActionSheetDatePicker *picker) {
            
        }
        origin:sender];
    } cancelBlock:^(ActionSheetDatePicker *picker) {
        
    }
    origin:sender];

}

- (void)updateDateLabel {
    dispatch_async(dispatch_get_main_queue(),^{
        _dateLabel.text = [NSString stringWithFormat:@"%@-%@", [_dateLabelFormatter  stringFromDate:_fromDate], [_dateLabelFormatter  stringFromDate:_toDate]];
    });
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

@end
