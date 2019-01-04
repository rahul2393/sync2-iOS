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

#import "WelcomeNotificationTableViewCell.h"
#import "JoiningNotificationTableViewCell.h"
#import "FeedbackNotificationTableViewCell.h"
#import "SurveyNotificationTableViewCell.h"
#import "ScheduleNotificationTableViewCell.h"
#import "VisitNotificationTableViewCell.h"

#import "InformationNotification.h"
#import "ActionNotification.h"
#import "FeedbackNotification.h"
#import "SurveyNotification.h"
#import "ScheduleNotification.h"
#import "EventNotification.h"

@import UserNotifications;
@import SixgillSDK;

@interface NotificationsViewController ()

@property (nonatomic, strong) NSArray *notifications;
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
    
    [SGSDK showNotificationsFromOffset:[NSNumber numberWithInt:0] andLimit:[NSNumber numberWithInt:20] andSuccessHandler:^(NSArray<Notification *> *notifications) {
        
    } andFailureHandler:^(NSString *failureMsg) {
        
    }];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self update];
    
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
    return self.notifications.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BaseNotification *basenotification = (BaseNotification *) self.notifications[indexPath.section];
    
    kNotificationType notificationType = [[[NotificationType alloc] init] notificationTypeFor:basenotification.type];

    switch (notificationType) {
        case INFORMATION: {
            WelcomeNotificationTableViewCell *cell = (WelcomeNotificationTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"WelcomeNotificationTableViewCellIdentifier" forIndexPath:indexPath];
            
            InformationNotification *info = (InformationNotification*) self.notifications[indexPath.section];
            [cell configureCell:info];
            
            return cell;
        }
        case ACTION_NOTIFICATION: {
            JoiningNotificationTableViewCell *cell = (JoiningNotificationTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"JoiningNotificationTableViewCellIdentifier" forIndexPath:indexPath];
            
            ActionNotification *an = (ActionNotification*) self.notifications[indexPath.section];
            [cell configureCell:an];
            
            return cell;
        }
        case FEEDBACK: {
            FeedbackNotificationTableViewCell *cell = (FeedbackNotificationTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"FeedbackNotificationTableViewCellIdentifier" forIndexPath:indexPath];
            FeedbackNotification *fn = (FeedbackNotification *) self.notifications[indexPath.section];
            [cell configureCell:fn];
            
            return cell;
        }
        case SURVEY: {
            SurveyNotificationTableViewCell *cell = (SurveyNotificationTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"SurveyNotificationTableViewCellIdentifier" forIndexPath:indexPath];
            SurveyNotification *sn = (SurveyNotification *) self.notifications[indexPath.section];
            [cell configureCell:sn];
            
            return cell;
        }
        case SCHEDULE: {
            ScheduleNotificationTableViewCell *cell = (ScheduleNotificationTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"ScheduleNotificationTableViewCellIdentifier" forIndexPath:indexPath];
            ScheduleNotification *sn = (ScheduleNotification *) self.notifications[indexPath.section];
            [cell configureCell:sn];
            
            return cell;
        }
        case EVENT: {
            VisitNotificationTableViewCell *cell = (VisitNotificationTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"VisitNotificationTableViewCellIdentifier" forIndexPath:indexPath];
            EventNotification *en = (EventNotification *) self.notifications[indexPath.section];
            [cell configureCell:en];
            
            return cell;
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
                    if ([[SettingsManager sharedManager] savedRemoteNotificationPayloads].count == 0) {
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


@end
