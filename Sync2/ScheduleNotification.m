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
        if (payload[@"buttonText"]) {
            self.buttonText = payload[@"buttonText"];
        } else {
            self.buttonText = @"";
        }
        
        if (payload[@"submitUrl"]) {
            self.submitUrl = payload[@"submitUrl"];
        } else {
            self.submitUrl = @"";
        }
        
        if (payload[@"startTimeStamp"]) {
            self.startTimeStamp = [payload[@"startTimeStamp"] integerValue];
        } else {
            self.startTimeStamp = 0;
        }

        if (payload[@"endTimeStamp"]) {
            self.endTimeStamp = [payload[@"endTimeStamp"] integerValue];
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
