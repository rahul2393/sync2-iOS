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

#define kEnvironmentIxStore @"kEnvironmentIxStore"

@implementation EnvironmentManager

+ (id)sharedManager {
    static EnvironmentManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

-(void) setSelectedEnvironment:(NSInteger)envIndex{
    
    if (envIndex >= self.environments.count) {
        return;
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:envIndex] forKey:kEnvironmentIxStore];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    Environment *env = self.environments[envIndex];
    [[SDKManager sharedManager] setIngressUrl:env.ingressURL];
    [[SDKManager sharedManager] stopSDK];
    [[SettingsManager sharedManager] logout];
    
    
}

-(NSInteger) selectedEnvironment{
    NSNumber *envIx = [[NSUserDefaults standardUserDefaults] objectForKey:kEnvironmentIxStore];
    if (envIx) {
        return [envIx integerValue];
    }
    return 1;
}

- (id)init {
    if (self = [super init]) {
        
        Environment *staging = [[Environment alloc] init];
        staging.name = @"Staging";
        staging.senseURL = @"https://sense-api.sixgill.com";
        staging.ingressURL = @"https://sense-ingress-api.sixgill.com";
        
        Environment *prod = [[Environment alloc] init];
        prod.name = @"Production";
        prod.senseURL = @"http://sense-api-staging.sixgill.run";
        prod.ingressURL = @"http://sense-ingress-api-staging.sixgill.run";
        
        self.environments = @[staging, prod];
        
    }
    return self;
}


@end
