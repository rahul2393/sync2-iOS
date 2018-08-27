//
//  ScheduleNotification.h
//  Sync2
//
//  Created by Sanchit Mittal on 27/08/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseNotification.h"

@interface ScheduleNotification : BaseNotification

@property (nonatomic, strong) NSString *buttonText;
@property (nonatomic, strong) NSString *submitUrl;
@property (nonatomic, assign) int64_t startTimeStamp;
@property (nonatomic, assign) int64_t endTimeStamp;


@end
