//
//  ResourceManager.h
//  SixgillSDK
//
//  Created by Ricky Kirkendall on 12/16/16.
//  Copyright © 2016 Sixgill. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SGEventToken.h"

@protocol TaskManager

-(void) performTaskWithEventToken:(SGEventToken *)eventToken;

-(NSString *) resourceIdentifier;

@end

@protocol TaskResultDelegate

-(void) taskSuccessfullyCompletedWithManagerSignature:(id<TaskManager>)manager
                                                 data:(NSDictionary *)data
                                        andEventToken:(SGEventToken *)eventToken;

-(void) taskFailedWithManagerSignature:(id<TaskManager>)manager
                         andEventToken:(SGEventToken *)eventToken;
@end


@interface SGSensorManager : NSObject <TaskManager>

-(void) setSensorService:(id)sensorService;

// Task Manager Delegate

@property (nonatomic, weak) id<TaskResultDelegate> taskResultDelegate;
@property (nonatomic, strong) SGEventToken *eventToken;

// Abstract Task Manager Protocol

-(void) performTaskWithEventToken:(SGEventToken *)eventToken;

-(NSString *) resourceIdentifier;

@end
