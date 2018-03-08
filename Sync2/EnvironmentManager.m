//
//  EnvironmentManager.m
//  Sync2
//
//  Created by Ricky Kirkendall on 3/8/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import "EnvironmentManager.h"

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
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:envIndex] forKey:kEnvironmentIxStore];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(NSInteger) selectedEnvironment{
    NSNumber *envIx = [[NSUserDefaults standardUserDefaults] objectForKey:kEnvironmentIxStore];
    return [envIx integerValue];
}

- (id)init {
    if (self = [super init]) {
        
        Environment *staging = [[Environment alloc] init];
        staging.name = @"Staging";
        staging.senseURL = @"http://sense-api-staging.sixgill.run";
        staging.ingressURL = @"";
        
        Environment *prod = [[Environment alloc] init];
        prod.name = @"Production";
        prod.senseURL = @"https://sense-api.sixgill.com";
        prod.ingressURL = @"";
        
        self.environments = @[staging, prod];
        
    }
    return self;
}


@end
