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
        NSDictionary *dataDictionary = payload[@"data"];
        if (dataDictionary[@"addressTitle"]) {
            self.addressTitle = dataDictionary[@"addressTitle"];
        } else {
            self.addressTitle = @"";
        }
        
        if (dataDictionary[@"address"]) {
            self.address = dataDictionary[@"address"];
        } else {
            self.address = @"";
        }
        
        if (dataDictionary[@"latitude"]) {
            self.latitude = dataDictionary[@"latitude"];
        } else {
            self.latitude = 0;
        }
        
        if (dataDictionary[@"longitude"]) {
            self.longitude = dataDictionary[@"longitude"];
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

