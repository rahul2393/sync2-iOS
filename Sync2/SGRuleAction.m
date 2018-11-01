//
//  SGRuleAction.m
//  Sync2
//
//  Created by Sanchit Mittal on 01/11/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import "SGRuleAction.h"

@implementation SGRuleAction

- (instancetype)initWithData:(NSDictionary *)data {
    self = [super init];
    
    if (self) {
        if (data[@"message"]) {
            self.message = data[@"message"];
        } else {
            self.message = @"";
        }
        
        if (data[@"subject"]) {
            self.subject = data[@"subject"];
        } else {
            self.subject = @"";
        }
        
        if (data[@"type"]) {
            self.type = data[@"type"];
        } else {
            self.type = @"";
        }
        
        if (data[@"recipients"][@"emails"]) {
            self.emails = data[@"recipients"][@"emails"];
        }
        else {
            self.emails = @[];
        }
    }
    
    return self;
}


@end
