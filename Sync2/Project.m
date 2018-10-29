//
//  Project.m
//  Sync2
//
//  Created by Ricky Kirkendall on 1/23/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import "Project.h"

@implementation Project

- (instancetype)initWithData:(NSDictionary *)data
{
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

-(NSDictionary *) toDictionary{
    
    if (!self.name || !self.objectId) {
        return nil;
    }
    
    return @{@"name":self.name,
             @"id":self.objectId};
}

@end
