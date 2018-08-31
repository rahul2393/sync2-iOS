//
//  NotificationViewController.m
//  ScheduleNotificationContentExtension
//
//  Created by Sanchit Mittal on 30/08/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import "NotificationViewController.h"
#import <UserNotifications/UserNotifications.h>
#import <UserNotificationsUI/UserNotificationsUI.h>

@interface NotificationViewController () <UNNotificationContentExtension>
@end

@implementation NotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any required interface initialization here.
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
}

@end
