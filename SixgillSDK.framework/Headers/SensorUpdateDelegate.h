//
//  SensorUpdateDelegate.h
//  SixgillSDK
//
//  Created by Ricky Kirkendall on 6/14/17.
//  Copyright © 2017 Sixgill. All rights reserved.
//

#ifndef SensorUpdateDelegate_h
#define SensorUpdateDelegate_h

#import "Ingress.pbobjc.h"

@protocol SensorUpdateDelegate

-(void)sensorUpdateSentWithData:(Event *)sensorData;

@end

#endif /* SensorUpdateDelegate_h */
