//
//  Organization.m
//  Sync2
//
//  Created by Sanchit Mittal on 30/01/19.
//  Copyright © 2019 Sixgill. All rights reserved.
//

#import "Organization.h"

@implementation Organization

- (instancetype)initWithData:(NSDictionary *)data{
    self = [super init];
    if (self) {
        if (data[@"id"]) {
            self.objectId = data[@"id"];
        }
        else{
            self.objectId = @"";
        }
        if (data[@"name"]) {
            self.name = data[@"name"];
        }else{
            self.name = @"";
        }
    }
    return self;
}

- (NSDictionary *)toDictionary{
    if (!self.name || !self.objectId) {
        return nil;
    }
    
    return @{@"name":self.name,
             @"id":self.objectId};
}

@end
