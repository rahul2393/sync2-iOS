//
//  SGMSQueue.h
//  SixgillSDK
//
//  Created by Ricky Kirkendall on 5/16/17.
//  Copyright © 2017 Sixgill. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SGMSQueuePolicy.h"
@interface SGMSQueue : NSObject


-(instancetype)initWithQueuePolicy:(SGMSQueuePolicy)policy;

@property (nonatomic, readwrite) SGMSQueuePolicy queuePolicy;


-(void) add:(SGMS *)sgms;
-(SGMS *) peek;
-(void) remove:(SGMS *)sgms;
-(BOOL) isEmpty;

-(NSArray *) data;

@end
