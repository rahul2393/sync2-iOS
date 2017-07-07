//
//  SDKManager.m
//  Sync2
//
//  Created by Ricky Kirkendall on 6/14/17.
//  Copyright © 2017 Sixgill. All rights reserved.
//

#import "SDKManager.h"

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

-(void)forceUpdate{
    [SGSDK forceSensorUpdate];
}

-(void)requestAlwaysLocationPermission{
   [SGSDK requestAlwaysLocationPermission];
}

-(void) startSDKWithAPIKey:(NSString *)apiKey{
    [SGSDK initWithAPIKey:apiKey];
    [SGSDK setMotionActivityEnabled:YES];
}

-(void) clearLogs{
    [SGSDK clearLogs];
}

-(NSString *) logs{
    return [SGSDK logs];
}

-(void) stopSDK{
    [SGSDK stop];
}

-(void) setSensorDataDelegate:(id<SensorUpdateDelegate>)delegate{
    [SGSDK registerForSensorUpdates:delegate];
}

@end
