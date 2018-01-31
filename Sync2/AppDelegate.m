//
//  AppDelegate.m
//  Sync2
//
//  Created by Ricky Kirkendall on 5/24/17.
//  Copyright © 2017 Sixgill. All rights reserved.
//

#import "AppDelegate.h"
#import "SDKManager.h"
#import "SettingsManager.h"
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>
#import "SenseAPI.h"
#import "Landmark.h"
@import SixgillSDK;
@interface AppDelegate ()

@end

@implementation AppDelegate

-(void) networkTests{
    
    
    // Login
    
    [[SenseAPI sharedManager] LoginWithEmail:@"rkirkendall@sixgill.com" andPassword:@"rickyricky1" withCompletion:^(NSError * _Nullable error) {
        [[SenseAPI sharedManager] GetProjectsWithCompletion:^(NSArray *projects, NSError * _Nullable error) {
            NSLog(@"Found projects: ");
            for (Project *p in projects) {
                NSLog(@"%@",p.name);
                [[SenseAPI sharedManager] GetLandmarksForProject:p.objectId WithCompletion:^(NSArray *landmarks, NSError * _Nullable error) {
                    NSLog(@"-- Project has landmarks: ");
                    for (Landmark *lm in landmarks) {
                        
                        NSLog(@"--- %@", lm.name);
                    }
                }];
            }
        }];
        
        [[SenseAPI sharedManager] GetDataChannelsWithCompletion:^(NSArray *channels, NSError * _Nullable error) {
            NSLog(@"Found channels: ");
            for (Project *p in channels) {
                NSLog(@"%@",p.name);
            }
        }];
        
    }];
    
    
    
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [Fabric with:@[[Crashlytics class]]];

    
    [[UIApplication sharedApplication] registerForRemoteNotifications];
    
    [[SDKManager sharedManager] startSDKWithAPIKey:@""];
    NSLog(@"SDK starting");
    
    
    [self networkTests];
    
    return YES;
}

-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    
    const unsigned *tokenBytes = [deviceToken bytes];
    NSString *hexToken = [NSString stringWithFormat:@"%08x%08x%08x%08x%08x%08x%08x%08x",
                          ntohl(tokenBytes[0]), ntohl(tokenBytes[1]), ntohl(tokenBytes[2]),
                          ntohl(tokenBytes[3]), ntohl(tokenBytes[4]), ntohl(tokenBytes[5]),
                          ntohl(tokenBytes[6]), ntohl(tokenBytes[7])];
    NSLog(@"%@",hexToken);
    [SGSDK setPushToken:hexToken];
    
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
    
    [SGSDK didReceivePushNotificationPayload:userInfo withCompletionHandler:completionHandler];
    
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    
    // All instances of TestClass will be notified
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"PushPermissionChanged"
     object:self];
}

-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"PushPermissionChanged"
     object:self];
}




@end
