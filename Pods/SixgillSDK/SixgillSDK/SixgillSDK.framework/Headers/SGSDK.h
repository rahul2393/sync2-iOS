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

#import "SGProviderManager.h"
#import "SGAtlasProvider.h"
#import "SGAtlasDelegate.h"
/**
 `SGSDK` is the wrapper class that exists for the purpose of abstracting away implemenation details and providing a clean API to the user.
 **/

@interface SGSDK : NSObject

@property(nonatomic, readwrite) SGSDKConfigManager *config;

@property(nonatomic, readwrite) SGProviderManager *providerManager;

+(instancetype)sharedInstance;

+(void) requestAlwaysPermission;

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

+(void) setMotionActivityEnabled:(BOOL)enabled;
+(BOOL) motionActivityEnabled;

+(void) didReceivePushNotificationPayload:(NSDictionary *)payload
                    withCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler;

+(void) setPushToken:(NSString *)pushToken;
+(NSString *) storedPushToken;

+(void) setIngressURL:(NSString *)urlString;

+(void) registerForSensorUpdates:(id<SensorUpdateDelegate>)delegate;

+(void) forceSensorUpdate;

+(void) getLocationWithSuccessHandler:(nullable void (^)(Location *))successBlock andFailureHandler:(nullable void (^)(Error *))failureBlock;

+(void)getRulesOfType:(NSString *)type andSuccessHandler:(nullable void (^)(NSMutableArray<SGRule*> *))successBlock andFailureHandler:(nullable void (^)(NSString *))failureBlock;

+(void) showNotificationsFromOffset:(NSInteger *)offset andLimit:(NSInteger *)limit andSuccessHandler:(void (^)(NSArray<Notification*> *))successBlock andFailureHandler:(void (^)(NSString *))failureBlock;

#pragma mark - Core Data
+(void) saveCoreDataContext;

// Hailer Integration
+(void) uploadFilesFromURLs:(NSMutableArray<NSURL *> *)filePaths andUploadProgressHandlers:(NSMutableArray<void (^)(NSProgress *uploadProgress)>*)uploadProgressBlocks andSuccessHandler:(void (^)(NSMutableArray<UploadFiles *>* _Nullable uploadedFiles))successBlock andFailureHandler:(void (^)(NSString *))failureBlock;
+(void) makehailerIncidentWithFilePaths:(NSMutableArray<NSURL *> *)filePaths andCustomer:(NSString *)customer andDescription:(NSString *)description andUploadProgressHandlers:(NSMutableArray<void (^)(NSProgress *uploadProgress)>*)uploadProgressBlocks andSuccessHandler:(void (^)())successBlock andFailureHandler:(void (^)(NSString *))failureBlock;

@end
