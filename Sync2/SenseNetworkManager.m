//
//  SenseNetworkManager.m
//  Sync2
//
//  Created by Ricky Kirkendall on 1/15/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import "SenseNetworkManager.h"

@implementation SenseNetworkManager

+ (id)sharedManager {
    static SenseNetworkManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init]) {
        //self.interface = [[TestNetworkInterface alloc] init];
    }
    return self;
}

@end
