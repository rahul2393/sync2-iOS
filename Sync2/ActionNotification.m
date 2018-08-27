//
//  ActionNotification.m
//  Sync2
//
//  Created by Sanchit Mittal on 27/08/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import "ActionNotification.h"

@implementation Action

- (instancetype)init: (NSString *)text actionId:(int *)actionId type:(NSString *)type
{
    self = [super init];
    if (self) {
        _text = text;
        _actionId = actionId;
        _type = type;
    }
    return self;
}

@end

@implementation ActionNotification

- (instancetype)initWithPayload:(NSDictionary *)payload {
    
    self = [super initWithPayload:payload];
    
    if (self) {
        NSDictionary *dataDictionary = payload[@"data"];
        if (dataDictionary[@"actionTitle"]) {
            self.actionTitle = dataDictionary[@"actionTitle"];
        } else {
            self.actionTitle = @"";
        }
        
        if (dataDictionary[@"actions"]) {
            for (id object in dataDictionary[@"actions"]) {
                Action *action = [[Action alloc] init:object[@"text"] actionId:[object[@"actionId"] integerValue] type:object[@"type"]];
//                self.actions
            }
        } else {
            self.actions = @[];
        }
        
        if (dataDictionary[@"submitUrl"]) {
            self.submitUrl = dataDictionary[@"submitUrl"];
        } else {
            self.submitUrl = @"";
        }
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [super encodeWithCoder:encoder];
    [encoder encodeObject:self.actionTitle forKey:@"actionTitle"];
    
    [encoder encodeObject:self.submitUrl forKey:@"submitUrl"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super initWithCoder:decoder]) {
        self.actionTitle = [decoder decodeObjectForKey:@"actionTitle"];
        
        self.submitUrl = [decoder decodeObjectForKey:@"submitUrl"];
    }
    return self;
}

@end
//    "actionId" : 786,
