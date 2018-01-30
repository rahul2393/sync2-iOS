//
//  SGToken.m
//  Sync2
//
//  Created by Ricky Kirkendall on 1/29/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import "SGToken.h"

@implementation SGToken

- (instancetype)initWithData:(NSData *)data
{
    self = [super init];
    if (self) {
        
        self.token = @"";
        NSError *error = nil;
        id object = [NSJSONSerialization
                     JSONObjectWithData:data
                     options:0
                     error:&error];
        
        
        if ([object isKindOfClass:[NSDictionary class]]) {
            NSDictionary *responseDict = (NSDictionary *)object;
            if(responseDict[@"token"]){
                NSString *token = responseDict[@"token"];
                self.token = token;
            }
        }
    }
    return self;
}
@end
