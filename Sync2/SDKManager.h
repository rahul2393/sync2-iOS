//
//  SDKManager.h
//  Sync2
//
//  Created by Ricky Kirkendall on 6/14/17.
//  Copyright © 2017 Sixgill. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SixgillSDK/SixgillSDK.h>
#import <Crashlytics/Crashlytics.h>

#define kPhoneNumber @"kPhoneNumber"

@interface SDKManager : NSObject<SGLogDelegateProtocol>

+ (id)sharedManager;


- (NSString *) currentAPIKey;
- (void) setCurrentAPIKey:(NSString *) apiKey;

-(void) startSDKWithAPIKey:(NSString *)apiKey andSuccessHandler:(nullable void (^)())successBlock andFailureHandler:(nullable void (^)(NSString *))failureBlock;;
-(void) stopSDK;

-(void) setSensorDataDelegate:(id<SensorUpdateDelegate>)delegate;

-(NSString *) logs;
-(void) clearLogs;

-(void)SGReachLog:(NSString *)logMsg;

-(void)forceUpdate;

-(void)requestAlwaysLocationPermission;

-(void) setIngressUrl:(NSString *)ingressUrl;

- (NSArray *) sensorsData;
- (void) setSensorsData:(Event *)event;
- (void) clearSensorsData;


@end
