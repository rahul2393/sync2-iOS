//
//  DataChannelData.m
//  Sync2
//
//  Created by Ricky Kirkendall on 1/17/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import "DummyChannelData.h"

@implementation DummyChannelData

+(NSString *) descriptionText{
    return @"Your device will register with a Data Channel that you select and send data into Sixgill Sense through it.\n\n We recommend selecting a Data Channel that corresponds to your Device type.";
}
+(NSArray *) channelTitles{
    return @[@"Golf Courses App",
             @"Pebble Beach App",
             @"City Planning"];
}

@end
