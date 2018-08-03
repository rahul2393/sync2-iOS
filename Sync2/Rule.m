//
//  Rule.m
//  Sync2
//
//  Created by Ricky Kirkendall on 1/24/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import "Rule.h"

@implementation Rule

- (instancetype)initWithData:(NSDictionary *)data {
    
    self = [super init];
    
    if(self) {
        if (data[@"id"]) {
            self.objectId = data[@"id"];
        } else {
            self.objectId = @"";
        }
        
        if (data[@"name"]) {
            self.name = data[@"name"];
        } else {
            self.name = @"";
        }
        
        if (data[@"description"]) {
            self.ruledescription = data[@"description"];
        } else {
            self.ruledescription = @"";
        }
        
        if (data[@"enabled"]) {
            NSNumber *enabledN = data[@"enabled"];
            if (enabledN.integerValue == 0) {
                self.enabled = NO;
            } else {
                self.enabled = YES;
            }
        }
        
        if (data[@"actions"]) {
            self.actions = data[@"actions"];
        } else {
            self.actions = [[NSArray alloc] init];
        }
        
        
    }
    
    return self;
    
}

@end
