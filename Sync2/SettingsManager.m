//
//  SettingsManager.m
//  Sync2
//
//  Created by Ricky Kirkendall on 6/7/17.
//  Copyright © 2017 Sixgill. All rights reserved.
//

#import "SettingsManager.h"

#define KEY_HASONBOARDED @"hasOnboarded"

#define KEY_ACCOUNTS @"accountsList"

#define KEY_ACTIVEACCOUNTID @"activeAccountId"

#define KEY_MAP_SHOWGEOFENCES @"showGeofences"

#define KEY_MAP_SHOWLAST5PTS @"showLast5pts"

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
