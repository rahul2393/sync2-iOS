//
//  NotificationsTableViewController.m
//  Sync2
//
//  Created by Ricky Kirkendall on 1/15/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import "NotificationsTableViewController.h"
#import "DummyNotificationData.h"
#import "TextViewTableViewCell.h"
#import "TextNotification.h"
#import "SettingsManager.h"

#import "WelcomeNotificationTableViewCell.h"
#import "JoiningNotificationTableViewCell.h"
#import "FeedbackNotificationTableViewCell.h"
#import "SurveyNotificationTableViewCell.h"
#import "ScheduleNotificationTableViewCell.h"
#import "VisitNotificationTableViewCell.h"

@interface NotificationsTableViewController ()

@property (nonatomic, readwrite) BOOL useDummyData;
@property (nonatomic, strong) NSArray *notifications;

@end

@implementation NotificationsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 200;
//    [self.tableView setContentInset:UIEdgeInsetsMake(10, 10, 0, 0)];
    self.useDummyData = YES;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (self.useDummyData) {
        self.notifications = [DummyNotificationData notifications];
    } else {
        [self update];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(update)
                                                 name:@"PushReceived"
                                               object:nil];
    
}

-(void) update{
    self.notifications = [[SettingsManager sharedManager] savedRemoteNotificationPayloads];
    [self.tableView reloadData];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0: {
            WelcomeNotificationTableViewCell *cell = (WelcomeNotificationTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"WelcomeNotificationTableViewCellIdentifier" forIndexPath:indexPath];
            TextNotification *tn = (TextNotification *) self.notifications[0];
            cell.titleLabel.text = tn.title;
            cell.detailLabel.text = tn.body;
            cell.dateLabel.text = [tn displayableDate];

            // Configure the cell...

            return cell;
        }
        case 1: {
            JoiningNotificationTableViewCell *cell = (JoiningNotificationTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"JoiningNotificationTableViewCellIdentifier" forIndexPath:indexPath];
            return cell;
        }
        case 2: {
            FeedbackNotificationTableViewCell *cell = (FeedbackNotificationTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"FeedbackNotificationTableViewCellIdentifier" forIndexPath:indexPath];
            return cell;
        }
        case 3: {
            SurveyNotificationTableViewCell *cell = (SurveyNotificationTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"SurveyNotificationTableViewCellIdentifier" forIndexPath:indexPath];
            return cell;
        }
        case 4: {
            ScheduleNotificationTableViewCell *cell = (ScheduleNotificationTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"ScheduleNotificationTableViewCellIdentifier" forIndexPath:indexPath];
            return cell;
        }
        case 5: {
            VisitNotificationTableViewCell *cell = (VisitNotificationTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"VisitNotificationTableViewCellIdentifier" forIndexPath:indexPath];
            return cell;
        }
        default: {
            return [[UITableViewCell alloc] init];
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView* footer = [[UIView alloc] init];
    footer.backgroundColor = [UIColor clearColor];
    return footer;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

@end
