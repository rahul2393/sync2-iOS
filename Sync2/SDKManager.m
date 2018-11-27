//
//  SDKManager.m
//  Sync2
//
//  Created by Ricky Kirkendall on 6/14/17.
//  Copyright © 2017 Sixgill. All rights reserved.
//

#import "SDKManager.h"
#import "EnvironmentManager.h"
#import "SettingsManager.h"
#import "AppDelegate.h"
#import "SnackbarView.h"

#define KEY_API @"currentAPIKey"
#define Sensors_Data_Key @"sensorsDataKey"
#define sensorHistoryMax 2500

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
    NSData *sensorsData = [[NSUserDefaults standardUserDefaults] dataForKey:Sensors_Data_Key];
    NSArray *sensorsArray = [NSKeyedUnarchiver unarchiveObjectWithData:sensorsData];
     if (!sensorsArray) {
        sensorsArray = @[];
    }
    
    return sensorsArray;
}

- (void)setSensorsData:(Event *)event {
    
    NSData *sensorData = [[NSUserDefaults standardUserDefaults] dataForKey:Sensors_Data_Key];
    NSArray *sensorUpdateHistory = [NSKeyedUnarchiver unarchiveObjectWithData:sensorData];
    
    if (!sensorUpdateHistory) {
        sensorUpdateHistory = @[];
    }
    
    NSMutableArray *mutableUpdateHistory = [sensorUpdateHistory mutableCopy];
    [mutableUpdateHistory insertObject:event atIndex:0];
    
    if (mutableUpdateHistory.count > sensorHistoryMax) {
        [mutableUpdateHistory removeLastObject];
    }
    
    NSData *updatedSensorData = [NSKeyedArchiver archivedDataWithRootObject:mutableUpdateHistory];
    [[NSUserDefaults standardUserDefaults] setObject:updatedSensorData forKey:Sensors_Data_Key];
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

- (void)startSDKWithAPIKey:(NSString *)apiKey andSuccessHandler:(void (^)())successBlock andFailureHandler:(void (^)(NSString *))failureBlock{
    
    SGSDKConfigManager *config = [[SGSDKConfigManager alloc] init];
    
    config.ingressURL = [[EnvironmentManager sharedManager] selectedIngressURL];
    
    NSString *phoneNumber = [[NSUserDefaults standardUserDefaults] stringForKey:kPhoneNumber];
    if (phoneNumber) {
        NSMutableDictionary<NSString*, NSString*> *aliases = [[NSMutableDictionary alloc] init];
        [aliases setValue:phoneNumber forKey:@"phone_number"];
        config.aliases = aliases;
    }
    
    [[SGSDK sharedInstance] startWithAPIKey:apiKey andConfig:config andSuccessHandler:^{
//        SGAtlasProvider *atlasProvider = [[SGAtlasProvider alloc] initWithApiKey:@"660e9157-3c4c-41dd-872d-68c9729ba3bd" secretKey:@"yuy/dWyMTboHe4QUEMXEEKIh+KIXEzj5ArBOT7VlQPtSrAwq9EHCUVVy+VpKtsSPYakf9Llt+a/55oGqBbxc92j4RORGH9ewWqvv/SfAKWCl3i5fw32sWaBP0l24XQ=="];
        SGAtlasProvider *atlasProvider = [[SGAtlasProvider alloc] initWithApiKey:@"112762bb-6ee5-4807-8c61-c8f8939561f3" secretKey:@"sC0oXa+7R8CuckNCwXOZ481fsk2Y7IpPQPUmeakockKijfWHT23d8nl7s3VkHlWTnnqEbgPhUXka84nsEfnKk0dalm47NHaGuwgqDr0XgAe88z68nqLRIyn0Rs8+Wg=="];
        
        [[SGSDK sharedInstance] setProviderManager:atlasProvider];
        
//        SGPhunwareProvider *phunwareProvider = [[SGPhunwareProvider alloc] initWithApplicationId:@"2182" accessKey:@"ffdb2c886b2a02c35a139c61b71ab64ddb6eee67" signatureKey:@"056fe5ef873c5804e9f0676f9d5b58fa295d48e0" buildingId:81601];
//        [[SGSDK sharedInstance] setProviderManager:phunwareProvider];
        
        [SGSDK enableWithSuccessHandler:^{
            successBlock();
            [SGSDK setMotionActivityEnabled:YES];
            //            [SGSDK requestAlwaysPermission];
            
        } andFailureHandler:^(NSString *msg) {
            
        }];
        
    } andFailureHandler:^(NSString *msg) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            failureBlock(msg);
            
            [SnackbarView showSnackbar:@"Change API Configuration" actionText:@"GO TO LOGIN" actionHandler:^{
                [[SettingsManager sharedManager] logout];
                [[SDKManager sharedManager] stopSDK];
                AppDelegate *appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
                [appDel.window.rootViewController.presentedViewController dismissViewControllerAnimated:YES completion:nil];
            }];
            
        });
        
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
