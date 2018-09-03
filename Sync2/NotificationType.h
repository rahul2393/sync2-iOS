//
//  NotificationType.h
//  Sync2
//
//  Created by Sanchit Mittal on 01/09/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#ifndef NotificationType_h
#define NotificationType_h


#endif /* NotificationType_h */

#import <Foundation/Foundation.h>

typedef enum {
    INFORMATION,
    ACTION_NOTIFICATION,
    FEEDBACK,
    SURVEY,
    SCHEDULE,
    EVENT
} kNotificationType;

#define kNotificationTypeArray @"information", @"action", @"feedback", @"survey", @"schedule", @"event", nil

@interface NotificationType : NSObject

-(kNotificationType) notificationTypeFor:(NSString*)str;

@end
