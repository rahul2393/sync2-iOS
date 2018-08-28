//
//  BaseNotification.m
//  Sync2
//
//  Created by Sanchit Mittal on 27/08/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import "BaseNotification.h"

@implementation BaseNotification

- (instancetype)initWithPayload:(NSDictionary *)payload {
    
    self = [super init];
    
    if (self) {
        if (payload[@"id"]) {
            self.notificationId = [payload[@"id"] integerValue];
        } else {
            self.notificationId = 0;
        }
        
        if (payload[@"title"]) {
            self.title = payload[@"title"];
        } else {
            self.title = @"";
        }
        
        if (payload[@"body"]) {
            self.body = payload[@"body"];
        } else {
            self.body = @"";
        }
        
        if (payload[@"timestamp"]) {
            self.timestamp = [payload[@"timestamp"] integerValue];
        } else {
            self.timestamp = 0;
        }
        
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeInteger:self.notificationId forKey:@"id"];
    [encoder encodeObject:self.title forKey:@"title"];
    [encoder encodeObject:self.body forKey:@"body"];
    [encoder encodeInt64:self.timestamp forKey:@"timestamp"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.notificationId = [decoder decodeIntegerForKey:@"id"];
        self.title = [decoder decodeObjectForKey:@"title"];
        self.body = [decoder decodeObjectForKey:@"body"];
        self.timestamp = [decoder decodeInt64ForKey:@"timestamp"];
    }
    
    return self;
}

@end
