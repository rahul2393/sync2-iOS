//
//  NotificationManager.m
//  Sync2
//
//  Created by Ricky Kirkendall on 2/1/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import "NotificationManager.h"

#define kTitle @"title"
#define kBody @"body"
#define kDate @"date"
#define kMessages @"key_messages"

@implementation NotificationManager

+ (id)sharedManager {
    static NotificationManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init]) {
    }
    return self;
}

-(void) saveMessageWithTitle:(NSString *)title andBody:(NSString *)body{
    NSDictionary *d = @{kTitle: title,
                        kBody: body,
                        kDate: [NSDate date]
                        };
    
    NSArray *messages = [[NSUserDefaults standardUserDefaults] objectForKey:kMessages];
    if (!messages) {
        messages = @[];
    }
    
    NSMutableArray *array = [NSMutableArray arrayWithArray:messages];
    [array insertObject:d atIndex:0];
    
    if (array.count > 50) {
        [array removeLastObject];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:array forKey:kMessages];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

-(NSArray *) messages{
    
    return [[NSUserDefaults standardUserDefaults] objectForKey:kMessages];
    
}
@end
