//
//  NetworkManager.m
//  Sync2
//
//  Created by Ricky Kirkendall on 6/7/17.
//  Copyright © 2017 Sixgill. All rights reserved.
//

#import "NetworkManager.h"
#import "TestNetworkInterface.h"

@implementation NetworkManager

+ (id)sharedManager {
    static NetworkManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init]) {
        self.interface = [[TestNetworkInterface alloc] init];
    }
    return self;
}

-(void) AccountForQRCodeId:(NSString *_Nonnull)qrCode withCompletion:(void ( ^ _Nullable )(NSDictionary * _Nullable accountData, NSError * _Nullable error))completed{
    
    [self.interface AccountForQRCodeId:qrCode withCompletion:^(NSDictionary * _Nullable accountData, NSError * _Nullable error) {
        completed(accountData, error);
    }];
    
}

@end
