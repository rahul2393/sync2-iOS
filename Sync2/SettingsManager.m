//
//  SettingsManager.m
//  Sync2
//
//  Created by Ricky Kirkendall on 6/7/17.
//  Copyright © 2017 Sixgill. All rights reserved.
//

#import "SettingsManager.h"
#import "SenseAPI.h"
#import "TextNotification.h"
#import "SDKManager.h"

#define KEY_HASONBOARDED @"hasOnboarded"

#define KEY_HASACCEPTEDAGREEMENT @"hasAcceptedAgreement"

#define KEY_ACCOUNTS @"accountsList"

#define KEY_ACTIVEACCOUNTID @"activeAccountId"

#define KEY_MAP_SHOWGEOFENCES @"showGeofences"

#define KEY_MAP_SHOWLAST5PTS @"showLast5pts"

#define KEY_AccountEmail @"accountEmail"

#define KEY_UserToken @"userToken"

#define KEY_UserOrgToken @"userOrgToken"

#define KEY_Notifications @"notifications"

#define KEY_SelectedProject @"selectedProject"
#define KEY_SelectedDataChannel @"selectedDataChannel"

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
    TextNotification *textNotification = [[TextNotification alloc] initWithPayload:payload];
    
    if (textNotification != nil) {
        NSMutableArray *savedNotifications = [[self savedRemoteNotificationPayloads] mutableCopy];
        [savedNotifications insertObject:textNotification atIndex:0];
        [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:savedNotifications] forKey:KEY_Notifications];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
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

-(void) logout{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:KEY_SelectedDataChannel];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:KEY_AccountEmail];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:KEY_UserToken];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:KEY_UserOrgToken];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:KEY_SelectedProject];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:KEY_ACTIVEACCOUNTID];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:KEY_Notifications];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[SDKManager sharedManager] clearSensorsData];
}

-(Project *) selectedProject{
    NSDictionary *d = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_SelectedProject];
    if (!d) {
        return nil;
    }
    
    Project *p = [[Project alloc]initWithData:d];
    
    return p;
}

-(void) selectProject:(Project *)project{
    [[NSUserDefaults standardUserDefaults] setObject:[project toDictionary] forKey:KEY_SelectedProject];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(DataChannel *) selectedDataChannel{
    NSDictionary *d = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_SelectedDataChannel];
    if (!d) {
        return nil;
    }
    
    DataChannel *dc = [[DataChannel alloc]initWithData:d];
    
    return dc;
}

-(void) selectDataChannel:(DataChannel *) dataChannel{
    [[NSUserDefaults standardUserDefaults] setObject:[dataChannel toDictionary] forKey:KEY_SelectedDataChannel];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[SenseAPI sharedManager]GetAPIKeys:^(NSArray *apiKeys, NSError * _Nullable error) {
        
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
