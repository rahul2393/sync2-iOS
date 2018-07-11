//
//  EventQueuePolicy.h
//  SixgillSDK
//
//  Created by Ricky Kirkendall on 7/31/17.
//  Copyright © 2017 Sixgill. All rights reserved.
//

#ifndef EventQueuePolicy_h
#define EventQueuePolicy_h


#endif /* EventQueuePolicy_h */

enum {
    EventQueuePolicyDefault = 1,   // Default behavior is standard FIFO queue
    EventQueuePolicyJumpQueue = 2, // Jump queue is a modified FIFO where latest update is always first
    EventQueuePolicyLastUpdate = 3 // Only stores last update
};
typedef NSUInteger EventQueuePolicy;
