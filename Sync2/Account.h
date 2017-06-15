//
//  Account.h
//  Sync2
//
//  Created by Ricky Kirkendall on 6/7/17.
//  Copyright © 2017 Sixgill. All rights reserved.
//

#import <Foundation/Foundation.h>

#define dk_accountName @"accountName"
#define dk_apiKey @"apiKey"
#define dk_accountId @"accountId"

@interface Account : NSObject

@property (nonatomic, strong) NSString *accountName;
@property (nonatomic, strong) NSString *apiKey;
@property (nonatomic, strong) NSString *accountId;

-(NSDictionary *)toDictionary;


-(BOOL)isActiveAccount;
@end
