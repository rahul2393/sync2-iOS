//
//  SGRuleCondition.m
//  Sync2
//
//  Created by Sanchit Mittal on 01/11/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import "SGRuleCondition.h"

@implementation SGRuleCondition

- (instancetype)initWithData:(NSDictionary *)data {
    
    self = [super init];
    
    if (self) {
        
        if (data[@"type"]) {
            self.type = data[@"type"];
        } else {
            self.type = @"";
        }
        
        if (data[@"items"]) {
            
            NSMutableArray<SGRuleCondition *> *condtions = [[NSMutableArray alloc] init];
            for (NSDictionary *c in data[@"items"]) {
                SGRuleCondition *condition = [[SGRuleCondition alloc] initWithData:c];
                [condtions addObject:condition];
            }
            
            self.items = condtions;
        } else {
            self.items = @[];
        }
        
        if (data[@"timezone"]) {
            self.timezone = data[@"timezone"];
        } else {
            self.timezone = @"";
        }
        
        if (data[@"ids"]) {
            self.ids = data[@"ids"];
        } else {
            self.ids = @[];
        }
        
        if (data[@"attribute"]) {
            self.attribute = data[@"attribute"];
        } else {
            self.attribute = @"";
        }
        
        if (data[@"channelId"]) {
            self.channelId = data[@"channelId"];
        } else {
            self.channelId = @"";
        }
        
        if (data[@"description"]) {
            self.objectDescription = data[@"description"];
        } else {
            self.objectDescription = @"";
        }
        
        if (data[@"trigger"]) {
            self.trigger = data[@"trigger"];
        } else {
            self.trigger = @"";
        }
        
        if (data[@"value"]) {
            self.value = data[@"value"];
        }
        
        if (data[@"operator"]) {
            self.operator = data[@"operator"];
        } else {
            self.operator = @"";
        }
        
    }
    return self;
}

@end
