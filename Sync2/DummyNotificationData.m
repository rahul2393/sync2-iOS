//
//  DummyNotificationData.m
//  Sync2
//
//  Created by Ricky Kirkendall on 1/23/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import "DummyNotificationData.h"
#import "TextNotification.h"
@implementation DummyNotificationData

+(NSArray *) notifications{
    
    TextNotification *tn = [[TextNotification alloc] init];
    [tn setTitle:@"Welcome to WeWork Promenade"];
    [tn setBody:@"We're happy to have you. Please let us know if there is anything we can do to help create a conducive work environment."];
    [tn setDate:[NSDate date]];
    
    return @[tn];
}

@end
