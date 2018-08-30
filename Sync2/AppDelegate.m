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
#import "Landmark.h"
#import "WelcomeViewController.h"
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
    [self registerQuestionNotificationCategory];
    
    UINavigationBar.appearance.tintColor = [[UIColor alloc] initWithRed:0.439 green:0.796 blue:0.412 alpha:1];
    
    NSString *e = [[SettingsManager sharedManager] currentAccountEmail];
    NSString *a = [[SDKManager sharedManager] currentAPIKey];
    
    if (e && a) {
        [[SDKManager sharedManager] startSDKWithAPIKey: [[SDKManager sharedManager] currentAPIKey]];
    }
    
    [GMSServices provideAPIKey:kMapsAPIKey];
    [GMSPlacesClient provideAPIKey:kMapsAPIKey];
    
    [FIRApp configure];
    [Fabric.sharedSDK setDebug:YES];
    return YES;
}


-(void) registerQuestionNotificationCategory {
    
//    UNNotificationAction *acceptAction = [UNNotificationAction actionWithIdentifier:@"ACCEPT_ACTION" title:@"Accept" options:UNNotificationActionOptionAuthenticationRequired];
//    UNNotificationAction *declineAction = [UNNotificationAction actionWithIdentifier:@"DECLINE_ACTION" title:@"Decline" options:UNNotificationActionOptionAuthenticationRequired];
    
//    UNNotificationCategory *category = [UNNotificationCategory categoryWithIdentifier:@"question" actions:@[acceptAction, declineAction] intentIdentifiers:@[] options:UNNotificationCategoryOptionCustomDismissAction];
    
    
    UNNotificationCategory *informationCategory = [UNNotificationCategory categoryWithIdentifier:@"information" actions:@[] intentIdentifiers:@[] options:UNNotificationCategoryOptionNone];
    UNNotificationCategory *actionCategory = [UNNotificationCategory categoryWithIdentifier:@"action" actions:@[] intentIdentifiers:@[] options:UNNotificationCategoryOptionNone];
    UNNotificationCategory *feedbackCategory = [UNNotificationCategory categoryWithIdentifier:@"feedback" actions:@[] intentIdentifiers:@[] options:UNNotificationCategoryOptionNone];
    UNNotificationCategory *surveyCategory = [UNNotificationCategory categoryWithIdentifier:@"survey" actions:@[] intentIdentifiers:@[] options:UNNotificationCategoryOptionNone];
    UNNotificationCategory *scheduleCategory = [UNNotificationCategory categoryWithIdentifier:@"schedule" actions:@[] intentIdentifiers:@[] options:UNNotificationCategoryOptionNone];
    UNNotificationCategory *eventCategory = [UNNotificationCategory categoryWithIdentifier:@"event" actions:@[] intentIdentifiers:@[] options:UNNotificationCategoryOptionNone];
    
    NSSet *set = [[NSSet alloc] initWithObjects:informationCategory, actionCategory, feedbackCategory, surveyCategory, scheduleCategory, eventCategory, nil];
    [[UNUserNotificationCenter currentNotificationCenter] setNotificationCategories:set];
}

//- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler {
//
//    NSArray *notificationTypes = @[@"ACCEPT_ACTION", @"DECLINE_ACTION"];
//    NSInteger idx = [notificationTypes indexOfObject:response.actionIdentifier];
//
//    switch (idx) {
//        case 0: {
//            break;
//        }
//        default:
//            break;
//    }
//    completionHandler();
//}

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
