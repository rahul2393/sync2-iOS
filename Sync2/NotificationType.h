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
    PUSH,
    INFORMATION,
    ACTION_NOTIFICATION,
    FEEDBACK,
    SURVEY,
    SCHEDULE,
    LOCATION
} kNotificationType;

#define kNotificationTypeArray @"push", @"push-information", @"push-action", @"push-feedback", @"push-survey", @"push-schedule", @"push-location", nil

@interface NotificationType : NSObject

-(kNotificationType) notificationTypeFor:(NSString*)str;

@end
