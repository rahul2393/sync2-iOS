//
//  SettingsManager.m
//  Sync2
//
//  Created by Ricky Kirkendall on 6/7/17.
//  Copyright © 2017 Sixgill. All rights reserved.
//

#import "SettingsManager.h"

#define KEY_HASONBOARDED @"hasOnboarded"

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

-(BOOL) hasOnboarded{
    return [[NSUserDefaults standardUserDefaults] boolForKey:KEY_HASONBOARDED];
}

-(void) setHasOnboarded:(BOOL)hasOnboarded{
    [[NSUserDefaults standardUserDefaults] setBool:hasOnboarded forKey:KEY_HASONBOARDED];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
