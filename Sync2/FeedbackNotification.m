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
        NSDictionary *dataDictionary = payload[@"data"];
        if (dataDictionary[@"commentHint"]) {
            self.commentHint = dataDictionary[@"commentHint"];
        } else {
            self.commentHint = @"";
        }
        
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
