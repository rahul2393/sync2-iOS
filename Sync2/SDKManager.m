//
//  SDKManager.m
//  Sync2
//
//  Created by Ricky Kirkendall on 6/14/17.
//  Copyright © 2017 Sixgill. All rights reserved.
//

#import "SDKManager.h"

#define KEY_API @"currentAPIKey"
#define Sensors_Data_Key @"sensorsDataKey"

@implementation SDKManager


+ (id)sharedManager {
    static SDKManager *sharedMyManager = nil;
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

- (NSString *) currentAPIKey{
    return [[NSUserDefaults standardUserDefaults] objectForKey:KEY_API];
}

- (void) setCurrentAPIKey:(NSString *) apiKey{
    [[NSUserDefaults standardUserDefaults] setObject:apiKey forKey:KEY_API];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSArray *)sensorsData {
    NSArray *sensorsData = [[NSUserDefaults standardUserDefaults] arrayForKey:Sensors_Data_Key];
    if (!sensorsData) {
        sensorsData = @[];
    }
    return sensorsData;
}

- (void)setSensorsData:(NSMutableDictionary *)event {
    
    NSArray *sensorUpdateHistory = [[NSUserDefaults standardUserDefaults] arrayForKey:Sensors_Data_Key];
    if (!sensorUpdateHistory) {
        sensorUpdateHistory = @[];
    }
    
    NSMutableArray *mutableUpdateHistory = [sensorUpdateHistory mutableCopy];
    [mutableUpdateHistory insertObject:event atIndex:0];
    
    [[NSUserDefaults standardUserDefaults] setObject:mutableUpdateHistory forKey:Sensors_Data_Key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

- (void)clearSensorsData {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:Sensors_Data_Key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void) setIngressUrl:(NSString *)ingressUrl{
    if (!ingressUrl) {
        return;
    }
    
    [SGSDK setIngressURL:ingressUrl];
}

-(void)forceUpdate{
    [SGSDK forceSensorUpdate];
}

-(void)requestAlwaysLocationPermission{
   [SGSDK requestAlwaysPermission];
}

-(void) startSDKWithAPIKey:(NSString *)apiKey{
    [SGSDK initWithAPIKey:apiKey onSuccessHandler:^{
        
        
    } onFailureHandler:^(NSString *msg) {
    }];
  
    [SGSDK enable:^{
        [SGSDK setMotionActivityEnabled:YES];
//        [SGSDK requestAlwaysPermission];
    } onFailureHandler:^(NSString *msg) {
    }];
}

-(void)SGReachLog:(NSString *)logMsg{
    CLSLog(@"%@",logMsg);
}

-(void) clearLogs{
    [SGSDK clearLogs];
}

-(NSString *) logs{
    return [SGSDK logs];
}

-(void) stopSDK{
    [SGSDK disable];
}

-(void) setSensorDataDelegate:(id<SensorUpdateDelegate>)delegate{
    [SGSDK registerForSensorUpdates:delegate];
}

@end
