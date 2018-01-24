//
//  TextNotification.m
//  Sync2
//
//  Created by Ricky Kirkendall on 1/23/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import "TextNotification.h"

@implementation TextNotification

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
