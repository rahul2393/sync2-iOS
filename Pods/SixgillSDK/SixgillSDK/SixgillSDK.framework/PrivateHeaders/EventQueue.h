//
//  EventQueue.h
//  SixgillSDK
//
//  Created by Ricky Kirkendall on 5/16/17.
//  Copyright © 2017 Sixgill. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EventQueuePolicy.h"
@interface EventQueue : NSObject


-(instancetype)initWithQueuePolicy:(EventQueuePolicy)policy;

@property (nonatomic, readwrite) EventQueuePolicy queuePolicy;

-(void) add:(Event *)Event;
-(Event *) peek;
-(void) remove:(Event *)Event;
-(BOOL) isEmpty;
-(BOOL) eventIsExpired:(Event *)e;

-(NSArray *) data;

@end
