//
//  SettingsManager.h
//  Sync2
//
//  Created by Ricky Kirkendall on 6/7/17.
//  Copyright © 2017 Sixgill. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SettingsManager : NSObject

+ (id)sharedManager;

-(BOOL) hasOnboarded;

-(void) setHasOnboarded:(BOOL)hasOnboarded;

@end
