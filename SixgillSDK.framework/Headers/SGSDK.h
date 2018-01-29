//
//  SGSDK.h
//  SixgillSDK
//
//  Created by Ricky Kirkendall on 11/30/16.
//  Copyright © 2016 Sixgill. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SensorUpdateDelegate.h"
#import "SGLogDelegate.h"
#import "EventQueuePolicy.h"
/**
 `SGSDK` is the wrapper class that exists for the purpose of abstracting away implemenation details and providing a clean API to the user.
 **/

@interface SGSDK : NSObject

+(void) initWithAPIKey:(NSString *)apiKey;

+(void) enable;
+(void) disable;

+(NSString *)deviceId;

// Last 2 Days worth of logs
+(NSString *) logs;
+(void) clearLogs;

+(void) didReceivePushNotificationPayload:(NSDictionary *)payload
                    withCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler;

+(void) setPushToken:(NSString *)pushToken;
+(NSString *) storedPushToken;

+(void) forceSensorUpdate;

+(void) requestAlwaysPermission;

+(void) setMotionActivityEnabled:(BOOL)enabled;
+(BOOL) motionActivityEnabled;


// deprecated

+(void) showTestLocalNotification;

// Configs

+(void) setBluetoothCollectionSpan:(NSInteger)collectionSpan;
+(void) setLocationCollectionSpan:(NSInteger)collectionSpan;
+(void) setLocationCollectionCachePolicy:(EventQueuePolicy)locationCachePolicy;



+(void) registerForLogUpdates:(id<SGLogDelegateProtocol>)delegate;

+(void) registerForSensorUpdates:(id<SensorUpdateDelegate>)delegate;

+(NSArray *) sensorUpdateHistory:(NSUInteger)capacity;


+(UIViewController *) inboxViewController;

@end
