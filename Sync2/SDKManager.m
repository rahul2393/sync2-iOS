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
   [SGSDK requestAlwaysPermission];
}

-(void) startSDKWithAPIKey:(NSString *)apiKey{
    [SGSDK initWithAPIKey:@"mCYx0s5rN00o+xNRcALiO3Qe"];
    [SGSDK enable];
    [SGSDK setMotionActivityEnabled:YES];
//    [SGSDK requestAlwaysPermission];
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
