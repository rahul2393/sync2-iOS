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
#import "SenseAPI.h"
#import "SettingsManager.h"
#import "SDKManager.h"
#import "WelcomeViewController.h"
#import "MasterTabViewController.h"

#define kMapsAPIKey @"AIzaSyB1cmT9dsqS4RophYmCuapFc1LzUk5tpA4"

@import SixgillSDK;
@import GoogleMaps;
@import GooglePlaces;
@import Firebase;
@import Fabric;
@import UserNotifications;

@interface AppDelegate () <UNUserNotificationCenterDelegate>
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    UNUserNotificationCenter.currentNotificationCenter.delegate = self;
    
    [[UIApplication sharedApplication] registerForRemoteNotifications];
    
    UINavigationBar.appearance.tintColor = [[UIColor alloc] initWithRed:0.439 green:0.796 blue:0.412 alpha:1];
    
    NSString *e = [[SettingsManager sharedManager] currentAccountEmail];
    NSString *a = [[SDKManager sharedManager] currentAPIKey];
    
    if (e && a) {
        [[SDKManager sharedManager] startSDKWithAPIKey:[[SDKManager sharedManager] currentAPIKey] andSuccessHandler:^{} andFailureHandler:^(NSString *failureMessage) {}];
    }
    
    [GMSServices provideAPIKey:kMapsAPIKey];
    [GMSPlacesClient provideAPIKey:kMapsAPIKey];
    
    [FIRApp configure];
    [Fabric.sharedSDK setDebug:YES];
    return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [SGSDK saveCoreDataContext];
}


- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    completionHandler(UNNotificationPresentationOptionAlert);
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

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
    [self saveRemoteNotificationPayload:userInfo];
    [SGSDK didReceivePushNotificationPayload:userInfo withCompletionHandler:completionHandler];
    
    //PushReceived
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"PushReceived"
     object:self];
    
    if(application.applicationState == UIApplicationStateActive) {
        
        //app is currently active, can update badges count here
        
    } else if(application.applicationState == UIApplicationStateBackground){
        
        //app is in background, if content-available key of your notification is set to 1, poll to your backend to retrieve data and update your interface here
        
    } else if(application.applicationState == UIApplicationStateInactive){
        
        //app is transitioning from background to foreground (user taps notification), do what you need when user taps here
        
        self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        MasterTabViewController *masterController = [storyboard instantiateViewControllerWithIdentifier:@"MasterTabViewControllerIdentifier"];
        masterController.selectedIndex = 1;
        self.window.rootViewController = masterController;
        [self.window makeKeyAndVisible];
    }
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    
    // All instances of TestClass will be notified
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"didRegisterChanged"
     object:self];
}

-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"didRegisterChanged"
     object:self];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PushPermissionChanged" object:self];
}

- (void)showLoginScreen {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    WelcomeViewController *viewController = (WelcomeViewController *)[storyboard instantiateViewControllerWithIdentifier:@"welcomeView"];
    
    [[SettingsManager sharedManager] logout];
    [[SDKManager sharedManager] stopSDK];
    [self.window setRootViewController:viewController];
    [self.window makeKeyAndVisible];
}

- (void) saveRemoteNotificationPayload:(NSDictionary*) userInfo {
    [[SettingsManager sharedManager] saveRemoteNotificationPayload:userInfo];
}

@end
