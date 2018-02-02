//
//  SettingsManager.m
//  Sync2
//
//  Created by Ricky Kirkendall on 6/7/17.
//  Copyright © 2017 Sixgill. All rights reserved.
//

#import "SettingsManager.h"
#import "SenseAPI.h"
#define KEY_HASONBOARDED @"hasOnboarded"

#define KEY_ACCOUNTS @"accountsList"

#define KEY_ACTIVEACCOUNTID @"activeAccountId"

#define KEY_MAP_SHOWGEOFENCES @"showGeofences"

#define KEY_MAP_SHOWLAST5PTS @"showLast5pts"

#define KEY_SelectedProject @"selectedProject"
#define KEY_SelectedDataChannel @"selectedDataChannel"
#define KEY_ServerURL @"urlKey"

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
    return nil;
}

-(void) setAccountEmail:(NSString *)email{
    
}

-(NSString *)serverURL{
    return [[NSUserDefaults standardUserDefaults] objectForKey:KEY_ServerURL];
    
}
-(void)setServerURL:(NSString *)url{
    [[NSUserDefaults standardUserDefaults] setObject:url forKey:KEY_ServerURL];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void) logout{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:KEY_SelectedDataChannel];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:KEY_SelectedProject];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:KEY_ACTIVEACCOUNTID];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

-(void) associateAPIWithDataChannel{
    
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
