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
        NSDictionary *dataDictionary = payload[@"data"];
        
        if (dataDictionary[@"id"]) {
            self.notificationId = [dataDictionary[@"id"] integerValue];
        } else {
            self.notificationId = 0;
        }
        
        if (dataDictionary[@"title"]) {
            self.title = dataDictionary[@"title"];
        } else {
            self.title = @"";
        }
        
        if (dataDictionary[@"body"]) {
            self.body = dataDictionary[@"body"];
        } else {
            self.body = @"";
        }
        
        if (dataDictionary[@"timestamp"]) {
            self.timestamp = [dataDictionary[@"timestamp"] integerValue];
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
