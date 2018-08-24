//
//  LogListViewController.m
//  Sync2
//
//  Created by Sanchit Mittal on 26/07/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import "LogListViewController.h"
#import "LogInformationViewController.h"

#import "Device.h"
#import "SDKManager.h"

@import SixgillSDK;

@implementation LogListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    
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
    [self datesSelected:sender onSuccessHandler:nil];
}


#pragma mark - LogBaseViewController


- (void)logsChanged {
    [super logsChanged];
    dispatch_async(dispatch_get_main_queue(),^{
        [self.tableview reloadData];
        self.eventCountLabel.text = [NSString stringWithFormat:@"%lu Events", (unsigned long)self.logs.count];
    });
    
}

- (void)updateDateLabel {
    [super updateDateLabel];
    dispatch_async(dispatch_get_main_queue(),^{
        _dateLabel.text = [NSString stringWithFormat:@"%@-%@", [self.dateLabelFormatter  stringFromDate:self.fromDate], [self.dateLabelFormatter  stringFromDate:self.toDate]];
    });
}

- (void)updateViewWithSensorData {
    [super updateViewWithSensorData];
    [self filterLogList];
}

@end
