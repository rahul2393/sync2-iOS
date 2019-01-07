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
#import "SGSDKConfigManager.h"
#import "SGRule.h"
/**
 `SGSDK` is the wrapper class that exists for the purpose of abstracting away implemenation details and providing a clean API to the user.
 **/

@interface SGSDK : NSObject

@property(nonatomic, readwrite) SGSDKConfigManager *config;

+(instancetype)sharedInstance;

-(void)startWithAPIKey:(NSString *)apiKey;
-(void)startWithAPIKey:(NSString *)apiKey andConfig:(SGSDKConfigManager *)config;
-(void)startWithAPIKey:(NSString *)apiKey andConfig:(SGSDKConfigManager *)config andSuccessHandler:(nullable void (^)())successBlock andFailureHandler:(nullable void (^)(NSString *))failureBlock;

+(void) enable;
+(void) enableWithSuccessHandler: (void (^)())successBlock andFailureHandler:(void (^)(NSString *))failureBlock;

+(void) disable;

+(NSString *)deviceId;

+(void) setIngressURL:(NSString *)urlString;

+(void) didReceivePushNotificationPayload:(NSDictionary *)payload
                    withCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler;

+(void) setPushToken:(NSString *)pushToken;
+(NSString *) storedPushToken;

+(void) showNotificationsFromOffset:(NSNumber *)offset andLimit:(NSNumber *)limit andSuccessHandler:(void (^)(NSArray<Notification*> *))successBlock andFailureHandler:(void (^)(NSString *))failureBlock;

+(void) forceSensorUpdate;

+(void) requestAlwaysPermission;

+(void) setMotionActivityEnabled:(BOOL)enabled;
+(BOOL) motionActivityEnabled;

// Configs

+(void) registerForSensorUpdates:(id<SensorUpdateDelegate>)delegate;

#pragma mark - Core Data
+(void) saveCoreDataContext;

+(void)getRulesOfType:(NSString *)type andSuccessHandler:(nullable void (^)(NSMutableArray<SGRule*> *))successBlock andFailureHandler:(nullable void (^)(NSString *))failureBlock;

@end
