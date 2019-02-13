//
//  NotificationsViewController.m
//  Sync2
//
//  Created by Ricky Kirkendall on 1/15/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import "NotificationsViewController.h"
#import "SettingsManager.h"
#import "NotificationType.h"

#import "DefaultNotificationTableViewCell.h"
#import "WelcomeNotificationTableViewCell.h"
#import "JoiningNotificationTableViewCell.h"
#import "FeedbackNotificationTableViewCell.h"
#import "SurveyNotificationTableViewCell.h"
#import "ScheduleNotificationTableViewCell.h"
#import "VisitNotificationTableViewCell.h"

@import UserNotifications;
@import SixgillSDK;

@interface NotificationsViewController ()

@property (nonatomic, strong) NSArray<Notification *> *notifications;
@end

@implementation NotificationsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 200;
    
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
    
    [self loadNotifications];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadNotifications) name:@"PushReceived" object:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.notifications.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Notification *n = self.notifications[indexPath.section];
    if ([n.type isEqualToString:@""]) {
        DefaultNotificationTableViewCell *cell = (DefaultNotificationTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"DefaultNotificationTableViewCellIdentifier" forIndexPath:indexPath];
        Notification *n = self.notifications[indexPath.section];
        [cell configureCell:n];
        
        return cell;
    } else {
        kNotificationType notificationType = [[[NotificationType alloc] init] notificationTypeFor:n.type];
        switch (notificationType) {
            case PUSH: {
                DefaultNotificationTableViewCell *cell = (DefaultNotificationTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"DefaultNotificationTableViewCellIdentifier" forIndexPath:indexPath];
                Notification *n = self.notifications[indexPath.section];
                [cell configureCell:n];
                
                return cell;
            }
            case INFORMATION: {
                WelcomeNotificationTableViewCell *cell = (WelcomeNotificationTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"WelcomeNotificationTableViewCellIdentifier" forIndexPath:indexPath];
                [cell configureCell:n];

                return cell;
            }
            case ACTION_NOTIFICATION: {
                JoiningNotificationTableViewCell *cell = (JoiningNotificationTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"JoiningNotificationTableViewCellIdentifier" forIndexPath:indexPath];
                [cell configureCell:n];

                return cell;
            }
            case FEEDBACK: {
                FeedbackNotificationTableViewCell *cell = (FeedbackNotificationTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"FeedbackNotificationTableViewCellIdentifier" forIndexPath:indexPath];
                [cell configureCell:n];

                return cell;
            }
            case SURVEY: {
                SurveyNotificationTableViewCell *cell = (SurveyNotificationTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"SurveyNotificationTableViewCellIdentifier" forIndexPath:indexPath];
                [cell configureCell:n];

                return cell;
            }
            case SCHEDULE: {
                ScheduleNotificationTableViewCell *cell = (ScheduleNotificationTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"ScheduleNotificationTableViewCellIdentifier" forIndexPath:indexPath];
                [cell configureCell:n];

                return cell;
            }
            case EVENT: {
                VisitNotificationTableViewCell *cell = (VisitNotificationTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"VisitNotificationTableViewCellIdentifier" forIndexPath:indexPath];
                [cell configureCell:n];

                return cell;
            }
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
                    if (self.notifications.count == 0) {
                        self.noNotificationsView.hidden = false;
                        self.tableView.hidden = true;
                        self.permissionMissingView.hidden = true;
                    } else {
                        self.tableView.hidden = false;
                        self.noNotificationsView.hidden = true;
                        self.permissionMissingView.hidden = true;
                    }
                    break;
                default:
                    break;
            }
        });
    }];
}

- (void) loadNotifications {
    [SGSDK showNotificationsFromOffset:0 andLimit:20 andSuccessHandler:^(NSArray<Notification *> *notifications) {
        if (notifications.count == 0) {
            self.tableView.hidden = true;
            self.noNotificationsView.hidden = false;
        } else {
            self.tableView.hidden = false;
            self.noNotificationsView.hidden = true;
        }
        
        self.notifications = notifications;
        [self.tableView reloadData];
        
    } andFailureHandler:^(NSString *failureMsg) {
        
    }];
}


@end
