//
//  EnvironmentManager.m
//  Sync2
//
//  Created by Ricky Kirkendall on 3/8/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import "EnvironmentManager.h"
#import "SettingsManager.h"
#import "SDKManager.h"

#define kEnvironmentSenseURL @"kEnvironmentSenseURL"

@implementation EnvironmentManager

+ (id)sharedManager {
    static EnvironmentManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (void)setSelectedEnvironment:(NSString *)senseURL {

    [[NSUserDefaults standardUserDefaults] setObject:senseURL forKey:kEnvironmentSenseURL];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[SDKManager sharedManager] stopSDK];
    [[SettingsManager sharedManager] logout];
}

- (NSString *)selectedEnvironment {
    
    NSString *senseURL = [[NSUserDefaults standardUserDefaults] stringForKey:kEnvironmentSenseURL];
    if (senseURL) {
        return senseURL;
    }
    Environment *env = self.environments[1];
    [[SDKManager sharedManager] setIngressUrl:env.ingressURL];
    return env.senseURL;
}

- (id)init {
    if (self = [super init]) {
        
        Environment *staging = [[Environment alloc] init];
        staging.name = @"Staging";
        staging.senseURL = @"https://sense-api-node.staging.sixgill.io";
        staging.ingressURL = @"https://edge-ingress.staging.sixgill.io";
        
        Environment *prod = [[Environment alloc] init];
        prod.name = @"Production";
        prod.senseURL = @"https://sense-api.sixgill.com";
        prod.ingressURL = @"https://sense-ingress-api.sixgill.com";
        
        self.environments = @[staging, prod];
        
    }
    return self;
}


@end
