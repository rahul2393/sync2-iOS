//
//  LogListViewController.m
//  Sync2
//
//  Created by Sanchit Mittal on 26/07/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import "LogListViewController.h"
#import "LogMapViewController.h"
#import "ActionSheetPicker.h"

@import SixgillSDK;
@interface LogListViewController ()
@property NSDate* fromDate;
@property NSDate* toDate;
@property NSArray* logs;
-(void) filterLogList;
@end

@implementation LogListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    
    self.logs = [SGSDK sensorUpdateHistory:100];
    [self.tableview reloadData];

    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier: NSCalendarIdentifierGregorian];
    _fromDate = [calendar dateBySettingHour:0 minute:0 second:0 ofDate:[NSDate date] options:0];
    _toDate = [NSDate date];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.eventCountLabel.text = [NSString stringWithFormat:@"%lu Events", (unsigned long)self.logs.count];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.logs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LogListCellIdentifier" forIndexPath:indexPath];
    
    NSDictionary *d = self.logs[indexPath.row];
    
    NSDate *date = [[NSDate alloc] initWithTimeInterval:0 sinceDate:d[@"location-timestamp"]];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"h:mm:ss a, MMMM dd, yyyy"];
    cell.textLabel.text = [dateFormatter  stringFromDate:date];

    return cell;
}

#pragma mark - Table view data source

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LogMapViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"LogMapViewControllerIdentifier"];
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

- (void)filterLogList {
    
    self.logs = [SGSDK sensorUpdateHistory:100];
    
    self.logs = [self.logs filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        NSDate *date = [[NSDate alloc] initWithTimeInterval:0 sinceDate:evaluatedObject[@"location-timestamp"]];
        
        if([date compare: _fromDate] == NSOrderedDescending &&  [date compare:_toDate] == NSOrderedAscending) {
            return true;
        }
        return false;
    }]];
    
    [self.tableview reloadData];

}

@end
