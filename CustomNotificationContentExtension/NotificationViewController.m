//
//  NotificationViewController.m
//  CustomNotificationContentExtension
//
//  Created by Sanchit Mittal on 29/08/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import "NotificationViewController.h"
#import <UserNotifications/UserNotifications.h>
#import <UserNotificationsUI/UserNotificationsUI.h>
#import "TextNotification.h"

@import UserNotifications;
@import UserNotificationsUI;

@interface NotificationViewController () <UNNotificationContentExtension>
@end

@implementation NotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any required interface initialization here.
}

- (void)didReceiveNotification:(UNNotification *)notification {
    
//    self.label.text = notification.request.content.title;
//    self.label.text = notification.request.content.body;
    
    self.titleLabel.text = @"Welcome back to WeWork Promenade";
    self.detailLabel.text = @"We’re happy that you visited again and will be working in our space. For more information please visit Front desk or send us a message.";
    self.dateLabel.text = @"November 9, 9:25 AM";

}

@end
