//
//  NotificationViewController.m
//  ScheduleNotificationContentExtension
//
//  Created by Sanchit Mittal on 29/08/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import "NotificationViewController.h"
#import <UserNotifications/UserNotifications.h>
#import <UserNotificationsUI/UserNotificationsUI.h>
#import "UIViewExtension.h"

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
    self.detailLabel.text = data[@"actionTitle"];
    
    NSArray *actions = data[@"actions"];
    
    [actions enumerateObjectsUsingBlock:^(id action, NSUInteger idx, BOOL *stop) {
        
        UIButton * btn = [self.actionButtons objectAtIndex:idx] ;
        [btn setTitle:action[@"text"] forState:UIControlStateNormal];
        
        if ([action[@"type"]  isEqual: @"secondary"]) {
            
            [btn setTitleColor:[UIColor colorWithRed:1.0 green:0.11 blue:0.15 alpha:1] forState:UIControlStateNormal];
            btn.backgroundColor = [UIColor clearColor];
            btn.borderColor = [UIColor colorWithRed:1.0 green:0.11 blue:0.15 alpha:1];
            
        } else if ([action[@"type"]  isEqual: @"primary"]) {
            
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btn.backgroundColor = [UIColor colorWithRed:0 green:0.32 blue:0.78 alpha:1];
            btn.borderColor = [UIColor colorWithRed:0 green:0.32 blue:0.78 alpha:1];
            
        }
    }];

    NSDate *date = [NSDate dateWithTimeIntervalSince1970:([data[@"timestamp"] doubleValue] / 1000.0)];
    NSDateFormatter *dateLabelFormatter = [[NSDateFormatter alloc] init];
    [dateLabelFormatter setDateFormat:@"MMMM dd, h:mm a"];
    self.dateLabel.text = [NSString stringWithFormat:@"%@", [dateLabelFormatter  stringFromDate:date]];
}

@end
