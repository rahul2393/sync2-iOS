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
#define kEnvironmentIngressURL @"kEnvironmentIngressURL"

@implementation EnvironmentManager

+ (id)sharedManager {
    static EnvironmentManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}


- (void)setSelectedSenseURL:(NSString *)senseURL {
    [[NSUserDefaults standardUserDefaults] setObject:senseURL forKey:kEnvironmentSenseURL];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[SDKManager sharedManager] stopSDK];
    [[SettingsManager sharedManager] logout];
}

- (NSString *)selectedSenseURL {
    
    NSString *senseURL = [[NSUserDefaults standardUserDefaults] stringForKey:kEnvironmentSenseURL];
    if (senseURL) {
        return senseURL;
    }
    Environment *env = self.environments[0];
    [[SDKManager sharedManager] setIngressUrl:env.ingressURL];
    return env.senseURL;
}

- (void)setSelectedIngressURL:(NSString *)ingressURL {
    [[NSUserDefaults standardUserDefaults] setObject:ingressURL forKey:kEnvironmentIngressURL];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)selectedIngressURL {
    NSString *ingressURL = [[NSUserDefaults standardUserDefaults] stringForKey:kEnvironmentIngressURL];
    if (ingressURL) {
        return ingressURL;
    }
    Environment *env = self.environments[0];
    [[SDKManager sharedManager] setIngressUrl:env.ingressURL];
    return env.ingressURL;
}

- (id)init {
    if (self = [super init]) {
        
        Environment *prod = [[Environment alloc] init];
        prod.name = @"Production";
        prod.senseURL = @"https://sense-api.sixgill.com";
        prod.ingressURL = @"https://sense-ingress-api.sixgill.com";
        prod.forgotPasswordURL = @"https://dash.sixgill.com/request-password";
        
        Environment *staging = [[Environment alloc] init];
        staging.name = @"Staging";
        staging.senseURL = @"https://sense-api-node.staging.sixgill.io";
        staging.ingressURL = @"https://edge-ingress.staging.sixgill.io";
        staging.forgotPasswordURL = @"https://dashboard.staging.sixgill.io/request-password";
        
        Environment *rahulLocal = [[Environment alloc] init];
        rahulLocal.name = @"Staging";
        rahulLocal.senseURL = @"http://50abd0bf.ngrok.io";
        rahulLocal.ingressURL = @"http://c65e1db6.ngrok.io";
        
        self.environments = @[prod, staging, rahulLocal];
        
    }
    return self;
}


@end
