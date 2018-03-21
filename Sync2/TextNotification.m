//
//  TextNotification.m
//  Sync2
//
//  Created by Ricky Kirkendall on 1/23/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import "TextNotification.h"

@implementation TextNotification

- (instancetype)initWithPayload:(NSDictionary *)payload {
    NSDictionary *alertDictionary = payload[@"aps"];
    
    if (alertDictionary != nil) {
        NSString *alertMessage = alertDictionary[@"alert"];
        NSMutableArray<NSString *> *components = [[alertMessage componentsSeparatedByString:@"\n"] mutableCopy];
        if ([components count] > 1) {
            self = [super init];
            if (self) {
                _title = components[0];
                [components removeObjectAtIndex:0];
                _body = [components componentsJoinedByString:@"\n"];
                _date = [NSDate date];
            }
            
            return self;
        } else {
            return nil;
        }
    } else {
        return nil;
    }
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.title forKey:@"title"];
    [encoder encodeObject:self.body forKey:@"body"];
    [encoder encodeObject:self.date forKey:@"date"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.title = [decoder decodeObjectForKey:@"title"];
        self.body = [decoder decodeObjectForKey:@"body"];
        self.date = [decoder decodeObjectForKey:@"date"];
    }
    
    return self;
}

-(NSString *)displayableDate{
    
    if (!self.date) {
        return @"";
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    return [NSString stringWithFormat:@"%@", [formatter stringFromDate:self.date]];
}

@end
