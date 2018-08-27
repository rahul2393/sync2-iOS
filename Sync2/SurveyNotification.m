//
//  SurveyNotification.m
//  Sync2
//
//  Created by Sanchit Mittal on 27/08/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import "SurveyNotification.h"

@implementation SurveyNotification

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
        
        if (dataDictionary[@"options"]) {
            self.options = dataDictionary[@"options"];
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
    
}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super initWithCoder:decoder]) {
        self.buttonText = [decoder decodeObjectForKey:@"buttonText"];
        self.submitUrl = [decoder decodeObjectForKey:@"submitUrl"];
        
    }
    return self;
}


@end
    "options": [{
        "id" : 0,
        "text" : "Black Coffee"
    },
    {
        "id" : 1,
        "text" : "Coldbrew Coffee"
    }],

