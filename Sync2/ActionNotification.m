//
//  ActionNotification.m
//  Sync2
//
//  Created by Sanchit Mittal on 27/08/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import "ActionNotification.h"

@implementation Action

- (instancetype)init: (NSString *)text actionId:(int)actionId type:(NSString *)type
{
    self = [super init];
    if (self) {
        _text = text;
        _actionId = actionId;
        _type = type;
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.text forKey:@"actionText"];
    [encoder encodeInt:self.actionId forKey:@"actionId"];
    [encoder encodeObject:self.type forKey:@"actionType"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.text = [decoder decodeObjectForKey:@"actionText"];
        self.actionId = [decoder decodeIntForKey:@"actionId"];
        self.type = [decoder decodeObjectForKey:@"actionType"];
    }
    return self;
}


@end

@implementation ActionNotification

- (instancetype)initWithPayload:(NSDictionary *)payload {
    
    self = [super initWithPayload:payload];
    
    if (self) {
        if (payload[@"actionTitle"]) {
            self.actionTitle = payload[@"actionTitle"];
        } else {
            self.actionTitle = @"";
        }
        
        if (payload[@"actions"]) {
            self.actions = @[];
            NSMutableArray *mutableArray = [self.actions mutableCopy];
            for (id object in payload[@"actions"]) {
                Action *action = [[Action alloc] init:object[@"text"] actionId:[object[@"actionId"] intValue] type:object[@"type"]];
                [mutableArray addObject:action];
            }
            self.actions = [mutableArray copy];
        } else {
            self.actions = @[];
        }
        
        if (payload[@"submitUrl"]) {
            self.submitUrl = payload[@"submitUrl"];
        } else {
            self.submitUrl = @"";
        }
    }

    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [super encodeWithCoder:encoder];
    [encoder encodeObject:self.actionTitle forKey:@"actionTitle"];
    [encoder encodeObject:self.actions forKey:@"actions"];
    [encoder encodeObject:self.submitUrl forKey:@"submitUrl"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super initWithCoder:decoder]) {
        self.actionTitle = [decoder decodeObjectForKey:@"actionTitle"];
        self.actions = [decoder decodeObjectForKey:@"actions"];
        self.submitUrl = [decoder decodeObjectForKey:@"submitUrl"];
    }
    return self;
}

@end
