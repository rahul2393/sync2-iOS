//
//  NotificationViewController.m
//  SurveyNotificationContentExtension
//
//  Created by Sanchit Mittal on 30/08/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import "NotificationViewController.h"
#import <UserNotifications/UserNotifications.h>
#import <UserNotificationsUI/UserNotificationsUI.h>
#import "OptionSurveyTableViewCell.h"

#define SURVEY_OPTION_CELL_HEIGHT 38

@interface NotificationViewController () <UNNotificationContentExtension>

@property (nonatomic, strong) NSMutableArray *radioButtonChecked;

@end

@implementation NotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.radioButtonChecked = [[NSMutableArray alloc] init];
    
    [self.radioButtonChecked addObject:[NSNumber numberWithBool:TRUE]];
    [self.radioButtonChecked addObject:[NSNumber numberWithBool:FALSE]];
    [self.radioButtonChecked addObject:[NSNumber numberWithBool:TRUE]];
    [self.radioButtonChecked addObject:[NSNumber numberWithBool:FALSE]];
}

- (void)didReceiveNotification:(UNNotification *)notification {
    
    NSDictionary *data = notification.request.content.userInfo[@"data"];
    self.titleLabel.text = data[@"title"];
    self.detailLabel.text = data[@"body"];
    [self.button setTitle:data[@"buttonText"] forState:UIControlStateNormal];
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:([data[@"timestamp"] doubleValue] / 1000.0)];
    NSDateFormatter *dateLabelFormatter = [[NSDateFormatter alloc] init];
    [dateLabelFormatter setDateFormat:@"MMMM dd, h:mm a"];
    self.dateLabel.text = [NSString stringWithFormat:@"%@", [dateLabelFormatter  stringFromDate:date]];
    
    self.data = [NSMutableArray new];
    NSArray *options = data[@"options"];
    for (id option in options) {
        [self.data addObject:option[@"text"]];
    }
    
    self.tableViewHeightConstraint.constant = self.data.count * SURVEY_OPTION_CELL_HEIGHT;
    [self.tableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    OptionSurveyTableViewCell *cell = (OptionSurveyTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"NotificationOptionSurveyTableViewCellIdentifier" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    cell.optionValueLabel.text = self.data[indexPath.row];
    cell.selectedImageView.image = [[self.radioButtonChecked objectAtIndex:indexPath.row] boolValue] ? [UIImage imageNamed: @"radio-button-check"] : [UIImage imageNamed: @"radio-button-unselected"];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return SURVEY_OPTION_CELL_HEIGHT;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (IBAction)sendTapped:(id)sender {
}

@end
