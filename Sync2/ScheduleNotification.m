//
//  ScheduleNotification.m
//  Sync2
//
//  Created by Sanchit Mittal on 27/08/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import "ScheduleNotification.h"

@implementation ScheduleNotification

- (instancetype)initWithPayload:(NSDictionary *)payload {
    
    self = [super initWithPayload:payload];
    
    if (self) {
        NSDictionary *dataDictionary = payload[@"data"];
        if (dataDictionary[@"buttonText"]) {
            self.buttonText = dataDictionary[@"buttonText"];
        } else {
            self.buttonText = @"";
        }
        
        if (dataDictionary[@"submitUrl"]) {
            self.submitUrl = dataDictionary[@"submitUrl"];
        } else {
            self.submitUrl = @"";
        }
        
        if (dataDictionary[@"startTimeStamp"]) {
            self.startTimeStamp = [dataDictionary[@"startTimeStamp"] integerValue];
        } else {
            self.startTimeStamp = 0;
        }

        if (dataDictionary[@"endTimeStamp"]) {
            self.endTimeStamp = [dataDictionary[@"endTimeStamp"] integerValue];
        } else {
            self.endTimeStamp = 0;
        }
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [super encodeWithCoder:encoder];
    [encoder encodeObject:self.buttonText forKey:@"buttonText"];
    [encoder encodeObject:self.submitUrl forKey:@"submitUrl"];
    [encoder encodeInt64:self.startTimeStamp forKey:@"startTimeStamp"];
    [encoder encodeInt64:self.endTimeStamp forKey:@"endTimeStamp"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super initWithCoder:decoder]) {
        self.buttonText = [decoder decodeObjectForKey:@"buttonText"];
        self.submitUrl = [decoder decodeObjectForKey:@"submitUrl"];
        self.startTimeStamp = [decoder decodeInt64ForKey:@"startTimeStamp"];
        self.endTimeStamp = [decoder decodeInt64ForKey:@"endTimeStamp"];
    }
    return self;
}

@end
