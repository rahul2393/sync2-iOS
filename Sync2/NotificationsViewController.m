//
//  NotificationsViewController.m
//  Sync2
//
//  Created by Ricky Kirkendall on 1/15/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import "NotificationsViewController.h"
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

@import UserNotifications;

@interface NotificationsViewController ()

@property (nonatomic, readwrite) BOOL useDummyData;
@property (nonatomic, strong) NSArray *notifications;
@property (nonatomic, readwrite) NSInteger SURVEY_OPTION_CELL_HEIGHT;

@end

#define SURVEY_OPTION_CELL_HEIGHT 38

@implementation NotificationsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 200;
    
    self.useDummyData = YES;
    
    [self permissionChanged];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(permissionChanged)
                                                 name:@"PushPermissionChanged"
                                               object:nil];
    
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes: UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound categories:nil];
    
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
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

            return cell;
        }
        case 1: {
            JoiningNotificationTableViewCell *cell = (JoiningNotificationTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"JoiningNotificationTableViewCellIdentifier" forIndexPath:indexPath];
            
            return cell;
        }
        case 2: {
            FeedbackNotificationTableViewCell *cell = (FeedbackNotificationTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"FeedbackNotificationTableViewCellIdentifier" forIndexPath:indexPath];
            cell.feedbackTextView.placeholder = @"e.g. Needs another whiteboard";
            
            return cell;
        }
        case 3: {
            SurveyNotificationTableViewCell *cell = (SurveyNotificationTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"SurveyNotificationTableViewCellIdentifier" forIndexPath:indexPath];
            NSArray *data = @[@"Black Coffee", @"Coldbrew Coffee", @"Espresso Coffee", @"Latte"];
            cell.data = data;
            cell.tableViewHeightConstraint.constant = data.count * SURVEY_OPTION_CELL_HEIGHT;
            cell.tableView.backgroundColor = [UIColor redColor];
            [cell.tableView reloadData];
            
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

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView* footer = [[UIView alloc] init];
    footer.backgroundColor = [UIColor clearColor];
    return footer;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (IBAction)openDeviceSettings:(id)sender {
    NSURL* settingsURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    [[UIApplication sharedApplication] openURL:settingsURL];
}

#pragma mark - Permission View


- (void)permissionChanged {
    
    [[UNUserNotificationCenter currentNotificationCenter] getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
        dispatch_async(dispatch_get_main_queue(),^{
            switch ([settings authorizationStatus]) {
                case UNAuthorizationStatusNotDetermined:
                case UNAuthorizationStatusDenied:
                    self.permissionMissingView.hidden = false;
                    self.tableView.hidden = true;
                    self.noNotificationsView.hidden = true;
                    break;
                case UNAuthorizationStatusAuthorized:
                    self.tableView.hidden = false;
                    self.noNotificationsView.hidden = true;
                    self.permissionMissingView.hidden = true;
//                    if ([[SettingsManager sharedManager] savedRemoteNotificationPayloads].count == 0) {
//                        self.noNotificationsView.hidden = false;
//                        self.tableView.hidden = true;
//                        self.permissionMissingView.hidden = true;
//                    } else {
//                        self.tableView.hidden = false;
//                        self.noNotificationsView.hidden = true;
//                        self.permissionMissingView.hidden = true;
//                    }
                    break;
                default:
                    break;
            }
        });
    }];
}


@end
