//
//  SettingsManager.m
//  Sync2
//
//  Created by Ricky Kirkendall on 6/7/17.
//  Copyright © 2017 Sixgill. All rights reserved.
//

#import "SettingsManager.h"
#import "SenseAPI.h"
#import "NotificationType.h"

#import "SDKManager.h"

#define KEY_HASONBOARDED @"hasOnboarded"

#define KEY_ONBOARDINGIDX @"onBoardingIdx"

#define KEY_HASACCEPTEDAGREEMENT @"hasAcceptedAgreement"

#define KEY_ACCOUNTS @"accountsList"

#define KEY_ACTIVEACCOUNTID @"activeAccountId"

#define KEY_MAP_SHOWGEOFENCES @"showGeofences"

#define KEY_MAP_SHOWLAST5PTS @"showLast5pts"

#define KEY_AccountEmail @"accountEmail"

#define KEY_UserToken @"userToken"

#define KEY_UserOrgToken @"userOrgToken"

#define KEY_Notifications @"notifications"

#define KEY_SelectedOrganization @"selectedOrganization"
#define KEY_SelectedDataChannel @"selectedDataChannel"
#define KEY_SelectedHailerChannel @"selectedHailerChannel"

#define SG_PUSH_CMD_FIELD @"data"

#define SG_PUSH_TYPE @"type"

#define SG_CMD_UPDATE_CONFIG @"UPDATE_CONFIG"
#define SG_CMD_SEND_SENSOR_DATA @"SEND_SENSOR_DATA"
#define SG_CMD_NOTIFY @"NOTIFY"


@implementation SettingsManager

+ (id)sharedManager {
    static SettingsManager *sharedMyManager = nil;
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

-(NSString *) currentAccountEmail{
    return [[NSUserDefaults standardUserDefaults] objectForKey:KEY_AccountEmail];
}

-(void) setCurrentAccountEmail:(NSString *)email{
    [[NSUserDefaults standardUserDefaults] setObject:email forKey:KEY_AccountEmail];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (SGToken *)currentUserToken {
    NSData *userData = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_UserToken];
    return [NSKeyedUnarchiver unarchiveObjectWithData:userData];
}

- (void)setCurrentUserToken:(SGToken *)userToken {
    NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:userToken];
    [[NSUserDefaults standardUserDefaults] setObject:encodedObject forKey:KEY_UserToken];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (SGToken *)currentUserOrgToken {
    NSData *userOrgData = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_UserOrgToken];
    return [NSKeyedUnarchiver unarchiveObjectWithData:userOrgData];
}

- (void)setCurrentUserOrgToken:(SGToken *)userOrgToken {
    NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:userOrgToken];
    [[NSUserDefaults standardUserDefaults] setObject:encodedObject forKey:KEY_UserOrgToken];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)saveRemoteNotificationPayload:(NSDictionary *)payload {
    
//    if (!payload[SG_PUSH_CMD_FIELD]) {
//        return;
//    }
//    
//    NSDictionary *data = payload[SG_PUSH_CMD_FIELD];
//    if (!data[SG_PUSH_TYPE]) {
//        return;
//    }
//    
//    NSString *type = data[SG_PUSH_TYPE];
//    
//    kNotificationType notificationType = [[[NotificationType alloc] init] notificationTypeFor:type];
//    
//    switch (notificationType) {
//        case INFORMATION: {
//            InformationNotification *informationNotification = [[InformationNotification alloc] initWithPayload:data];
//            if (informationNotification != nil) {
//                NSMutableArray *savedNotifications = [[self savedRemoteNotificationPayloads] mutableCopy];
//                [savedNotifications insertObject:informationNotification atIndex:0];
//                [self addRemoteNotificationPayloads:savedNotifications];
//            }
//            break;
//        }
//        case ACTION_NOTIFICATION: {
//            ActionNotification *actionNotification = [[ActionNotification alloc] initWithPayload:data];
//            if (actionNotification != nil) {
//                NSMutableArray *savedNotifications = [[self savedRemoteNotificationPayloads] mutableCopy];
//                [savedNotifications insertObject:actionNotification atIndex:0];
//                [self addRemoteNotificationPayloads:savedNotifications];
//            }
//            break;
//        }
//        case FEEDBACK: {
//            FeedbackNotification *feedbackNotification = [[FeedbackNotification alloc] initWithPayload:data];
//            if (feedbackNotification != nil) {
//                NSMutableArray *savedNotifications = [[self savedRemoteNotificationPayloads] mutableCopy];
//                [savedNotifications insertObject:feedbackNotification atIndex:0];
//                [self addRemoteNotificationPayloads:savedNotifications];
//            }
//            break;
//        }
//        case SURVEY: {
//            SurveyNotification *surveyNotification = [[SurveyNotification alloc] initWithPayload:data];
//            if (surveyNotification != nil) {
//                NSMutableArray *savedNotifications = [[self savedRemoteNotificationPayloads] mutableCopy];
//                [savedNotifications insertObject:surveyNotification atIndex:0];
//                [self addRemoteNotificationPayloads:savedNotifications];
//            }
//            break;
//        }
//        case SCHEDULE: {
//            ScheduleNotification *scheduleNotification = [[ScheduleNotification alloc] initWithPayload:data];
//            if (scheduleNotification != nil) {
//                NSMutableArray *savedNotifications = [[self savedRemoteNotificationPayloads] mutableCopy];
//                [savedNotifications insertObject:scheduleNotification atIndex:0];
//                [self addRemoteNotificationPayloads:savedNotifications];
//            }
//            break;
//        }
//        case EVENT: {
//            EventNotification *eventNotification = [[EventNotification alloc] initWithPayload:data];
//            if (eventNotification != nil) {
//                NSMutableArray *savedNotifications = [[self savedRemoteNotificationPayloads] mutableCopy];
//                [savedNotifications insertObject:eventNotification atIndex:0];
//                [self addRemoteNotificationPayloads:savedNotifications];
//            }
//            break;
//        }
//    }
}

- (NSArray *)savedRemoteNotificationPayloads {
    NSData *savedData = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_Notifications];
    
    if (savedData != nil) {
        NSArray *payloads = [NSKeyedUnarchiver unarchiveObjectWithData:savedData];
        if (payloads == nil) {
            return [NSArray array];
        }
        return payloads;
    } else {
        return [NSArray array];
    }
}
-(void) addRemoteNotificationPayloads: (NSMutableArray *) savedNotifications{
    [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:savedNotifications] forKey:KEY_Notifications];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void) logout{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:KEY_SelectedOrganization];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:KEY_SelectedDataChannel];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:KEY_SelectedHailerChannel];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:KEY_AccountEmail];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:KEY_UserToken];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:KEY_UserOrgToken];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:KEY_ACTIVEACCOUNTID];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:KEY_Notifications];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[SDKManager sharedManager] clearSensorsData];
}

- (Organization *)selectedOrganization{
    NSDictionary *d = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_SelectedOrganization];
    if (!d) {
        return nil;
    }
    
    Organization *o = [[Organization alloc] initWithData:d];
    
    return o;
}

- (void)selectOrganization:(Organization *)org withCompletionHandler:(void (^)(NSError * _Nullable))completionBlock{
    [[NSUserDefaults standardUserDefaults] setObject:[org toDictionary] forKey:KEY_SelectedOrganization];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[SenseAPI sharedManager] SetOrgId:org.objectId withCompletion:^(NSError * _Nullable error) {
        if (error) {
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:KEY_SelectedOrganization];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
        }
        completionBlock(error);
    }];
}

-(DataChannel *) selectedDataChannel{
    NSDictionary *d = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_SelectedDataChannel];
    if (!d) {
        return nil;
    }
    
    DataChannel *dc = [[DataChannel alloc]initWithData:d];
    
    return dc;
}

- (void)selectDataChannel:(DataChannel *)dataChannel withSuccessHandler:(void (^)(NSArray *, NSError * _Nullable))successBlock withFailureHandler:(void (^)())failureBlock{
    
    [[NSUserDefaults standardUserDefaults] setObject:[dataChannel toDictionary] forKey:KEY_SelectedDataChannel];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[SenseAPI sharedManager] GetAPIKeys:false withCompletion:^(NSArray *apiKeys, NSError * _Nullable error) {
        if (error) {
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:KEY_SelectedDataChannel];
            [[NSUserDefaults standardUserDefaults] synchronize];
            failureBlock();
        } else {
            successBlock(apiKeys, error);
        }
    }];
}

- (DataChannel *)selectedHailerChannel{
    NSDictionary *d = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_SelectedHailerChannel];
    if(!d) {
        return nil;
    }
    
    DataChannel *dc = [[DataChannel alloc] initWithData:d];
    
    return dc;
}

- (void)selectHailerChannel:(DataChannel *)dataChannel withSuccessHandler:(void (^)(NSArray *, NSError * _Nullable))successBlock withFailureHandler:(void (^)())failureBlock{
    
    [[NSUserDefaults standardUserDefaults] setObject:[dataChannel toDictionary] forKey:KEY_SelectedHailerChannel];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[SenseAPI sharedManager] GetAPIKeys:true withCompletion:^(NSArray *apiKeys, NSError * _Nullable error) {
        if (error) {
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:KEY_SelectedHailerChannel];
            [[NSUserDefaults standardUserDefaults] synchronize];
            failureBlock();
        } else {
            successBlock(apiKeys, error);
        }
    }];
}

-(BOOL) mapShowLast5Pts{
    return [[NSUserDefaults standardUserDefaults] boolForKey:KEY_MAP_SHOWLAST5PTS];
}
-(BOOL) mapShowGeofences{
    return [[NSUserDefaults standardUserDefaults] boolForKey:KEY_MAP_SHOWGEOFENCES];
}
-(void) setMapShowLast5Pts:(BOOL)show{
    [[NSUserDefaults standardUserDefaults] setBool:show forKey:KEY_MAP_SHOWLAST5PTS];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(void) setMapShowGeofences:(BOOL)show{
    [[NSUserDefaults standardUserDefaults] setBool:show forKey:KEY_MAP_SHOWGEOFENCES];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(BOOL) hasOnboarded{
    return [[NSUserDefaults standardUserDefaults] boolForKey:KEY_HASONBOARDED];
}

-(void) setHasOnboarded:(BOOL)hasOnboarded{
    [[NSUserDefaults standardUserDefaults] setBool:hasOnboarded forKey:KEY_HASONBOARDED];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSInteger)onBoardingIdx {
    return [[NSUserDefaults standardUserDefaults] integerForKey:KEY_ONBOARDINGIDX];
}

- (void)setOnBoardingIdx:(NSInteger)boardingIdx {
    [[NSUserDefaults standardUserDefaults] setInteger:boardingIdx forKey:KEY_ONBOARDINGIDX];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL)hasAcceptedAgreement {
    return [[NSUserDefaults standardUserDefaults] boolForKey:KEY_HASACCEPTEDAGREEMENT];
}

- (void)setHasAcceptedAgreement:(BOOL)hasAcceptedAgreement {
    [[NSUserDefaults standardUserDefaults] setBool:hasAcceptedAgreement forKey:KEY_HASACCEPTEDAGREEMENT];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(NSArray *) accounts{
    
    NSArray *a = [[NSUserDefaults standardUserDefaults] arrayForKey:KEY_ACCOUNTS];
    NSMutableArray *toReturn = [NSMutableArray array];
    for (NSDictionary *d in a) {
        Account *acc = [[Account alloc] init];
        [acc populateFromDictionary:d];
        [toReturn addObject:acc];
    }
    
    return toReturn;
}

-(void) addAccount:(Account *)account{
    NSArray *accounts = [[NSUserDefaults standardUserDefaults]arrayForKey:KEY_ACCOUNTS];
    NSMutableArray *toSave = [NSMutableArray arrayWithArray:accounts];
    [toSave addObject:[account toDictionary]];
    
    [[NSUserDefaults standardUserDefaults] setObject:toSave forKey:KEY_ACCOUNTS];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(NSString *)activeAccountId{
    return (NSString *)[[NSUserDefaults standardUserDefaults] objectForKey:KEY_ACTIVEACCOUNTID];
}

-(void) setActiveAccountId:(NSString *)accountId{
    [[NSUserDefaults standardUserDefaults] setObject:accountId forKey:KEY_ACTIVEACCOUNTID];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
