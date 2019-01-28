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

-(void)registerForHailerWithAPIKey:(NSString *)apiKey;
-(void)registerForHailerWithAPIKey:(NSString *)apiKey andSuccessHandler:(nullable void (^)())successBlock andFailureHandler:(nullable void (^)(NSString *))failureBlock;
-(void)unregisterForHailer;


+(NSString *)deviceId;

+(void) setIngressURL:(NSString *)urlString;

+(void) didReceivePushNotificationPayload:(NSDictionary *)payload
                    withCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler;

+(void) setPushToken:(NSString *)pushToken;
+(NSString *) storedPushToken;

+(void) forceSensorUpdate;

+(void) requestAlwaysPermission;

+(void) setMotionActivityEnabled:(BOOL)enabled;
+(BOOL) motionActivityEnabled;

// Configs

+(void) registerForSensorUpdates:(id<SensorUpdateDelegate>)delegate;

#pragma mark - Core Data
+(void) saveCoreDataContext;

// Hailer Integration
+(void) uploadFileFromURL:(NSURL *)filePath andUploadProgressHandler:(nullable void (^)(NSProgress *uploadProgress))uploadProgressBlock andSuccessHandler:(void (^)())successBlock andFailureHandler:(void (^)(NSString *))failureBlock;
+(void) makehailerIncidentWithFilePath:(NSURL *)filePath andCustomer:(NSString *)customer andDescription:(NSString *)description andUploadProgressHandler:(nullable void (^)(NSProgress *uploadProgress))uploadProgressBlock andSuccessHandler:(void (^)())successBlock andFailureHandler:(void (^)(NSString *))failureBlock;

@end
