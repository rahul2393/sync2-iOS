//
//  SGSDK.h
//  SixgillSDK
//
//  Created by Ricky Kirkendall on 11/30/16.
//  Copyright © 2016 Sixgill. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SensorUpdateDelegate.h"
#import "SGMSQueuePolicy.h"
/**
 `SGSDK` is the wrapper class that exists for the purpose of abstracting away implemenation details and providing a clean API to the user.
 **/

@interface SGSDK : NSObject

+(void) initWithAPIKey:(NSString *)apiKey;

// Configs

+(void) setBluetoothCollectionSpan:(NSInteger)collectionSpan;
+(void) setLocationCollectionSpan:(NSInteger)collectionSpan;
+(void) setLocationCollectionCachePolicy:(SGMSQueuePolicy)locationCachePolicy;


// Last 2 Days
+(NSString *) logs;
+(void) clearLogs;

+(void) registerForSensorUpdates:(id<SensorUpdateDelegate>)delegate;

+(NSArray *) sensorUpdateHistory:(NSUInteger)capacity;

// Add get high acc. location shot here

+(void) requestAlwaysLocationPermission;

+(void) requestInAppLocationPermission;


+(void) didReceivePushNotificationPayload:(NSDictionary *)payload
                    withCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler;

+(void) setPushToken:(NSString *)pushToken;
+(NSString *) storedPushToken;

+(void) setMotionActivityEnabled:(BOOL)enabled;

+(NSString *)GUID;
+(UIViewController *) inboxViewController;

+(void) forceSensorUpdate;

+(void) stop;


@end
