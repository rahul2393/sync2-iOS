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
#import "SGIoTDevice.h"
/**
 `SGSDK` is the wrapper class that exists for the purpose of abstracting away implemenation details and providing a clean API to the user.
 **/

@interface SGSDK : NSObject

+(void) initWithAPIKey:(NSString *)apiKey;
+(void) initWithAPIKey:(NSString *)apiKey onSuccessHandler:(void (^)())onSuccessBlock onFailureHandler:(void (^)(NSString *))onFailureBlock;

+(void) enable;
+(void) enable:(void (^)())onSuccessBlock onFailureHandler:(void (^)(NSString *))onFailureBlock;
+(void) disable;

+(NSString *)deviceId;

+(void) setIngressURL:(NSString *)urlString;

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

#pragma mark - IoT
+(SGIoTDevice *) registerIoTDevice:(NSString *)deviceName
                  andChannelAPIKey:(NSString *)channelAPIKey
                           sensors:(NSArray *)sensors;

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


#pragma mark - IoT
+(NSArray *) registeredIoTDevices;
+(void) registerIoTDeviceName:(NSString *)deviceName;
+(void) sendIoTDevice:(SGIoTDevice *)device data:(NSDictionary *)data;


@end
