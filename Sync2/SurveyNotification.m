//
//  SurveyNotification.m
//  Sync2
//
//  Created by Sanchit Mittal on 27/08/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import "SurveyNotification.h"

@implementation SurveyOption

- (instancetype)init: (NSString *)text optionId:(int)optionId
{
    self = [super init];
    if (self) {
        _text = text;
        _optionId = optionId;
    }
    return self;
}

@end

@implementation SurveyNotification

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
        
        if (payload[@"options"]) {
            self.options = @[];
            NSMutableArray *mutableArray = [self.options mutableCopy];
            for(id object in payload[@"options"]) {
                SurveyOption *option = [[SurveyOption alloc] init:object[@"text"] optionId:[object[@"id"] intValue]];
                [mutableArray addObject:option];
            }
            self.options = [mutableArray copy];
        } else {
            self.options = @[];
        }
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [super encodeWithCoder:encoder];
    [encoder encodeObject:self.buttonText forKey:@"buttonText"];
    [encoder encodeObject:self.submitUrl forKey:@"submitUrl"];
    [encoder encodeObject:self.options forKey:@"options"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super initWithCoder:decoder]) {
        self.buttonText = [decoder decodeObjectForKey:@"buttonText"];
        self.submitUrl = [decoder decodeObjectForKey:@"submitUrl"];
        self.options = [decoder decodeObjectForKey:@"options"];
    }
    return self;
}


@end
