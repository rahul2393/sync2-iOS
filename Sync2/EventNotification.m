//
//  EventNotification.m
//  Sync2
//
//  Created by Sanchit Mittal on 27/08/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import "EventNotification.h"

@implementation EventNotification

- (instancetype)initWithPayload:(NSDictionary *)payload {
    
    self = [super initWithPayload:payload];
    
    if (self) {
        if (payload[@"addressTitle"]) {
            self.addressTitle = payload[@"addressTitle"];
        } else {
            self.addressTitle = @"";
        }
        
        if (payload[@"address"]) {
            self.address = payload[@"address"];
        } else {
            self.address = @"";
        }
        
        if (payload[@"latitude"]) {
            self.latitude = payload[@"latitude"];
        } else {
            self.latitude = 0;
        }
        
        if (payload[@"longitude"]) {
            self.longitude = payload[@"longitude"];
        } else {
            self.longitude = 0;
        }
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [super encodeWithCoder:encoder];
    [encoder encodeObject:self.addressTitle forKey:@"addressTitle"];
    [encoder encodeObject:self.address forKey:@"address"];
    [encoder encodeObject:self.latitude forKey:@"latitude"];
    [encoder encodeObject:self.latitude forKey:@"longitude"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super initWithCoder:decoder]) {
        self.addressTitle = [decoder decodeObjectForKey:@"addressTitle"];
        self.address = [decoder decodeObjectForKey:@"address"];
        self.latitude = [decoder decodeObjectForKey:@"latitude"];
        self.longitude = [decoder decodeObjectForKey:@"longitude"];
    }
    
    return self;
}

@end

