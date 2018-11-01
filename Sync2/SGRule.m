//
//  SGRule.m
//  Sync2
//
//  Created by Ricky Kirkendall on 1/24/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import "SGRule.h"

@implementation SGRule

- (instancetype)initWithData:(NSDictionary *)data {
    
    self = [super init];
    
    if(self) {
        if (data[@"id"]) {
            self.objectId = data[@"id"];
        } else {
            self.objectId = @"";
        }
        
        if (data[@"projectId"]) {
            self.projectId = data[@"projectId"];
        } else {
            self.projectId = @"";
        }
        
        if (data[@"organizationId"]) {
            self.organizationId = data[@"organizationId"];
        } else {
            self.organizationId = @"";
        }
        
        if (data[@"name"]) {
            self.name = data[@"name"];
        } else {
            self.name = @"";
        }
        
        if (data[@"type"]) {
            self.type = data[@"type"];
        } else {
            self.type = @"";
        }
        
        if (data[@"tags"]) {
            self.tags = data[@"tags"];
        } else {
            self.tags = @[];
        }
        
        if (data[@"description"]) {
            self.ruledescription = data[@"description"];
        } else {
            self.ruledescription = @"";
        }
        
        if (data[@"actions"]) {
            self.actions = data[@"actions"];
        } else {
            self.actions = @[];
        }
        
        if (data[@"conditions"]) {
            self.conditions = data[@"conditions"];
        } else {
            self.conditions = @"";
        }
        
        if (data[@"conditionsObject"]) {
            NSMutableArray<SGRuleCondition *> *condtions = data[@"conditionsObject"];
            for (NSDictionary *c in condtions) {
                SGRuleCondition *condition = [[SGRuleCondition alloc] initWithData:c];
                [condtions addObject:condition];
            }
            
            self.conditionsObject = condtions;
        } else {
            self.conditionsObject = @[];
        }
        
        if (data[@"createdAt"]) {
            self.createdAt = [self displayableDate:data for:@"createdAt"];
        }
        
        if (data[@"updatedAt"]) {
            self.updatedAt = [self displayableDate:data for:@"updatedAt"];
        }
        
        if (data[@"generator"]) {
            self.generator = data[@"generator"];
        } else {
            self.generator = @"";
        }
        
        if (data[@"enabled"]) {
            self.enabled = data[@"enabled"];
        }
        
        if (data[@"channelIds"]) {
            self.channelIds = data[@"channelIds"];
        } else {
            self.channelIds = @[];
        }
    }
    
    return self;
    
}       

-(NSDate *)displayableDate:(NSDictionary *)data for:(NSString *)key {
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyyMMdd"];
    return [dateFormat dateFromString:data[key]];
    
}


@end
