//
//  EnvironmentManager.h
//  Sync2
//
//  Created by Ricky Kirkendall on 3/8/18.
//  Copyright © 2018 Sixgill. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Environment.h"
@interface EnvironmentManager : NSObject

+ (id)sharedManager;

@property (nonatomic, strong) NSArray *environments;

-(NSInteger) selectedEnvironment;
-(void) setSelectedEnvironment:(NSInteger)envIndex;

@end