//
//  NotificationService.m
//  CustomNotificationServiceExtension
//
//  Created by Sanchit Mittal on 29/08/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import "NotificationService.h"

@interface NotificationService ()

@property (nonatomic, strong) void (^contentHandler)(UNNotificationContent *contentToDeliver);
@property (nonatomic, strong) UNMutableNotificationContent *bestAttemptContent;
@property (nonatomic, strong) NSArray *notifications;
@end

@implementation NotificationService

- (void)didReceiveNotificationRequest:(UNNotificationRequest *)request withContentHandler:(void (^)(UNNotificationContent * _Nonnull))contentHandler {
    self.contentHandler = contentHandler;
    self.bestAttemptContent = [request.content mutableCopy];
    
    // Modify the notification content here...
    
    NSDictionary *data = self.bestAttemptContent.userInfo[@"data"];
    
    self.bestAttemptContent.categoryIdentifier = data[@"type"];
    self.bestAttemptContent.title = [NSString stringWithFormat:@"%@", data[@"title"]];
    
    self.contentHandler(self.bestAttemptContent);
}

- (void)serviceExtensionTimeWillExpire {
    // Called just before the extension will be terminated by the system.
    // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
    self.contentHandler(self.bestAttemptContent);
}

@end
