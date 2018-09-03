//
//  NotificationType.m
//  Sync2
//
//  Created by Sanchit Mittal on 01/09/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import "NotificationType.h"

@implementation NotificationType

-(kNotificationType) notificationTypeFor:(NSString*)str {
    NSArray *notificationTypeArray = [[NSArray alloc] initWithObjects:kNotificationTypeArray];
    NSUInteger n = [notificationTypeArray indexOfObject:str];
    
    return (kNotificationType) n;
}

@end
