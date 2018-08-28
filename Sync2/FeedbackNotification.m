//
//  FeedbackNotification.m
//  Sync2
//
//  Created by Sanchit Mittal on 27/08/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import "FeedbackNotification.h"

@implementation FeedbackNotification

- (instancetype)initWithPayload:(NSDictionary *)payload {
    
    self = [super initWithPayload:payload];
    
    if (self) {
        if (payload[@"commentHint"]) {
            self.commentHint = payload[@"commentHint"];
        } else {
            self.commentHint = @"";
        }
        
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
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [super encodeWithCoder:encoder];
    [encoder encodeObject:self.commentHint forKey:@"commentHint"];
    [encoder encodeObject:self.buttonText forKey:@"buttonText"];
    [encoder encodeObject:self.submitUrl forKey:@"submitUrl"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super initWithCoder:decoder]) {
        self.commentHint = [decoder decodeObjectForKey:@"actionTitle"];
        self.buttonText = [decoder decodeObjectForKey:@"buttonText"];
        self.submitUrl = [decoder decodeObjectForKey:@"submitUrl"];
    }
    return self;
}
@end
