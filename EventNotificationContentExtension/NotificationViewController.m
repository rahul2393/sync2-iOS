//
//  NotificationViewController.m
//  EventNotificationContentExtension
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
    self.mapview.delegate = self;
    // Do any required interface initialization here.
}

- (void)didReceiveNotification:(UNNotification *)notification {
}

@end
