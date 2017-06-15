//
//  Account.m
//  Sync2
//
//  Created by Ricky Kirkendall on 6/7/17.
//  Copyright © 2017 Sixgill. All rights reserved.
//

#import "Account.h"
#import "SettingsManager.h"
@implementation Account

-(void) populateFromDictionary:(NSDictionary *)d{
    self.accountId = d[dk_accountId];
    self.accountName = d[dk_accountName];
    self.apiKey = d[dk_apiKey];
}

-(NSDictionary *)toDictionary{
    
    if (!self.accountName) {
        self.accountName = @"";
    }
    
    if (!self.accountId) {
        self.accountId = @"";
    }
    
    if(!self.apiKey){
        self.apiKey = @"";
    }
    
    
    return @{dk_accountName:self.accountName,
             dk_apiKey:self.apiKey,
             dk_accountId:self.accountId};
}

-(BOOL)isActiveAccount{
    NSString *a = [[SettingsManager sharedManager] activeAccountId];
    if ([self.accountId isEqualToString:a]) {
        return YES;
    }
    
    return NO;
}

@end
