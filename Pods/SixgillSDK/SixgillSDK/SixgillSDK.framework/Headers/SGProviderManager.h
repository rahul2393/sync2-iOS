//
//  SGProviderManager.h
//  SixgillSDK
//
//  Created by Sanchit Mittal on 23/11/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SGSensorManager.h"

@interface SGProviderManager : SGSensorManager<TaskManager>

// Singleton

+(id) sharedInstance;

// Task Manager Protocol
-(void) performTaskWithEventToken:(SGEventToken *)eventToken;

@end
