//
//  SGProviderManager.h
//  SixgillSDK
//
//  Created by Sanchit Mittal on 23/11/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SGSensorManager.h"
#import "SGAtlasDelegate.h"

@interface SGProviderManager : SGSensorManager<TaskManager>

@property (nonatomic, weak) id<SGAtlasDelegate> providerDelegate;

-(void) performTaskWithEventToken:(SGEventToken *)eventToken;

-(void)stopSensors;

@end
