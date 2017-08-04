//
//  SGMSQueuePolicy.h
//  SixgillSDK
//
//  Created by Ricky Kirkendall on 7/31/17.
//  Copyright © 2017 Sixgill. All rights reserved.
//

#ifndef SGMSQueuePolicy_h
#define SGMSQueuePolicy_h


#endif /* SGMSQueuePolicy_h */

enum {
    SGMSQueuePolicyDefault = 1,   // Default behavior is standard FIFO queue
    SGMSQueuePolicyJumpQueue = 2, // Jump queue is a modified FIFO where latest update is always first
    SGMSQueuePolicyLastUpdate = 3 // Only stores last update
};
typedef NSUInteger SGMSQueuePolicy;
