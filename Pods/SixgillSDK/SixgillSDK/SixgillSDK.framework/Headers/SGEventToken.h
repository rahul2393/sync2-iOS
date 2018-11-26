//
//  SGTriggerEvent.h
//  SixgillSDK
//
//  Created by Ricky Kirkendall on 12/18/16.
//  Copyright © 2016 Sixgill. All rights reserved.
//

#import <Foundation/Foundation.h>

#define INCOMPLETE_TOKEN @"incomplete-token"

@class SGPushEvent;

@interface SGEventToken : NSObject

@property (nonatomic, strong) NSDate *timestamp;

@property (nonatomic, strong) SGPushEvent *pushEventInstance;

@property (copy, nonatomic) void (^backgroundFetchHandler)(UIBackgroundFetchResult result);

-(NSString *) token;

-(BOOL) matchesExactly:(SGEventToken *)token;

-(BOOL) tokenMatchesEventId:(NSString *)tokenString;

@end
