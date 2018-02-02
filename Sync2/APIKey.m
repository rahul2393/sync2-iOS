//
//  APIKey.m
//  Sync2
//
//  Created by Ricky Kirkendall on 2/1/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import "APIKey.h"

@implementation APIKey

- (instancetype)initWithData:(NSDictionary *)apiDict
{
    self = [super init];
    if (self) {
        self.apiKey = apiDict[@"apiKey"];
        self.objectId = apiDict[@"id"];
    }
    return self;
}

-(NSDictionary *) toDictionary{
    return @{
             @"apiKey":self.apiKey,
             @"id":self.objectId
             };
}

@end
